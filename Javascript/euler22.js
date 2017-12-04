// Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing over five-thousand first names,
// begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this value
// by its alphabetical position in the list to obtain a name score.
//
// For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th
// name in the list. So, COLIN would obtain a score of 938 × 53 = 49714.
//
// What is the total of all the name scores in the file?

var fs  = require("fs");
var nameList = fs.readFileSync("p022_names.txt").toString().split(',').sort();
var listLen = nameList.length;
var totalScore = 0;

var charLen = nameList.length;

function calcScore(name) {
    var subtVal = 64;
    var nameLen = name.length;
    var nameArr = name.split("");
    var nameScore = 0;
    for (i=1; i<(nameLen-1); i++)  {
        nameScore = nameScore + nameArr[i].charCodeAt(0)-subtVal;
    }
    return nameScore
}

for (k=0; k<(listLen); k++) {
    totalScore = totalScore + (k+1)*calcScore(nameList[k]);
}

console.log("Sum of all name scores in file: ",totalScore)
