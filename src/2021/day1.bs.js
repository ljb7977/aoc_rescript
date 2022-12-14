// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Fs = require("fs");
var Belt_Int = require("rescript/lib/js/belt_Int.js");
var Belt_Array = require("rescript/lib/js/belt_Array.js");
var Belt_Option = require("rescript/lib/js/belt_Option.js");

function read_from_file(filename) {
  return Fs.readFileSync(filename, "utf8").split("\n");
}

function solution(arr) {
  var len = arr.length;
  var arr1 = Belt_Array.slice(arr, 1, len);
  var arr2 = Belt_Array.slice(arr, 0, len - 1 | 0);
  return Belt_Array.keep(Belt_Array.zip(arr1, arr2), (function (param) {
                return (param[0] - param[1] | 0) > 0;
              })).length;
}

var lines = Fs.readFileSync("day1_input.txt", "utf8").split("\n");

var numbers = Belt_Array.map(Belt_Array.map(lines, Belt_Int.fromString), Belt_Option.getExn);

var count = solution(numbers);

console.log(count);

var len = numbers.length;

var window_sum = Belt_Array.map(Belt_Array.range(0, len - 3 | 0), (function (i) {
        return (numbers[i] + numbers[i + 1 | 0] | 0) + numbers[i + 2 | 0] | 0;
      }));

var count$1 = solution(window_sum);

console.log(count$1);

exports.read_from_file = read_from_file;
exports.solution = solution;
exports.lines = lines;
exports.numbers = numbers;
exports.len = len;
exports.window_sum = window_sum;
exports.count = count$1;
/* lines Not a pure module */
