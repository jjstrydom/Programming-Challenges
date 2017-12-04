// We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once;
// for example, the 5-digit number, 15234, is 1 through 5 pandigital.
//
// The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand, multiplier, and product is 1 through 9 pandigital.
//
// Find the sum of all products whose multiplicand/multiplier/product identity can be written as a 1 through 9 pandigital.
//
// HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.

var products = [];  // array to store all the found pandigital products to test for duplicates
var productSum = 0;  // prodcut sum if not a duplicate
var mmp = '';  // multiplicand/multiplier/product in string format
var counted = false;  // variable to flag if pandigital products is in products list

function mmpString(a,b,c) {
    // Convert multiplicand/multiplier/product integers to strings for string operations
    return a.toString().concat(b.toString().concat(c.toString()));
}

function mmpPandigitalTest(str) {  // Assumes the input string is of length 9
    // test if we have a pandigital - takes a string as input with multiplicand/multiplier/product concatenated
    var strArr = str.split("");  // convert string to array
    var padArr = [0,0,0,0,0,0,0,0,0];  // start with zeros for all digits from 1 to 9
    var test = true;  // varialbe that stores pandigital property
    var idx = 0;  // index in padArr (converting string value to array position)
    for (k=0; k<str.length; k++) {  // loop over the string
        if (strArr[k] == '0') {  // if any value is 0 then we dont have a pandigital as 0 is not part of it
            test = false;
            break;
        }
        idx = parseInt(strArr[k])-1;  // convert string value to array position
        padArr[idx] = padArr[idx] + 1;  // count the digit
        if (padArr[idx] > 1) {  // if we have more than 1 of that digit we dont have a pandigital
            test = false;
            break
        }
    }
    return test  // if we manage to pass all the tests above we have a pandigital
}

for (i=1; i<10000; i++) { // 1 * 9999 = 9999 is the max value for i to create at least a length 9 multiplicand/multiplier/product
    for (j=1; j<10000; j++) {  // 9999 * 1 = 9999 is the max value for j to create at least a length 9 multiplicand/multiplier/product
        prod = i*j;  // calculate the prodcut from i = multiplicand and j = multiplier
        mmp = mmpString(i,j,prod); // convert these values to a concatenated string
        if (mmp.length > 9) {  // if this string is larger than 9 then an larger value of j will not result in a string of 9 or less
            break  // so stop there and increase i - this saves a significant ammount of computational time
        }
        if ((mmp.length == 9) && mmpPandigitalTest(mmp)) { // if length is 9 - test if pandigital, if both true test if we already have it
            counted = false;  // assume we this is a new pandigital
            for (l=0; l<products.length; l++) {  // go through all past pandigitals
                if (products[l] == prod) {  // if it exists in our list, we have counted it
                    counted = true;
                    break
                }
            }
            if (counted == false) {  // if we have not counted this pandigital yet
                products.push(prod);  // add it to our list of pandigitals
                productSum = productSum + prod // sum it to obtain the pandigital product sum
            }
        }
    }
}
console.log("Number of unique pandigital products found:", products.length)
console.log("The sum of the unique pandigital products are:", productSum)
