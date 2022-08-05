let read_from_file = filename => filename->Node.Fs.readFileAsUtf8Sync->Js.String2.split("\n")

type cell = {
  value: int,
  is_marked: bool,
}

let rec parse_boards = (lines, result) => {
  switch lines {
  | [] => result
  | lines => {
      let board_lines =
        lines
        ->Belt.Array.slice(~offset=1, ~len=5)
        ->Belt.Array.map(line =>
          line
          ->Js.String2.trim
          ->Js.String2.splitByRe(%re("/\s+/"))
          ->Belt.Array.map(v => {
            let number = v->Belt.Option.getExn->Belt.Int.fromString->Belt.Option.getExn
            {value: number, is_marked: false}
          })
        )
      let _ = Js.Array2.push(result, board_lines)
      parse_boards(Belt.Array.sliceToEnd(lines, 6), result)
    }
  }
}

let lines = read_from_file("day4_input.txt")
let draws =
  lines
  ->Js.Array.shift
  ->Belt.Option.getExn
  ->Js.String2.split(",")
  ->Belt.Array.map(v => v->Belt.Int.fromString->Belt.Option.getExn)
let boards = parse_boards(lines, [])
Js.log(draws)
Js.log(boards[0])
// Parsing Done

let mark_board = (board, number) => {
  board->Belt.Array.map(line => {
    line->Belt.Array.map(({value, is_marked}) => {
      if value == number {
        {value: value, is_marked: true}
      } else {
        {value: value, is_marked: is_marked}
      }
    })
  })
}

let get_all_unmarked_numbers = (board: array<array<cell>>) => {
  board
  ->Belt.Array.concatMany
  ->Belt.Array.keep(({is_marked}) => !is_marked)
  ->Belt.Array.reduce(0, (acc, {value}) => acc + value)
}

// 가로, 세로, 대각선이 모두 is_marked가 true인지 판별한다.
let check_board = (board: array<array<cell>>) => {
  let horizontal = Belt.Array.makeBy(5, i => i)->Belt.Array.map(i => {
    Belt.Array.makeBy(5, j => j)->Belt.Array.map(j => {
      board[i][j]
    })
  })
  let vertical = Belt.Array.makeBy(5, j => j)->Belt.Array.map(j => {
    Belt.Array.makeBy(5, i => i)->Belt.Array.map(i => {
      board[i][j]
    })
  })
  let diagonal1 = Belt.Array.makeBy(5, i => i)->Belt.Array.map(i => {
    board[i][i]
  })
  let diagonal2 = Belt.Array.makeBy(5, i => i)->Belt.Array.map(i => {
    board[i][4 - i]
  })
  let target_cells =
    horizontal
    ->Belt.Array.concat(vertical)
    ->Belt.Array.concat([diagonal1])
    ->Belt.Array.concat([diagonal2])
  let is_bingo =
    target_cells->Belt.Array.some(cells => {cells->Belt.Array.every(({is_marked}) => is_marked)})
  switch is_bingo {
  | false => None
  | true => Some(get_all_unmarked_numbers(board))
  }
}

exception No_Bingos
exception Too_Many_Answers

let rec step = (draws, boards) => {
  switch draws {
  | [] => raise(No_Bingos)
  | draws => {
      let draw = draws[0]
      let new_boards = boards->Belt.Array.map(board => mark_board(board, draw))
      let check_result = new_boards->Belt.Array.keepMap(check_board)
      switch check_result {
      | [] => step(Belt.Array.sliceToEnd(draws, 1), new_boards)
      | [answer] => answer * draw
      | _ => raise(Too_Many_Answers)
      }
    }
  }
}

Js.log(step(draws, boards))
