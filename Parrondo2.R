#cooperative parrondo
#N players
#Losing coin flip for Game A
#Game B has the following possibilities
#LXL: coinB1 <- 1 - e
#LXW: coinB2 <- 0.16 - e
#WXL: coinB3 <- 0.16 - e
#WXW: coinB4 <- 0.7 - e
#capital represents total capital for all player

#constants
e <- 0
coinA <- 1/2 - e
coinB1 <- 1 - e
coinB2 <- 0.10 - e
coinB3 <- 0.10 - e
coinB4 <- 0.7 - e

TcoinA <- 0
TcoinB1 <- 0
TcoinB2 <- 0
TcoinB3 <- 0
TcoinB4 <- 0

playMax <- 100
runMax <- 30000

#variables
totalSheet <- vector()
totalSheet <- c(totalSheet, 1:playMax)

run <- 0
play <- 0
state <- NULL
coin <- NULL
capital <- 0
value <- NULL
N <- 10

#points to indicate win lose
point <- NULL
point2 <- 0
point1 <- 0

#prepping for sequence
sequ <- "AB"
sequLen <- nchar(sequ)

#dice function to assign capital value according to random output
#also assigns points history
dice <- function(coinInput){
  
  #sets value and coin
  value <<- runif(1)
  
  #counts coin input
  coin <<- deparse(substitute(coinInput))
  Tcoin <<- paste("T", coin, sep = "")
  Tvalue <- get(Tcoin)
  assign(Tcoin, Tvalue + 1, envir = .GlobalEnv)
  
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
  
  #assign point history
  winSheet[n] <<- point
  
  #FOR DEBUG
  #print(coin)
  #print(scoreSheet)
  
}

#running the programme
while (run < runMax) {
  
  #preperations for each run
  run <- run + 1
  play <- 0
  capital <- 0
  scoreSheet <- vector()
  n <- 0
  winSheet <- vector()
  w <- 0
  
  #randomly assigns points2 and points1
  point1 <- (2*round(runif(1)))-1
  point2 <- (2*round(runif(1)))-1
  
  #prepping for multiplayer mode
  winSheet <- (2*round(runif(10)))-1
  
  while (play < playMax) {
    
    #prepares run
    play <- play + 1
    mod <- (play %% sequLen)
    
    if (mod == 0){
      
      mod <- sequLen
      
    }
    
    state <- substr(sequ, mod, mod)
    #FOR DEBUG
    #print(play)
    
    #assigning values
    if (state == "A") {
      
      dice(coinA)
      
    }
    
    else if (state == "B") {
      
      n <- play%%N
      nB <- n - 1
      nA <- n + 1
      
      if (n == 0){
        
        n <- N
        nA <- 1
        nB <- N - 1
        
      }
      
      if (n == 1){
        
        nB <- N
        
      }
      
      nBB <- winSheet[nB]
      nAA <- winSheet[nA]
      
      #FOR DEBUG
      #print("state b entered")
      #print(n)
      
      if ((nBB == -1) & (nAA == -1)){
        
        dice(coinB1)
        
      }
      
      else if ((nBB == -1) & (nAA == 1)){
        
        dice(coinB2)
        
      }
      
      else if ((nBB == 1) & (nAA == -1)){
        
        dice(coinB3)
        
      }
      
      else if ((nBB == 1) & (nAA == 1)){
        
        dice(coinB4)
        
      }
      
    }
    
  }
  
  #FOR DEBUG: check for completeness
  #if (length(scoreSheet != playMax)){
  #  stop("Length of scoresheet is not 100")
  #}
  
  #adds scoreSheet to totalSheet
  totalSheet <- totalSheet + scoreSheet
  
  #indicates programme is running
  if (run %% 1000 == 0) {
    print(run)
  }
}

#prepare data for graph making
averageSheet <- totalSheet / run
plays <- seq(1, playMax)
plot(plays, averageSheet, 
     main = "Graph of Average Capital against Play Number for Co-operative Parrondo", 
     sub = paste("for sequence ", sequ," with ", runMax, " trials"), 
     xlab = "Plays", 
     ylab = "Average Capital")
