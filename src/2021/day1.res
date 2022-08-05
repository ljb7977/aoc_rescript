let read_from_file = filename => filename->Node.Fs.readFileAsUtf8Sync->Js.String2.split("\n")

let solution = arr => {
  let len = arr->Belt.Array.length
  let arr1 = arr->Belt.Array.slice(~offset=1, ~len)
  let arr2 = arr->Belt.Array.slice(~offset=0, ~len=len - 1)
  Belt.Array.zip(arr1, arr2)->Belt.Array.keep(((v1, v2)) => {v1 - v2 > 0})->Belt.Array.length
}

// Part 1
let lines = read_from_file("day1_input.txt")
let numbers = lines->Belt.Array.map(Belt.Int.fromString)->Belt.Array.map(Belt.Option.getExn)
let count = solution(numbers)
Js.log(count)

// Part 2
let len = numbers->Js.Array.length
let window_sum =
  Belt.Array.range(0, len - 3)->Belt.Array.map(i =>
    Belt.Array.getUnsafe(numbers, i) +
    Belt.Array.getUnsafe(numbers, i + 1) +
    Belt.Array.getUnsafe(numbers, i + 2)
  )
let count = solution(window_sum)
Js.log(count)
