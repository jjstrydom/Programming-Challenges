# By replacing the 1st digit of the 2-digit number *3, it turns out that six of the nine possible values:
# 13, 23, 43, 53, 73, and 83, are all prime.
#
# By replacing the 3rd and 4th digits of 56**3 with the same digit, this 5-digit number is the first example having
# seven primes among the ten generated numbers, yielding the family: 56003, 56113, 56333, 56443, 56663, 56773, and 56993.
# Consequently 56003, being the first member of this family, is the smallest prime with this property.
#
# Find the smallest prime which, by replacing part of the number (not necessarily adjacent digits) with the same digit,
# is part of an eight prime value family.

import math
import numpy as np

def is_prime(n, primelist = [], searched=1):
    """ Something is a prime, when it is not divisible by another prime. This function first tries to divide by all
        primes it has found previously, if it is not divisible, it searches for new primes, until it finds a new
        prime that can divide. If no new prime is found, then this is a new prime! Also - recursion.
        Note: This is probably better suited to a class because of the internal primelist and searched variables. """
    for k in primelist: # got through our primes list, if divisible by a prime in this list: quit, n is not prime
        if n % k == 0:
            return False, primelist, searched
    while math.floor(math.sqrt(n)) > searched: # not divisible by a prime in the prime list, search for new primes, and try again
        # prime search is upper bounded by sqrt(n) because the result becomes smaller than divisor at that point because 10/4=2.5 and 10/2.5=4
        searched = searched + 1
        T, primelist, _ = is_prime(searched, primelist, searched-1)
        if T: # if the new searched value is a prime add it to the prime list
            primelist.append(searched)
            if n % searched == 0:
                return False, primelist, searched
    else:  # if we are searching past sqrt(n) we should stop because have found a new prime!
        return True, primelist, searched


def combination_generator(n):
    """ Generates all the possible combinations when there are two possible options for n positions.
        The problem has two positions - replace or not replace.
        This is the same as counting in binary with n bits. Can easily be extended to N possible options by changing
        the base of the numbering system (e.g. of there are 5 options per position, then use base 5 instead of 2 ) """
    t = 2**n  # total number of possible combinations given base 2
    f = format(n, '03d')+'b'  # Create format string so that all the strings are the same lengths with leading zeros
    mask_array_h = np.zeros((t, n))  # Array that will be filled
    mask_array_l = np.zeros((t, n))  # Array that will have the inverse (not filled) - this only works for the base 2 case
    for k in range(t):  # fill the arrays with ones and zeros in all possible combinations
        l = format(k,f)
        for m in range(n):
            mask_array_h[k,m] = int(l[m])
            mask_array_l[k,m] = abs(int(l[m])-1)
    return mask_array_h, mask_array_l


def num2mat(num, depth):
    """ Convert a number to a matrix, each column with a single number. Vector is repeated row wise to ease maths later
        on in the process. Number 321 is converted to [3. 2. 1.] """
    width = (len(str(num)))  # Size of the number
    a = np.zeros((depth,width), dtype=int)
    for k in range(width):
        f = 10**(width-k-1)  # order of the largest number
        a[:,k] = (num//f)   # isolate the largest number and place in array
        num = num-(num//f)*f  # subtract this number so that process can repeat
    return a


def mat2num(mat):
    """ Converts a matrix of single digit numbers to a vector of numbers (reverse of num2mat) so [3. 2. 1.] becomes 321. """
    a = np.ones((1,mat.shape[1]), dtype=int)
    for k in range(mat.shape[1]):
        a[0,k] = 10**(mat.shape[1]-k-1)  # Multiply each number by its respective order
    return np.sum(mat*a, axis=1)  # sum the numbers multiplied by orders to obtain the flattened number in a vector


if __name__ == "__main__":
    npr = 8
    pvf = 0  # prime value family
    test_val = 10-9 # start testing here, otherwise we are replacing whole numbers with is not the point of the problem
    pl = [] # variable for is_prime function to store past work
    sr = 1  # variable for is_prime function to store past work
    prev_l = 0  # previous length of the number
    while pvf != npr:
        test_val = test_val + 1  # the next number to test for a prime
        TF, pl, sr = is_prime(test_val, pl, sr)  # test if this number is a prime
        if TF:  # if this number is a prime continue, else test the next number
            l = len(str(test_val))  # get the length of the number
            if l != prev_l:  # if the length is different - re calculate the possible combinations matrix
                cmbh, cmbl = combination_generator(l)  # generate all possible combinations (this is to aid in number replacement in portions of the original prime)
            for m in range(1, cmbh.shape[0]-1):  # all zeros and all ones does not contribute to solving the problem so skip these combinations, loop through all others
                if cmbh[m,0] == 1:  # Test if the first combination is a 1, if so then do not test with zero as this changes the length of the number
                    sz = 9  # skipping 0, so there are only 9 numbers to test with
                    k_vec = np.arange(1,10)  # no zero, only 1-9 as replacement numbers
                else:  # If the first combination is not a 1 then it we can replace these values with a 0 without altering the length of the number
                    sz = 10  # include 0, so all 10 numbers to test with
                    k_vec = np.arange(0,10)  # 0-9 as replacement numbers
                k_vec.shape = (sz,1)  # convert to a 2d column vector
                mskh = np.tile(cmbh[m,:],(sz,1))  # this is the high mask (used for replacement) (high + low gives all)
                mskl = np.tile(cmbl[m,:],(sz,1))  # this is the low mask (used to keep the remaining numbers)
                pvf = 0  # reset prime value family counter to zero
                test_val_mat = num2mat(test_val, sz)  # create the number matrix
                test_val_msk = k_vec*mskh + test_val_mat*mskl  # replace the portions of the number based on the high mask
                test_val_prime = mat2num(test_val_msk)  # convert 2d number matrix back to vector of numbers
                SP = 0  # smallest prime storage variable <- this is what we are looking for in the problem
                for i in test_val_prime:  # loop through each of the new numbers
                    TFtv, pl, sr = is_prime(i, pl, sr)  # test if this number is a prime
                    if TFtv:  # if this number is a prime
                        pvf = pvf + 1  # count the prime value family
                        if pvf == 1:  # if its the first prime value in the family, it will be the smallest one (replacement starts form 0 or 1 going to 9)
                            SP = i  # store it <- we are looking for the smallest one
                if pvf == npr:  # if the prime value family matches the seeked order we may have fount the smallest number for that order!
                    if test_val >= SP:  # if the test value is larger to or equal to the smallest found value, we have the family
                        break  # if this was not the case we may have altered the test value in such a way that there may
                        #  be a valid candidate in between the test value and the larger found smallest prime and the search should continue
    print('Result:')
    print(test_val)