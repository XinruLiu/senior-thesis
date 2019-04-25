#create observations
simTotal1 <- list()
#for(i in 1:1){
  hmm1 <- initHMM(c("S1", "S2", "S3"),c("X", "Y", "Z"),
                  startProbs = c(0.5, 0.5, 0),       
                  transProbs = t(matrix(c(0, 1/3, 2/3,
                                        1/3, 0, 2/3,
                                        1/3, 1/3, 1/3),3)), 
                  emissionProbs = t(matrix(c(0.5, 0.5, 0,
                                           0, 0.5, 0.5,
                                           0.5, 0, 0.5),3)))
  sim <- simHMM(hmm1, 1000)
  sim.ob <- sim$observation
  sim.state <- sim$states
  #simTotal1[[i]] <- sim1
  
#}
print(hmm1)
simTotal <- c()
for(i in 1:10){
  simTotal <- c(simTotal, simTotal1[[i]])
}


prob <- function (x) {x / sum (x)}  # Makes it a probability (it sums to 1)

# Initial HMM
hmm <- initHMM(c("S1", "S2", "S3"),c("X", "Y", "Z"),
              startProbs = prob(runif(3)),
              transProbs = t(apply ((matrix (runif (9), 3)), 1, prob)),
              emissionProbs=t(apply ((matrix (runif (9), 3)), 1, prob)))


print(hmm)

hmm2 <- initHMM(c("s", "t"),c("A", "B"),
              startProbs = c(0.5, 0.5),
              transProbs = matrix(c(0.5, 0.5, 0.5, 0.5), ncol = 2),
              emissionProbs=matrix(c(0.9, 0.1, 0.1, 0.9), ncol=2))

print(hmm2)
# Sequence of observation
#a = sample(c(rep("X",5),rep("Y",30), rep("Z", 30)))
#b = sample(c(rep("X",8),rep("Y",45), rep("Z", 40)))
#observation = c(a,b)


observation <- simTotal
# Baum-Welch
bw <- baumWelch(hmm,sim.ob, 200)
print(bw$hmm)
#observation <- c("B", "B", "B", "B", "A", "A", "A", "A")
observation <- c("A", "B", "A")
bw <- baumWelch(hmm2, observation)
print(bw$hmm)

