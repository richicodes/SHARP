#Version5
#Periodic sequence XXYY
#if its x run coinA with pA of 0.5 - e
#if its y
#and capital mod 3 == 0 then its coinB with pB of 1/10 - e
#or capital mod /= 0 the its coinC with pC of 3/4 - e
#saves output into rolling average


#constants
e <- 0.005
coinA <- 0.5 - e
coinB <- 0.1 - e
coinC <- 0.75 - e

ccA <- 0
ccB <- 0
ccC <- 0

M <- 3
playMax <- 100
runMax <- 30000

#global variables
#masterTable <- data.frame(Run=integer(), Play=integer(), State=character(), Coin=character(), Capital=integer(), Point=integer(), Value=double())

totalSheet <- vector()
totalSheet <- c(totalSheet, 1:playMax)

run <- 0
play <- 0
plays <- seq(1, playMax)
state <- NULL
coin <- NULL
capital <- 0
point <- NULL
value <- NULL

#prepping for sequence

sequ <- "xyyy"
sequLen <- nchar(sequ)

#dice function to assign capital value according to random output
dice <- function(coinInput){
  
  #sets value and coin
  value <<- runif(1)
  coin <<- deparse(substitute(coinInput))

  #counts coin input
  if (coinInput == coinA) {
    
    ccA <<- ccA + 1
    
  }
  
  else if (coinInput == coinB) {
    
    ccB <<- ccB + 1
    
  }
  
  else if (coinInput == coinC) {
    
    ccC <<- ccC + 1
    
  }
  
  
  #give selects point
  if (value < coinInput) {
    
    point <<- 1
    
  }
  
  else{
    
    point <<- -1
    
  }
  
  #adds point to capital
  capital <<- capital + point
  scoreSheet <<- c(scoreSheet, capital)
  
}

#running the programme
while (run < runMax) {
  
  run <- run + 1
  play <- 0
  capital <- 0
  scoreSheet <-  vector()
  
  while (play < playMax) {
    
    #prepares run
    play <- play + 1
    mod <- (play %% sequLen) + 1
    state <- substr(sequ, mod, mod)
    
    #assigning values
    if (state == "x") {
      
      dice(coinA)
      
    }
    
    else if (state == "y") {
      
      if (abs(capital) %% M == 0) {
        
        dice(coinB)
        
      }
      
      else {
        
        dice(coinC)
        
      }
      
    }
    
  }
  
  #adds scoreSheet to totalSheet
  totalSheet <- totalSheet + scoreSheet
  
  #indicates programme is running
  if (run %% 100 == 0) {
    print(run)
    
  }
}
#prepare data for graph making
averageSheet <- totalSheet / run
plot(plays, averageSheet, main = "Graph of Average Capital against Play Number", sub = paste("for sequence ", sequ,"  with 30,000 trials"), xlab = "Plays", ylab = "Average Capital")