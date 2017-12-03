# In England the currency is made up of pound, £, and pence, p, and there are eight coins in general circulation:
#
# 1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
# It is possible to make £2 in the following way:
#
# 1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
# How many different ways can £2 be made using any number of coins?

import numpy as np

def total(e,c):
    """ Calculates the total value of the current coin counts, given the coin values.
        The abs of the working array is used to counter potential miscounts if values were negative, which is impossible."""
    return np.sum(np.abs(e)*c)

def fill_ones(e,c,n):
    """ Calculates the number of lowest denominator counts (assuming they are ones) to make up the required value n. """
    e[-1] = 0
    o = n - total(e,c)
    e[-1] = o
    return e

def shift_zeros(e,s):
    """ Make the current point in the array a zero, increasing the value of one value higher. This is equal to counting
        in base 10, from 17, 18, 19, and then 20 (9 becomes 0, and the one value higher becomes 1+1 = 2) """
    e[s] = 0
    e[s-1] = e[s-1] + 1

if __name__ == "__main__":
    n = 200  # max value
    c = np.array([200, 100, 50, 20, 10, 5, 2, 1])  # coin values
    e = np.zeros(c.shape)  # our working array
    count = 0  # number of combinations counter

    done = 0
    e = fill_ones(e,c,n)  # start with the first candidate that equals n
    while done == 0:
        while total(e,c) > n:  # do the stuff below until we are below n, since any increase in value will be above n and thus a waste of resources
            b = np.where(e != 0)[0]  # find nonzero entries
            if b[-1] != 0:  # start with the last nonzero entry unless it is the largest coin
                shift_zeros(e, b[-1])  # let it wrap (make the last nonzero entry 0, and increment the coin value 1 higher)
            else:   # if the largest coin count is larger than n we are done, no other combinations exist
                done = 1
                break
        if total(e,c) == n:  # if we have a combination that matches n we count it
            count = count + 1
        elif total(e,c) < n:  # if the total is smaller than n, we can save a loop by filling with zeros and counting it as well
            e = fill_ones(e, c, n)
            count = count + 1
        e[-2] = e[-2] + 1  # increment the second to last coin size (since we can fill the smallest with ones to make n)
        e = fill_ones(e,c,n)
        e = np.abs(e)  # we abs the working array, because a negative number of coins is impossible
        # if we get a negative e its a bug, making it positive will make the array sum larger than n, it will be caught in the next loop and fixed
        if (c[0]*e[0]) > n or done:  # check if we have moved beyond the point where we will only get values larger than n OR done flag set
            break
    print('RESULT: ' + str(count))
