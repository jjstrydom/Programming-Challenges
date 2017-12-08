% The fraction 49/98 is a curious fraction, as an inexperienced mathematician in 
% attempting to simplify it may incorrectly believe that 49/98 = 4/8, which is correct,
% is obtained by cancelling the 9s.
% 
% We shall consider fractions like, 30/50 = 3/5, to be trivial examples.
% 
% There are exactly four non-trivial examples of this type of fraction, less
% than one in value, and containing two digits in the numerator and denominator.
% 
% If the product of these four fractions is given in its lowest common terms, 
% find the value of the denominator.

ab = 10;
ae = 99;
a = ab:ae;

store = zeros(0,4);

for num = a  % numerator cycle
    for den = num+1:ae  % denumenator cycle. num + 1 ensures that we are less than 1 in value
        num_2 = mod(num,10);  % get the trailing digit of the numerator
        num_1 = (num-num_2)/10;  % get the leading digit of the numerator
        den_2 = mod(den,10);  % get the trailing digit of the denominator
        den_1 = (den-den_2)/10;  % get the leading digit of the denominator
        % test to ensure it is a non trivial example (cannot be devided by
        % 10 or 11 for both numerator and denominator)
        if not((mod(num,10) == 0 && mod(den,10) == 0) || (mod(num,11) == 0 && mod(den,11) == 0))
            % test all possible combinations of numerator and denominator
            % digits to see if they are equal to the original fraction
            if ((num_1/den_1) == num/den) && (num_2 == den_2)
                % if equal to original fraction, store the data
                store = cat(1, store, [num,den,num_1,den_1]);
            end
            if ((num_2/den_1) == num/den) && (num_1 == den_2)
                store = cat(1, store, [num,den,num_2,den_1]);
            end
            if ((num_1/den_2) == num/den) && (num_2 == den_1)
                store = cat(1, store, [num,den,num_1,den_2]);
            end
            if ((num_2/den_2) == num/den) && (num_1 == den_1)
                store = cat(1, store, [num,den,num_2,den_2]);
            end
        end
    end
end

% calculate the products of all the non trival fractions' numerators and denominators 
p = prod(store(:,1:2));

div = p(1); % search for the greatest common divisor (will be smaller than 
% the numerator in this case because the fraction is less than 1).
while div > 2
    % if we can divide by this number and it equals the original
   if mod(p(1),div) == 0 && mod(p(2),div) == 0 
       % then it is a comon divisor, and we are counting back so it is the
       % largest one as well, so divide and stop the loop
       p_fin = p/div;
       div = 0;
   end
   div = div - 1;
end

p_fin % the answer