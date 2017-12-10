# The following iterative sequence is defined for the set of positive integers:
#
# n → n/2 (n is even)
# n → 3n + 1 (n is odd)
#
# Using the rule above and starting with 13, we generate the following sequence:
#
# 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
# It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms.
# Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.
#
# Which starting number, under one million, produces the longest chain?
#
# NOTE: Once the chain starts the terms are allowed to go above one million.

function next_num(num)
    # function generates the next number in the sequence
    if num % 2 == 0  # if even
        num = num/2  # divide by two
    else  # the number is uneven
        num = 3*num + 1  # multiply the number by 3 and add one
    end
    return num  # return the next number in the sequence
end

function seq_len(num)
    # function calculates the sequence length
    k = 1  # the sequence length includes the starting number (thus count from 1)
    while num != 1  # continue to count the sequence length until it ends at 1
        k = k + 1  # increase the sequence length
        num = next_num(num)  # get the next number in the sequence
    end
    return k  # return the sequence length
end

n = 1e6  # the upper limit for the problem
largest = 0  # initialize the largest value variable
start_num = 0  # initialize the starting number variable

for k = 2:n  # test all possibilities below the given upper limit
    seql = seq_len(k)  # get the sequence length for this number
    if seql > largest  # if the sequence length is larger than the previous largest sequence length
        largest = seql  # save it as the largest sequence length
        start_num = k  # save the number that resulted in this sequence length
    end
end

# print resutls
print("Result: ", start_num, '\n')
print("Seqeunce length: ", largest, '\n')
