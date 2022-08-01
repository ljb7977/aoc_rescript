let read_from_file = (filename) => {
    let input = Node.Fs.readFileAsUtf8Sync(filename)
    Js.String.split("\n", input)
}

let lines = read_from_file("input.txt")
let numbers = lines
                ->Belt.Array.map(Belt.Int.fromString)
                ->Belt.Array.map(Belt.Option.getExn)
let numbers1 = numbers -> Belt.Array.sliceToEnd(1)
let numbers2 = numbers -> Belt.Array.slice(~offset=0, ~len=Js.Array.length(numbers)-1)
let count = Belt.Array.zip(numbers1, numbers2) 
        -> Belt.Array.keep(((v1, v2)) => {(v1-v2 > 0)})
        -> Belt.Array.length
Js.log(count)
