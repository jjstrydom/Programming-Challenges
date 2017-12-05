// The nth term of the sequence of triangle numbers is given by, t_n = ½n(n+1); so the first ten triangle numbers are:
// 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
//
// By converting each letter in a word to a number corresponding to its alphabetical position and adding these values
// we form a word value. For example, the word value for SKY is 19 + 11 + 25 = 55 = t10. If the word value is a
// triangle number then we shall call the word a triangle word.
//
// Using words.txt (right click and 'Save Link/Target As...'), a 16K text file containing nearly two-thousand
// common English words, how many are triangle words?

var math = require('mathjs')
var fs  = require("fs");
var wordList = fs.readFileSync("p042_words.txt").toString().split('\",\"') // Read
var listLen = wordList.length;  // word list length
var c = 0;  // count variable

function removeDoubleQuotes(str) { // removes all " from a string
    var strArr = str.split("");  // convert string to array
    var newArr = [];  // build new string array
    var outStr = '';  // storage for output string
    for (i=0; i<str.length; i++) {  // go over each character
        if (strArr[i] != '\"') { // add character to output string if not a double quote
            newArr.push(strArr[i]);
        }
    }
    outStr = newArr.join(""); // convert the char array to a string
    return outStr;
}

function calcScore(word) {  // Calculate the word score, assuming a word with CAPS alphabetical letters only
    var subtVal = 64;  // the value to subtract fomr the ascii value to get the alphabet value
    var wordLen = word.length; // length of this word
    var wordArr = word.split("");  // convert string to array
    var wordScore = 0;  // initiate score variable
    for (i=0; i<(wordLen); i++)  {  // loop over all characters
        wordScore = wordScore + wordArr[i].charCodeAt(0)-subtVal;  // calculate and sum the word score
    }
    return wordScore
}

function isTriangleNumber(tn) {  // test if a number is a triangle number
    var n = 0;
    n = math.sqrt(2*tn+0.25)-0.5  // solving the euqation t_n = ½n(n+1) for n
    if (n == math.round(n)) {  // if n is an integer then it is a triangle number
        return true
    }
    return false
}

// Based on our file read strategy, the first and last word will have a remaining ", remove it
wordList[0] = removeDoubleQuotes(wordList[0]);
wordList[listLen-1] = removeDoubleQuotes(wordList[listLen-1]);

// loop over all words, count it if it is a triangle number
for (k=0; k<listLen; k++) {
    wordScore = calcScore(wordList[k])  // get word score
    if (isTriangleNumber(wordScore)) { // test if triangle number
        c = c + 1  // if triangle number count it!
    }
}

console.log("Number of triangle words in file:", c)
