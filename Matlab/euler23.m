% A perfect number is a number for which the sum of its proper divisors is exactly equal to the number.
% For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.
% 
% A number n is called deficient if the sum of its proper divisors is less than n and it is called abundant if this sum exceeds n.
% 
% As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written as 
% the sum of two abundant numbers is 24. By mathematical analysis, it can be shown that all integers greater 
% than 28123 can be written as the sum of two abundant numbers. However, this upper limit cannot be reduced any
% further by analysis even though it is known that the greatest number that cannot be expressed as the sum of two
% abundant numbers is less than this limit.
% 
% Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.

n = 28123; % This is the upper limit, as the problem states this and above can all be written as the sum of two abundant numbers
a = 1:n;
b = zeros(1,n);

for k = 1:n  % for loop is from the devil, memory based expansion was not quiker in this case
    % loop to all numbers up to n to find the sum of the proper divisors
    % get the sum of all proper divisors of the number k up to n 
    % (by checking if they have a remainder of 0 when divided)
    b(k) = sum(a(mod(k,a(1:(k-1))) == 0)); 
end

abundant = find(b>a);  % find all abundant numbers
% sum all possible combinations of abundant numbers and then find those that are unique
abun_temp = unique(repmat(abundant,length(abundant),1) + repmat(abundant',1,length(abundant)));  
% all combinations larger than n can be discarded, from the problem statement
% we know they are not possibilities
abun_sum = abun_temp(abun_temp <= n);  

% the sum of all the numbers up to n, minus the sum of all the abundant which 
% can be written as the sum of two abundant numbers gives the sum of all positive
% integers which cannot be written as the sum of two abundant numbers
sum(a)-sum(abun_sum)



