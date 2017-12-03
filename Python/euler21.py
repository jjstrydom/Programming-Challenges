# Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
# If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called amicable numbers.
#
# For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
#
# Evaluate the sum of all the amicable numbers under 10000.

import numpy as np

def divisor_sum(n):
    """ Calculate the divisor sum of a number. This is the sum of all numbers that divide into the original number
        excluding the number itself. """
    k = 2 # Two is the smallest possible divisor besides one
    d = n/k + 1  # This is the upper bound for a potential divisor
    s = 1  # one divides into everything
    while k < d: # check if there are any potential divisors left
        if n % k == 0:  # test if this value is a divisor
            d = n//k  # calculate the division answer since both pairs are divisible
            if k == d:  # if they are equal only add one of them to the sum
                s = s + k
            else:  # otherwise add both to the sum
                s = s + k + d
        k = k + 1
    return s

if __name__ == "__main__":
    an = 10000

    t = []
    for m in range(2, an):  # loop over all possible values
        if m not in t:  # check that this value has not been found earlier
            # could also maintain a list of the calculated pair to minimize calls to divisor_sum
            # found that this was more time and memory consuming than simply re-doing the calculation for size 10000
            ds = divisor_sum(m)   # calculate divisor sums in both directions
            at = divisor_sum(ds)
            if at == m and ds != at:  # test if it is an amicable pair
                t.append(ds)
                t.append(at)

    sum_amicable = np.sum(t)
    print(sum_amicable)