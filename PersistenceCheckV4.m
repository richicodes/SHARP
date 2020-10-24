
function [ countMAT, persMAX, maxMAT ] = PersistenceCheckV4(inputMAT, base)
%this version accepts rows of number in inputMat,
%base number will be input and calculated in;
%calculates the multiplicative persistance;
%outputs results of persistence into countMAX
%the number with the maximum persistence into persMAX,
%and matrix of maximum number maxMAT

function persistance = PersistenceCalculater(input)    
    %initialise numberBase
    numberBase = string(input);
    
    %initialise length of number
    digit = strlength(numberBase);
    
    %initialise count
    persistance = 0;

    %loop while digits are more than one
    while digit > 1

        %split into individual digits
        numArray = string(num2cell(cell2mat(numberBase)));
        result = 1;

        for numb = numArray
            
            numbdec = base2dec(numb, base);
            result = result * numbdec;

        end
    
        numberBase = string(dec2base(result, base));
        digit = strlength(string(numberBase));
        persistance = persistance + 1;
    
    end
        
end

countMAT = arrayfun(@(input) PersistenceCalculater(input), inputMAT);
resultMAT = string([inputMAT; countMAT]);
persMAX = string(max(countMAT));
maxMAT = resultMAT(1, ismember(resultMAT(2, :), persMAX));
   
end