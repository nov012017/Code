x=c(10,20,30,40,50,60)
t.test(x,mu=20)


girls=c(7,8,9,9,6,7,8,4,5,4,7,5,5,5)
boys=c(5,6,7,5,6,7,8,4,9,6,5,7,5,5)
t.test(girls,boys,alternative = "greater")
