function [ plotGRAPH ] = DigitPlotV1(base, digitMAT, n)
%this version accepts base to be calculated in base,
%number of digits it to be generated per number in digitMAT,
%iterations generated per run in n
%and outputs the plot of persistency against digits
%number. Different number of sample will have different number of subplots.

%requires the following file: PersistenceCheckV4.m, NumberGeneratorV3.m

digitMAT = sort(digitMAT)
digits = size(digitMAT, 2)
BIGstatMAT = zeros(2, digits)

count = 0

for digit = digitMAT
    
    count = count + 1

    %creates table of random integers and count
    [numberMAT] = NumberGeneratorV3(base, digit, n);
    [CountMAT, ~, ~ ] = PersistenceCheckV4(numberMAT, base);
    BIGstatMAT(1, count) = mean(CountMAT)
    BIGstatMAT(2, count) = std(CountMAT)
    
end

plotGRAPH = errorbar(digitMAT,BIGstatMAT(1,:),BIGstatMAT(2,:))
ylabel('Average Persistence')
xlabel('Digits')
title({strcat("Graph of the average persistence against persistence for ", mat2str(digitMAT), " digits number for base ", string(base), " iterated for ", string(n), "numbers for each digit set."), "Standard deviation marked with error bars."})


end