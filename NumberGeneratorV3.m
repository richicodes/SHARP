function [ numberMAT ] = NumberGeneratorV3(base, digit, n)
%this version accepts base of number generated in base,
%digit as the number of digits generated;
%n as the number of random numbers generated;
%outputs columns of randomly generated numbers in the 
%base, number of digits and iterations as in the input

numMIN = base^(digit-1);
numMAX = base^(digit)-1;

numberMAT = [string(dec2base(randi(numMAX-numMIN, 1, n) + numMIN, base))]';
end