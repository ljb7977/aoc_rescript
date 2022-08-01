// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Fs = require("fs");
var Belt_Int = require("rescript/lib/js/belt_Int.js");
var Belt_Array = require("rescript/lib/js/belt_Array.js");
var Belt_Option = require("rescript/lib/js/belt_Option.js");

function read_from_file(filename) {
  var input = Fs.readFileSync(filename, "utf8");
  return input.split("\n");
}

var lines = read_from_file("input.txt");

var numbers = lines.map(Belt_Int.fromString);

var numbers$1 = numbers.map(Belt_Option.getExn);

var numbers1 = Belt_Array.sliceToEnd(numbers$1, 1);

var numbers2 = Belt_Array.slice(numbers$1, 0, numbers$1.length - 1 | 0);

var pairs = Belt_Array.zip(numbers1, numbers2);

var diffs = pairs.map(function (param) {
      return (param[0] - param[1] | 0) > 0;
    });

var counts = diffs.filter(function (v) {
      return v;
    });

console.log(counts.length);

exports.read_from_file = read_from_file;
exports.lines = lines;
exports.numbers = numbers$1;
exports.numbers1 = numbers1;
exports.numbers2 = numbers2;
exports.pairs = pairs;
exports.diffs = diffs;
exports.counts = counts;
/* lines Not a pure module */
