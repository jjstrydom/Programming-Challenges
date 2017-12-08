% There are exactly ten ways of selecting three from five, 12345:
% 123, 124, 125, 134, 135, 145, 234, 235, 245, and 345
% In combinatorics, we use the notation, 5C3 = 10.
% 
% In general,
% nCr =	n! / r!(n?r)!
% where r ? n, n! = n×(n?1)×...×3×2×1, and 0! = 1.
%
% It is not until n = 23, that a value exceeds one-million: 23C10 = 1144066.
% How many, not necessarily distinct, values of  nCr, for 1 ? n ? 100, are greater than one-million?

function euler53
    s = 0;  % sum counter
    n_max = 100; 
    for n = 1:n_max  % loop through all values of n
        for r = 1:n  % loop through all values for r, r is always equal to less than n
            if nCr(n,r) > 1e6  % test if the combinations are more than a million
                s = s+1;  % if so count it
            end
        end
    end
    s
end

function out = nCr(n,r)
    % calculate the number of combinations (given formula)
    out = factorial(n)/(factorial(r)*factorial(n-r));
end