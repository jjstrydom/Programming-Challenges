// Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing over five-thousand first names,
// begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this value
// by its alphabetical position in the list to obtain a name score.
//
// For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th
// name in the list. So, COLIN would obtain a score of 938 × 53 = 49714.
//
// What is the total of all the name scores in the file?

var fs  = require("fs");
var nameList = fs.readFileSync("p022_names.txt").toString().split(',').sort(); // Read names from the file and sort them (all names are on the same line, comma separated)
var listLen = nameList.length;  // number of names to calculate over
var totalScore = 0;  // score storage

function calcScore(name) {  // Calculate the name score, skipping the quotes surrounding each name
    var subtVal = 64;  // the value to subtract fomr the ascii value to get the alphabet value
    var nameLen = name.length; // length of this name with quotes
    var nameArr = name.split("");  // convert string to array
    var nameScore = 0;  // initiate score variable
    for (i=1; i<(nameLen-1); i++)  {  // loop over all non " characters
        nameScore = nameScore + nameArr[i].charCodeAt(0)-subtVal;  // calculate and sum the name score
    }
    return nameScore
}

for (k=0; k<(listLen); k++) {
    totalScore = totalScore + (k+1)*calcScore(nameList[k]);  // Calculate score based on name score and list position, sum to obtain total score
}

console.log("Sum of all name scores in file: ",totalScore)
