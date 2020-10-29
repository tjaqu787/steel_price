# obtain data on GDP, Deflator and S&P 500 index

y <- read.csv("~/Downloads/final.csv", row.names=1)


library(vars)

VARselect(y, lag.max=8, type="none")

varp <- VAR(y, ic="AIC", lag.max=3, type="const")
summary(varp)
#restrict to improve
resvar<-restrict(varp, method ='ser',thresh = 1.0 )

#Diagnostics
# resvar.irfs <- irf(resvar, n.ahead=20)
# par(mfcol=c(2,2), cex=0.6)
# plot(resvar.irfs, plot.type="single")
# 
# 
# resvar.fevd<- fevd(resvar, n.ahead=10)
# plot(resvar.fevd,plot.type="single")
# 
# forecasting

resvar.f <- predict(resvar,newdata=tail(y,24), n.ahead=24,ci=.7)
resvar.f$endog<- tail(resvar.f$endog,20)
par(mar=c(1,1,1,1))
plot(resvar.f)
plot(resvar.f$fcst$steel_price)




