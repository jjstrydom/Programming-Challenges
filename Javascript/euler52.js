// It can be seen that the number, 125874, and its double, 251748, contain exactly the same digits, but in a different order.
// Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain the same digits.

var x2tox6 = [0,0,0,0,0];
var c = 0;
var found = false
var x = 0;

function sameDigitTest(arr) {
    var arrLen = arr.length
    var strArr = ''
    var blankArr = [0,0,0,0,0,0,0,0,0,0];  // blank array
    var countArr = blankArr.slice();  // start with zeros for all digits from 0 to 9
    var prevArr = blankArr.slice();  // array that stores the previosu count array
    var idx = 0;  // index in countArr (converting string value to array position)
    for (j=0; j<arr.length; j++) {  // loop over all the numbers in the array
        strArr = arr[j].toString().split("");  // convert number to string array
        prevArr = countArr.slice();  // copy the count array
        countArr = blankArr.slice();  // clear the count array
        for (k=0; k<strArr.length; k++) {  // loop over the string
            idx = parseInt(strArr[k]);  // convert string value to array position
            countArr[idx] = countArr[idx] + 1;  // count the digit
        }
        if (j > 0) { // when we have two to compare
            for (k=0; k<countArr.length; k++) {  // loop over the string
              // testing only to previous, as we can only reach j > x when all prevous j <= x matched
              // i.e. if j = 0 matches j = 1 and j = 2 matches j = 1 then j = 0 matches j = 2
                if (countArr[k] != prevArr[k]) { // test if this string matches previous one
                    return false  // if they dont match then they dont have the same digits
                }
            }
        }
    }
    return true  // if we manage to pass all the tests above we have a pandigital
}

function numberLenEqualTest(num1,num2) {  // check if two numbers are of equal length
    var num1Str = num1.toString();  // convert numbers to strings
    var num2Str = num2.toString();
    if (num1Str.length == num2Str.length) {  // test lengths
        return true
    }
    return false
}

while (found == false) {  // continue until we find the number
    c = c + 1  // search for this number (c = x in the problem)
    for (i=2;i<=6;i++) {
        x2tox6[i-2] = c*i  // calculate the 2x, 3x, ... 6x multiples and store them in an array
    }
    if (numberLenEqualTest(x2tox6[0],x2tox6[4])) {  // if the first and last numbers are of equal length, then everything in between will have that length as well
        if (sameDigitTest(x2tox6) == true) {  // test if they have the same digits
            found = true  // if they have the same digits we found the answer!
        }
    }
}

console.log("The value for x is:", c)
