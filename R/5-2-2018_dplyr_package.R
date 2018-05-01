#Handy dplyr Verb:
  #Filter --> Filter()
  #Select  ->> select ()
  #Arrange --> arrange()
  #Mutate --> mutate
  #summarise --> summarise()

library(dplyr)
data(mtcars)

data(mtcars)
temp <- mtcars
View(temp)


######Filter
#base package
  temp[(temp$gear==5 & temp$cyl==8),]
#dplyr
  filter(temp,cyl==8, gear==5)
  filter(temp,cyl==8 & gear==5)
  filter(temp,cyl==8 |gear==5)
  filter(mtcars,cyl %in% c(6,8))
  temp$Name <- rownames(temp) # dplyr package wont return the row index

######Select 
#base package
  temp[,c("mpg","cyl","disp")]
#dplyr package'
  select(temp,Name,cyl,gear)
  select(temp,mpg:disp,contains("gear"),contains("carb"))
  select(temp,mpg:disp,"gear","carb")
  select(temp,-contains("gear"))
  select(temp,-gear)
  
#####Order
  #base package
    temp[order(temp$cyl,decreasing = T),c("cyl","gear")]
    temp[order(temp$cyl,temp$gear,decreasing = T),c("cyl","gear")]
  #dplyr package' 
    arrange(select(temp,cyl,gear,Name),cyl)
    arrange(select(temp,cyl,gear,Name),cyl,Name)
    arrange(select(temp,cyl,gear,Name),desc(cyl),Name)

####Mutate
    temp <- mutate(temp,mutate_new=temp$hp + temp$wt)

#####Distinct
  #base package
    unique(temp$cyl,temp$gear)
  #dplyr package' 
    distinct(temp["cyl"])
    distinct(temp[c("cyl","gear")])    
    
###Aggregate
    aggregate(temp,by=list(temp$cyl),FUN= mean, na.rm=TRUE)
    aggregate(temp[,c("mpg","disp","hp"),by=list(temp$mpg),FUN= mean, na.rm=TRUE]) 
    #dplyr package'
    summarise(temp,avg_mpg=mean(mpg),avg_disp=mean(disp))
    summarise(group_by(mtcars,cyl),avg_mpg=mean(mpg))
    summarise(group_by(mtcars,cyl),avg_mpg=mean(mpg),avg_disp=mean(disp),na.rm=T)  

##Exclude
    a = factor(rep(c("A","B","C"),10))
table(a)
table(a,exclude="B")

#dplyr approach

summarise(group_by(temp,cyl),freq=n())
summarise(group_by(temp,cyl),freq=n(),n_distinct(gear))

###Merge two data frames
  merge(df,df1)
  #dply package
  inner_join(df,df1)
  left_join(df,df1,by=c("","",""))
  
##head
  #dplyr package
  head(select(temp,cyl,gear))

### Pipe line
  temp %>%
    select(cyl,gear) %>%
    head(20)