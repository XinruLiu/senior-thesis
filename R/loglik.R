init0 <- rep(1/3,3)
a <- matrix(c(0.5, 0.25, 0.25, 0.3, 0.4, 0.3, 0.25, 0.25, 0.5),byrow = T, nrow = 3)
b <- list(mu=c(0.87, 0.14, 0.39), sigma=c(0.9, 0.9, 0.9))
hmm.startval<- hmmspec(init = init0, trans = a, parms.emission = b, dens.emission = dnorm.hsmm)
train <- list(x=t(cbind(0.88, 0.13, 0.38)), N=3)
class(train) <- "hsmm.data"
h1<-hmmfit(train, hmm.startval, mstep=mstep.norm, maxit = 10)

ggplot()+geom_abline(slope = 1, intercept = 2)

Returns<-(logreturns(Prices))*10
hmm<-hmmsetcont(Returns, Pi1 = 0.5, Pi2 = 0.5, A11 = 0.7, A12 = 0.3,A21 = 0.3, A22 = 0.7, Mu1 = 5, Mu2 = (-5), Var1 = 10, Var2 = 10)
for(i in 1:6){
  hmm <- baumwelchcont(hmm)
  vit.hmm <- viterbicont(hmm)
  print(vit.hmm$)
  
}

