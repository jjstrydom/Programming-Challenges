% The prime factors of 13195 are 5, 7, 13 and 29.
% What is the largest prime factor of the number 600851475143 ?

n = 600851475143;  % Value to find primes of
p = primes(sqrt(n));  % largest prime factor will be less than sqrt(n)
r = mod(n,p);   % the remainder shows which primes divide into n 
k = find(r == 0);  % if the remainder is 0 they divide, find index where this is true
p(max(k))  % largest index is the largest prime factor that can divide into n

