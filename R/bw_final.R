
#multivariate normal distribution
library(mhsmm)
J <- 2
init <- c(1, 0)
P <- matrix(c(0, 1, 1, 0), nrow = J)
a<-data.frame(matrix(c(1,2,3,2,1,3,3,1,2), nrow = 3))
b<-data.frame(matrix(c(2,4,3,2,1,4,3,2,4), ncol = 3))
meana<- apply(a, MARGIN = 1, FUN = "mean")
meanb <- apply(b, MARGIN=1, FUN="mean")
cova <- cov(t(a))
covb <- cov(t(b))

B <- list(mu = list(meana, meanb), sigma = list(cova, covb))
model <- hmmspec(init, P, parms.emis = B, dens.emis = dmvnorm.hsmm)
train <- simulate.hmmspec(model, 100, seed = 1234, rand.emis = rmvnorm.hsmm)
plot(train)

init0 <- rep(1/J, J)
c<-data.frame(matrix(c(1,1,1,2,3,3,3,2,3), ncol = 3))
d<-data.frame(matrix(c(2,1,3,2,1,4,2,2,4), ncol = 3))
meanc<- apply(c, MARGIN = 1, FUN = "mean")
meand <- apply(d, MARGIN=1, FUN="mean")
covc <- cov(t(c))
covd <- cov(t(d))
B0 <- list(mu = list(meanc, meand), sigma = list(covc, covd))
M <- 200
#d0 <- cbind(dunif(1:M, 1, 50), dunif(1:M, 20, 100), dunif(1:M, 10, 100))
startval <- hmmspec(init0, P, parms.emis = B0, dens.emis = dmvnorm.hsmm)
hmv <- hmmfit(train, startval, mstep = mstep.mvnorm)
summary(hmv)




J<-3
initial <- c(0,0,1)
P <- matrix(c(.8,.5,.1,0.05,.2,.5,.15,.3,.4),nrow=J)
b <- list(mu=c(-3, 0, 2),sigma=c(2,1,.5))
model <- hmmspec(init=initial, trans=P, parms.emission=b,dens.emission=dnorm.hsmm)
model
train <- simulate(model, nsim=300, seed=1234, rand.emis=rnorm.hsmm)
plot(train,xlim=c(0,100))
init0 <- rep(1/J,J)
P0 <- matrix(1/J,nrow=J,ncol=J)
b0 <- list(mu=c(-3,1,3),sigma=c(1,1,1))
startval <- hmmspec(init=init0, trans=P0,parms.emission=b0,dens.emission=dnorm.hsmm)
h1 = hmmfit(train,startval,mstep=mstep.norm)
plot(h1$loglik, type='b',ylab='Log-likelihood',xlab='Iteration')
summary(h1)
#proportion of incorrect states
mean(train$s!=predict(h1,train)$s)

