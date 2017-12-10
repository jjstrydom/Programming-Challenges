# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
# Find the largest palindrome made from the product of two 3-digit numbers.

function isPalindrome(number)
# function tests if a number is the same when read forwards and backwards
    a = dec(number)  # convert the number to a string
    b = a[end:-1:1]  # inverse the string
    if a == b  # if the string is equal to its inverse
        return true  # this is a palindrome
    end
    return false # otherwise it is not a palindrome
end

largest = 0  # storage for the largest found palindrome
dig_len = 3  # length of digits to test for
lar_dig_u = 10^dig_len-1  # largest possible number of length dig_len
lar_dig_l = 10^(dig_len-1)  # smallest possible number of length dig_len

for dig1 = lar_dig_u:-1:lar_dig_l  # go through all possibilities for the firt digit starting with largest number
# we can stop this process if digit 1 times the largest possible value for digit 2
# is less than the largest found palindrome. All subsequent numbers will be less and
# thus we are wasting computation in testing them
    if dig1*lar_dig_u < largest
        break
    end
    for dig2 = lar_dig_u:-1:lar_dig_l  # loop through all posibilities for second digit starting with largest number
        num2test = dig1*dig2  # number to test if a palindrome
        # since digit 2 counts down, if the number to test is less than the largest found
        # palindrome stop the loop, all following numbers to test will be smaller and thus
        # a waste of computation
        if num2test <= largest
            break
        end
        # test if number to test is larger than the largest found palindrome AND
        # if the number is a palindrome. We can technically leave the test for largest
        # as it is performed in the line above, and we can only reach this point
        # if it is larger, however this code may change in the future, and it is
        # relatively inexpensive to re-test here to avoid future potential bugs.
        if num2test > largest && isPalindrome(num2test)
            largest = num2test
        end
    end
end

# Print the answer
print("Result: ", largest)
