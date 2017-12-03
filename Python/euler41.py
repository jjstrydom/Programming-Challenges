# We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is also prime.
#
# What is the largest n-digit pandigital prime that exists?

import math

def get_pandigitals(n): # n has to be 2 or bigger
    def _get_pandigitals(n):
        """ Works on the logic that if you have all combinaions of a lenght one less than the current length, you can
            get all combinations for the new length by cycling through the new element through all the previous
            combinations, every cycle step creating a new combination of the new length.
            Works well for pandigital combinations (i.e. you wont find a 6 in a length 4 set of combinations), but
            will need some modification if you are interested in all combinations of all elements. """
        pds = []
        m = []
        p = []
        if n == 2:  # smallest number of combinations - hand coded
            pds.append('12')
            pds.append('21')
        else:
            m, p = _get_pandigitals(n-1) # recursively get the one shorter combinations than the current length
            ns = str(n)
            for k in m:
                for o in range(len(k)+1):  # cycle new element through all previous combinations.
                    pds.append(k[:o] + ns + k[o:])
        return pds, m + p  # return this new length list, and the combination of previous lists
    a, b = _get_pandigitals(n)
    c = a + b
    d = []
    for k in range(len(c)):
        d.append(int(c[k]))
    d.sort(reverse=True)
    return d

def is_prime(n, primelist = [], searched=1):
    """ Something is a prime, when it is not divisible by another prime. This function first tries to divide by all
        primes it has found previously, if it is not divisible, it searches for new primes, until it finds a new
        prime that can divide. If no new prime is found, then this is a new prime! Also - recursion. """
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


if __name__ == "__main__":
    n = 9
    pand = get_pandigitals(9) # find all pandigitals sorted from largest to smallest

    # loop through values until a prime is found
    pl = []
    sr = 1
    for k in pand:
        TF, pl, sr = is_prime(k, pl, sr)
        if TF:
            print('prime: ' + str(k))
            break
    else:
        print('none')