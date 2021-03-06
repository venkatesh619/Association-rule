##Reading  the data file
mydata<-read.csv("C:/Users/Never Give UP/Desktop/Cosmetics.csv",header=T)
summary(mydata)
names(mydata)
head(mydata)

##Finding association rules
library(arules)
rules <- apriori(mydata)

##Rules with specified parameter valus
rules <- apriori(mydata,parameter = list(minlen=2, maxlen=10,supp=.7, conf=.8))
inspect(rules)

##Finding interesting rules-1
rules <- apriori(mydata,parameter = list(minlen=2, maxlen=3,supp=.01, conf=.7),appearance=list(rhs=c("Foundation=Yes"),lhs=c("Bag=Yes", "Blush=Yes"),default="lhs"))
inspect(rules)

##Finding interesting rules-2
rules <- apriori(mydata,parameter = list(minlen=2, maxlen=5,supp=.1, conf=.5),appearance=list(rhs=c("Foundation=Yes"),lhs=c("Bag=Yes", "Blush=Yes", "Nail.Polish=Yes", "Brushes=Yes", "Concealer=Yes", "Eyebrow.Pencils=Yes", "Bronzer=Yes", "Lip.liner=Yes", "Mascara=Yes", "Eye.shadow=Yes","Lip.Gloss=Yes", "Lipstick=Yes", "Eyeliner=Yes"),default="none"))
quality(rules)<-round(quality(rules),digits=3)
rules.sorted <- sort(rules, by="lift")
inspect(rules.sorted)

##Finding redundancy
subset.matrix<-is.subset(rules.sorted,rules.sorted)
subset.matrix[lower.tri(subset.matrix,diag=T)]<-NA
redundant<-colSums(subset.matrix,na.rm=T)>=1
which(redundant)

##Removing redundant rules
rules.pruned<-rules.sorted[!redundant]
inspect(rules.pruned)

##Graphs and Charts
library(arulesViz)
plot(rules.all)
plot(rules.all,method="grouped")
plot(rules.all,method="graph",control=list(type="items"))
