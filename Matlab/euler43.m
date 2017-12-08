% The number, 1406357289, is a 0 to 9 pandigital number because it is made up of 
% each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.
% 
% Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:
% 
% d2d3d4=406 is divisible by 2
% d3d4d5=063 is divisible by 3
% d4d5d6=635 is divisible by 5
% d5d6d7=357 is divisible by 7
% d6d7d8=572 is divisible by 11
% d7d8d9=728 is divisible by 13
% d8d9d10=289 is divisible by 17
% Find the sum of all 0 to 9 pandigital numbers with this property.

function euler43
    pandigitals = perms([0 1 2 3 4 5 6 7 8 9]);  % create all possible permutations 
    pandigitals = pandigitals(pandigitals(:,1)~=0,:);  % remove all that start with 0 -> this is a number of length 9 not 10 (for this problem it makes no difference)
    test_mat = zeros(size(pandigitals,1),7);   % create a storage array with test outcomes
    div_mat = primes(17);  % create the division array of primes up to 17
    for k = 1:7  % there are 7 numbers to calculate
        % 1. calculate the combined number from digit k+1 to digit k+3
        % 2. test if this number is divisable by the corresponding prime
        % number
        % 3. store this in the array
        test_mat(:,k) = mod(comb_sub(pandigitals,k+1,k+3),div_mat(k));
    end
    % convert the seperate pandigital digit array into an array with the
    % full numbers (multiply each digit with the order of that position
    % then sum all these numbers to get the full final number)
    pandigitals_full = sum(pandigitals.*repmat(10.^(9:-1:0),size(pandigitals,1),1),2);
    % if the test array is 0 for every entry for that number it passes the
    % property test set out in the problem statement, select and sum all of
    % these from the pandigitals_full array
    res = sum(pandigitals_full((sum(test_mat ~= 0,2) == 0)));
    % print the answer
    s = num2str(res,'%i')
end

function out = comb_sub(matrix,start,stop)
    % create a number for a subset of columns from a matrix containing 
    % single digits
    mult_fact = 10.^(abs(start-stop):-1:0); % order of the numbers
    s1 = max([start, stop]);  % makes start and stop order independent
    s2 = min([start, stop]);  % s1 is always the largest, s2 the smallest
    % create array with the new numbers
    out = sum(matrix(:,s2:s1).*repmat(mult_fact,size(matrix,1),1),2);  
end



