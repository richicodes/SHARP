#Version1 of homework 3
#point1 and point 2 will be randomly generated before each run
#supports any order of A and B
#default values for
#seq: AABB
#e <-  0.003
#coinA <-  1/2 - e
#LL: coinB1 <- 9/10 - e
#LW: coinB2 <- 1/4 - e
#WL: coinB3 <- 1/4 - e
#WW: coinB4 <- 7/10 - e

#constants
e <- 0.003
coinA <- 1/2 - e
coinB1 <- 9/10 - e
coinB2 <- 1/4 - e
coinB3 <- 1/4 - e
coinB4 <- 7/10 - e

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

#points to indicate win lose
point <- NULL
point2 <- 0
point1 <- 0

#prepping for sequence
sequ <- "B"
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
  point2 <<- point1
  point1 <<- point
  
  #FOR DEBUG
  #print(coin)
  
}

#running the programme
while (run < runMax) {
  
  #preperations for each run
  run <- run + 1
  play <- 0
  capital <- 0
  scoreSheet <- vector()
  
  #randomly assigns points2 and points1
  point1 <- (2*round(runif(1)))-1
  point2 <- (2*round(runif(1)))-1
  
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
      
      #FOR DEBUG
      #print("state b entered")
      
      if ((point2 == -1) & (point1 == -1)){
        
        dice(coinB1)
        
      }
      
      else if ((point2 == -1) & (point1 == 1)){
        
        dice(coinB2)
        
      }
      
      else if ((point2 == 1) & (point1 == -1)){
        
        dice(coinB3)
        
      }
      
      else if ((point2 == 1) & (point1 == 1)){
        
        dice(coinB4)
        
      }
      
    }
    
  }
  
  #FOR DEBUG: check for completeness
  #if (length(scoreSheet != 100)){
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
     main = "Graph of Average Capital against Play Number", 
     sub = paste("for sequence ", sequ," with ", runMax, " trials"), 
     xlab = "Plays", 
     ylab = "Average Capital")
