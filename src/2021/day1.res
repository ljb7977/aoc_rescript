let read_from_file = (filename) => {
    let input = Node.Fs.readFileAsUtf8Sync(filename)
    Js.String.split("\n", input)
}

let lines = read_from_file("input.txt")
let numbers = Js.Array.map(Belt.Int.fromString, lines)
let numbers = Js.Array.map(Belt.Option.getExn, numbers)
let numbers1 = Belt.Array.sliceToEnd(numbers, 1)
let numbers2 = Belt.Array.slice(numbers, ~offset=0, ~len=Js.Array.length(numbers)-1)
let pairs = Belt.Array.zip(numbers1, numbers2)
let diffs = Js.Array.map(((v1, v2)) => {(v1-v2) > 0}, pairs)
let counts = Js.Array.filter(v => v, diffs)
Js.log(Js.Array.length(counts))
