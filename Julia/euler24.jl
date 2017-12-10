# A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation
# of the digits 1, 2, 3 and 4. If all of the permutations are listed numerically or alphabetically,
# we call it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:
#
# 012   021   102   120   201   210
#
# What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?

function nPerm(n,r)
    # Calculate number of permutations
    return factorial(n)*factorial(n-r)
end

function swap(a,b)
    # swap the two elements
    return b, a
end

function array2numbers(array)
    # converts a matrix of digits to a number string of each row
    str_arr = fill("",size(array,1),1)  # create empty string array
    for k = 1:size(array,1)  # loop over all rows
        st = ""  # create an empty string
        for l = 1:size(array,2)  # loop over every digit in each row
            st = st*Char(array[k,l]+48)  # convert to a char and add to string
        end
        str_arr[k] = st  # place the string in the array
    end
    return sort!(str_arr[:]) # return the sorted array
end

function generatePerm(n, l)
    # Using heap's algorithm for the calculation of the permutations
    # Modified non recursive version of the formula for jula indexing (0 vs 1)
    # From: https://en.wikipedia.org/wiki/Heap%27s_algorithm
    c = ones(Int,n,1)
    store = zeros(Int,nPerm(n,n),n)
    a = 1
    store[a,:] = l
    i = 1
    while i <= n
        if c[i] < i
            if i % 2 == 1
                l[i], l[1] = swap(l[i],l[1])
            else
                l[i], l[c[i]] = swap(l[i],l[c[i]])
            end
            a = a + 1
            store[a,:] = l
            c[i] = c[i] + 1
            i = 1
        else
            c[i] = 1
            i = i + 1
        end
    end
    return store
end


l = collect(0:9) # digits under consideration in the problem 0 .. 9
s = size(l,1) # number of digits to create permutatios with
n = Int(1e6)  # the n'th permutation we are looking for

arr = generatePerm(s,l)  # generate the permutations
numbers = array2numbers(arr)  # convert the matrix to number strings
print(numbers[n])  # selecth the n'th permutation
