#Inner Join
df3=merge(x=df1,y=df2,by="id")
# Left Join
df3=merge(x=df1,y=df2,by="id",all.x = T)
#Right Join
df3=merge(x=df1,y=df2,by="id",all.Y = T)
#Full Outer Join
df3=merge(x=df1,y=df2,by="id",all.x = T,all.y=T)

#Different Column Names
df3=merge(df1,df2,by.x="ID", by.y="Rno",all.x=T,all.y = T)

#Composite
df3=merge(df1,df2, by=c("ID","Department"))
df3=merge(df1,df2, by.x =c("ID","Department"),by.y = c("id","dept1"),all.x = T)

str(df1)

df_left=df1[,c(1,2,3,4)]
str(df_left)
df_right=df1[,c(1,5,6)]
str(df_left)

InnerJoin=merge(x=df_left,y=df_right,by="Loan_ID")
View(InnerJoin)





