# 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
#
# Find the sum of all numbers which are equal to the sum of the factorial of their digits.
#
# Note: as 1! = 1 and 2! = 2 are not sums they are not included.

function num2digits(number)
    # converts a number to an array of digits of that number
    l = Int(ceil(log10(number)))  # the length of the number
    arr = zeros(Int,l)  # create array
    for k = 1:l  # for each digit in the number
        digit = number%10  # extract the last digit of the number
        number = Int((number-digit)/10)  # create a number from remaining digits
        arr[l-k+1] = digit  # store the didit in the array (backwards)
    end
    return arr  # return array of digits
end

function factorialSum(digits)
    # calculate the factorial sum of the digits
    s = 0  # initialize the sum variable
    for k = 1:size(digits,1)  # for each digit
        s = s + factorial(digits[k])  # calculate factorial and sum
    end
    return s  # return factorial sum
end

# calculate the largest number we should search to
# each extra digit increases the number value by 10, while each digit can maximally
# increase the search space by 9!, thus at some point the number length
# will always be more than the maximum possible sum of the factorials of that length
l = 1
while 10^(l-1)-1 < factorial(9)*l
    l = l + 1
end

total_fs = 0  # initialize the total factorial sum counter
for k = 10:factorial(9)*l  # search for all numbers up to the maximum calculated above
    dig = num2digits(k)  # convert the number to digits
    dig_fs = factorialSum(dig)  # calculate the factorial sum of the digits
    if k == dig_fs  # if the factorial sum equals the digits
        total_fs = total_fs + k  # add it the total factorial sum
    end
end

# print the result
println("Result: ",total_fs)
