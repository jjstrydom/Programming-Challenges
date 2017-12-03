# Problem 1
# If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
# Find the sum of all the multiples of 3 or 5 below 1000.

n = 1000 # value to search up to

s = 0 # accumulator
for k in range(n): # run over all values
    if k % 3 == 0 or k % 5 == 0: # test for 3 or 5 divisibility
        s = s+k # accumulate

print(s)
