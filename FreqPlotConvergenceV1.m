function [ plotGRAPH ] = FreqPlotConvergenceV1(base, digit, n, nSampleMAT)
%this version accepts base to be calculated in base,
%number of digits it to be generated per number in digit,
%iterations generated per run in n
%samples to be run in nSampleMAT, which is in the following format:
%first row: number of sample, second row: number of iterations run
%and outputs the plot of frequency of persistency against persistency
%number. Different number of sample will have different number of subplots.

%requires the following file: PersistenceCheckV4.m, NumberGeneratorV3.m

%function to output frequency matrix
function [freqMAT] = TabulateFreqMAT(countMAT, countMAX)

    freqMAT = zeros(1, countMAX);
    tabMAT = tabulate(countMAT(1, :));
    for p = 1:size(tabMAT, 1)
        
        freqMAT(1, tabMAT(p, 1)) = tabMAT(p, 3)/100;
    
    end
    
end

%creates table of random integers and count
[numberMAT] = NumberGeneratorV3(base, digit, n);
[BIGcountMAT, ~, ~ ] = PersistenceCheckV4(numberMAT, base);
persistenceMAX = max(BIGcountMAT);

%set up plot
plotRows = size(nSampleMAT, 2)
x = 1:persistenceMAX

%table for graph if its all the samples taken
ALLfreqMAT = TabulateFreqMAT(BIGcountMAT, persistenceMAX);
ALLfreqMAT = log(ALLfreqMAT);

%sub plots for each sample size
for sampleMATcolumn = 1:plotRows
   
    %load sampleSize and sampleIterations
    sampleSize = nSampleMAT(1, sampleMATcolumn)
    sampleIteration = nSampleMAT(2, sampleMATcolumn)

    subplot(plotRows, 1, sampleMATcolumn)
    
    hold on
    
    %graph for all counts
    plotGRAPH = plot(x,ALLfreqMAT, 'DisplayName', "All samples", 'LineWidth',4)

    
    %graph for each iterations
    for iteration = 1:sampleIteration
        
        sampledMAT = BIGcountMAT(1, randi(n, sampleSize));
        SAMPLEfreqMAT = TabulateFreqMAT(sampledMAT, persistenceMAX);
        SAMPLEfreqMAT = log(SAMPLEfreqMAT);
        plotGRAPH = plot(x,SAMPLEfreqMAT, 'DisplayName', strcat("Iteration " + iteration))


        
    end
    
    hold off
    
    %legend
    xlabel('Persistence')
    ylabel('Persistence Frequency')
    title({strcat("Graph of the log of frequency of persistence against persistence for numbers of ", string(digit), " digits in base ", string(base), " with ", string(sampleSize), " samples iterated for ", string(sampleIteration), " times."), strcat("Numbers are extracted from pool of ", string(n), " numbers whose average is represented by the bolded line.")})
end

end
