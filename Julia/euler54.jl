# In the card game poker, a hand consists of five cards and are ranked, from lowest to highest, in the following way:
#
# High Card: Highest value card.
# One Pair: Two cards of the same value.
# Two Pairs: Two different pairs.
# Three of a Kind: Three cards of the same value.
# Straight: All cards are consecutive values.
# Flush: All cards of the same suit.
# Full House: Three of a kind and a pair.
# Four of a Kind: Four cards of the same value.
# Straight Flush: All cards are consecutive values of same suit.
# Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
# The cards are valued in the order:
# 2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.
#
# If two players have the same ranked hands then the rank made up of the highest value wins;
# for example, a pair of eights beats a pair of fives (see example 1 below). But if two ranks tie,
# for example, both players have a pair of queens, then highest cards in each hand are compared (see example 4 below);
# if the highest cards tie then the next highest cards are compared, and so on.
#
# Consider the following five hands dealt to two players:
#
# Hand	 	Player 1	 	Player 2	 	 Winner
# 1	 	5H 5C 6S 7S KD  	2C 3S 8S 8D TD   Player 2
#       Pair of Fives       Pair of Eights
# 2	 	5D 8C 9S JS AC  	2C 5C 7D 8S QH   Player 1
#       Highest card Ace    Highest card Queen
# 3	 	2D 9C AS AH AC      3D 6D 7D TD QD   Player 2
#       Three Aces          Flush with Diamonds
#
# The file, poker.txt, contains one-thousand random hands dealt to two players.
# Each line of the file contains ten cards (separated by a single space):
# the first five are Player 1's cards and the last five are Player 2's cards.
# You can assume that all hands are valid (no invalid characters or repeated cards),
# each player's hand is in no specific order, and in each hand there is a clear winner.
#
# How many hands does Player 1 win?

function countAll(itr)
# this function gives the unique values, and the number of each in the array
    a = unique(itr)  # calculate the number of unique values
    b = zeros(size(a))  # initialize the counting array
    k = 1
    for ai = a  # for each unique value
        b[k] = count(i->(i==ai),itr)  # get the count for that value and save to the array
        k = k+1
    end
    return a, b  # return the unique values and their counts
end

function findRepeatValue(uni, counts)
    # Find the card value for the card that repeats the most
    m, mi = findmax(counts)  # find the value and the index of the maximum count
    rs = uni[mi]  # find the value of the maximum count
    return rs  # return the value
end

function getTotal(playerValues, playerSuites)
    # Calculates a score for the player hand, based on the rules of poker.
    # It first calculates a hand score, which is based on the winning order below.
    # High Card: Highest value card.
    # One Pair: Two cards of the same value.
    # Two Pairs: Two different pairs.
    # Three of a Kind: Three cards of the same value.
    # Straight: All cards are consecutive values.
    # Flush: All cards of the same suit.
    # Full House: Three of a kind and a pair.
    # Four of a Kind: Four cards of the same value.
    # Straight Flush: All cards are consecutive values of same suit.
    # Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
    # Then calculates the rank of the winning hand if there is any
    # Lastly calculates the value score which is only based on the cards
    # All of this is combined in a single score so that a simple mathamatical
    # >, = or < can be used to determine the winner

    fs = 0  # final score (made up of hand score, ranks score, and value score)
    hs = 0  # set the hand score
    rs = 0  # set the rank score
    vs = 0  # set the value score

    # test for a flush
    # all suites are equal (thus only one unique suite in hand)
    if length(unique(playerSuites)) == 1
        hs = hs + 5 # increase the hand score by 5 (because we can have both a straight and a flush)
    end
    # test for a straight
    # a hand is a straight when all the values differ by 1
    if diff(playerValues) == diff(collect(1:5)*-1)
        hs = hs + 4 # increase the hand score by 4 (because we can have both a straight and a flush)
    end
    # we ignore royal flushes, since this is just a straight flush of the highest rank - maths dont care
    # if we have a hand score at this point is cannot be one of the hands remaining, if not we search further
    if hs == 0  # if not a flush, straight, straight flush, or royal flush (nothing found so far)
        # calculate the unique cards in the hand, and the count (amount) of each unique card
        uni, counts = countAll(playerValues)
        # test if four of a kind
        if maximum(counts) == 4
            hs = 7  # set the hand score
            rs = findRepeatValue(uni, counts)  # calculate the rank of the hand
        # test if a full house
        elseif length(counts) == 2 && maximum(counts) == 3
            hs = 6  # set the hand score
            rs = playerValues[1]  # calculate the rank of the hand
        # test if three of a kind
        elseif length(counts) == 3 && maximum(counts) == 3
            hs = 3  # set the hand score
            rs = findRepeatValue(uni, counts)  # calculate the rank of the hand
        # test if two pair
        elseif length(counts) == 3 && maximum(counts) == 2
            hs = 2  # set the hand score
            rs = findRepeatValue(uni, counts)  # calculate the rank of the hand
        # test if a pair
        elseif length(counts) == 4
            hs = 1  # set the hand score
            rs = findRepeatValue(uni, counts)  # calculate the rank of the hand
        end
    else
        rs = playerValues[1]  # calculate the rank of the hand
    end
    # create a value that allows us to test highest value of cards in order (if hs and rs of hands are equal)
    vs = sum(playerValues .* [10^8,10^6,10^4,10^2,1])

    # combine hand score, rank score and value score so that hand score carries the most weight
    # followed by rank score and value score. This creates a number that allows us to perform
    # logical tests on to see who is the winner of a hand.
    fs = hs * 10^12 + rs * 10^10 + vs
    return fs
end

function line2cards(line)
    # convert a line from the text file to cards (split on values and suites)
    value_arr = fill('_',2,5)  # initialize value array
    suit_arr = fill('_',2,5)  # initialize suit array
    l = 1
    for k = 1:10  # go through each text block in the line for each 10 cards
        if k > 5 && l !=2  # flip to the second hand after the 5th card
            l = 2
        end
        value_arr[l,k-(l-1)*5] = line[1+(k-1)*3]  # extract the value and place in value array
        suit_arr[l,k-(l-1)*5] = line[2+(k-1)*3]  # extract the suite and place in suite array
    end
    return value_arr, suit_arr
end

function cards2num(cards)
    # Take a card character and convert to a numberical value, from 2 to 14 (ace)
    num_arr = fill(0,2,5)  # create an array of zeros
    for k= 1:10  # for each card character in the 10 cards
        if cards[k] == 'A'  # if an ace, set the value to 14
            num_arr[k] = 14
        elseif cards[k] == 'K'  # if a king, set the value to 13
            num_arr[k] = 13
        elseif cards[k] == 'Q'  # if a queen, set the value to 12
            num_arr[k] = 12
        elseif cards[k] == 'J'  # if a jack, set the value to 11
            num_arr[k] = 11
        elseif cards[k] == 'T'  # if a ten, set the value to 10
            num_arr[k] = 10
        else  # otherwise convert the character number representation to its integer number
            num_arr[k] = Int(cards[k] - 48)
        end
    end
    return num_arr
end

function sortIdx(nums, suites)
    # sort the cards of each hand seperately (carrying the suites along)
    for k = 1:size(nums,1) # for each hand
        idx = sortperm(nums[k,:], rev=true)  # get the index that will sort by value
        nums[k,:] = nums[k,idx]  # sort the numbers
        suites[k,:] = suites[k,idx]  # sort the suites
    end
    return nums, suites
end

p1wins = 0  # initialize player 1 win counter

f = open("p054_poker.txt")  # open the file with the data
lines = readlines(f)  # read the file into the lines vairable
close(f)  # close the file

for k = 1:size(lines,1)  # for each line in the lines variable
    line = lines[k]  # extract that line
    cards, suites = line2cards(line)  # get the cards and suites from that text line
    values = cards2num(cards)  # convert the card numbers to values
    sort_v, sort_s = sortIdx(values, suites)  # sort the cards by value
    p1s = getTotal(sort_v[1,:], sort_s[1,:])  # get the total score for player 1
    p2s = getTotal(sort_v[2,:], sort_s[2,:])  # get the total score for player 2
    if p1s > p2s  # if player 1 wins, count the win
        p1wins = p1wins + 1
    end
end

println("Result: ", p1wins)  # return the total player 1 wins
