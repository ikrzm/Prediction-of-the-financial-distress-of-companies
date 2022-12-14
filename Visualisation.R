install.packages("ggplot2")
install.packages("corrplot")
install.packages("dplyr")

library(ggplot2)
library(corrplot)
library(dplyr)


#1)Lire la data
data<-read.csv("Salaries.csv")

#2)Expliquer la data
#Colonne BasePay : correspond au salaire de base c'est à dire le salaire Brut
#Colonne OvertimePay : correspond à la rénumération des heures supplémentaires

#3)Netoyer la data
#On remarque qu'on a une seule agency qui est SanFransisco(l <- c(aggregate(x= data$OvertimePay,by = list(data$Agency),FUN = mean)))
#Donc on peut se debarasser de la colonne Agency
#Les colonnes Status et Notes sont à supprimer aussi car elles sont vides (sum(is.na(data$Status)),sum(is.na(data$Notes)))

data$Status <- NULL
data$Notes <- NULL
data$Agency <- NULL

cor(data$BasePay,data$TotalPay,use="complete.obs")
#Une correlation de 95% donc il suffit d'étudier la variable BasePay
cor(data$OtherPay,data$TotalPayBenefits,use="complete.obs")



#3)Analyse de la Data
    #6 premières valeurs de la data
      head(data)
      
      cor(data,use = "complete.obs")

    #On va essayer de voir le métier le plus fréquenté
      #Pour cela on va grouper les lignes qui ont la meme valeurs dans le JobTitle
      liste <- c(by(data,data$JobTitle,nrow))
      sorted <- sort(liste,decreasing=T)
      most_common = sorted[1]
      most_common
      #On peut constater donc que le métier le plus fréquenté dans notre dataset est :
      #Transit Operator

#BasePay
      #Le salaire de base le plus elevé :
       basepay <- data$BasePay
      high = max(basepay,na.rm = TRUE)
      high
      index = which (data$BasePay == high)
      data[index,]$EmployeeName
      data[index,]$JobTitle
       #Gregory P Suhr est la personne qui a le salaire de base le plus elevé
      #Elle exerce la profession de Chief de Police
  


    #Le salaire de base le plus bas
    basepay <- data$BasePay
    low = min(basepay,na.rm = TRUE)
    low
    #ETRANGE! On obtient un salaire de base négatif
    index = which (data$BasePay == low)
    data[index,]$EmployeeName
    data[index,]$JobTitle
      #Irwin Sidharta est la personne qui a le salaire de base négatif et le plus bas
      #Elle exerce la profession de Junior Clerk

    
  #On veut visualiser la moyenne du BasePay par Year
    #Pour cela on va calculer les moyennes regroupés par Year
    #Remplacer les valeurs nulles dans le basePay par la moyenne des valeurs non nulles
      data$BasePay[is.na(data$BasePay)] <- mean(data$BasePay,na.rm=T)
      mean(data$BasePay)
      l <- c(aggregate(x= data$BasePay,     
                   # Specify group indicator
                   by = list(data$Year),      
                   # Specify function (i.e. mean)
                   FUN = mean))
      l
      BasePayMean <- l[[2]]
      Year <- l[[1]]
      df <- data.frame(x = BasePayMean,  y = Year)
      ggplot(df, aes(Year, BasePayMean, fill = BasePayMean)) +   
        geom_bar(stat = "identity") + ylim(0, 80000)
      #La moyenne du BasePay a augmenté durant les années
  
#Overtime
  #Rénumération d'heures supplémentaires la plus élevée:
  overtimepay <- data$OvertimePay
  high = max(overtimepay,na.rm = TRUE)
  high
  index = which (data$OvertimePay == high)
  data[index,]$EmployeeName
  data[index,]$JobTitle
  #GARY JIMENEZ obtient le OvertimePay le plus elevé
  #Il est un CAPTAIN III (POLICE DEPARTMENT)
  

  #Rénumération d'heures supplémentaires la plus basse:
  overtimepay <- data$OvertimePay
  low = min(overtimepay,na.rm = TRUE)
  low
  index = which (data$OvertimePay == low)
  data[index,]$EmployeeName
  data[index,]$JobTitle
  #Dans le OvertimePay aussi,on obtient une valeur négative
  #Claudia M Sanchez a le OvertimePay le plus bas
  #Elle est Senior Eligibility Worker
  
  #La moyenne de la colonne OvertimePay
  #Voir combien de valeurs nulles existent dans le dataset(colonne OvertimePay)
  sum(is.na(data$OvertimePay))
  #4 valeurs nulles dans le dataset
  #Pour calculer la moyenne il faut remplacer les na par la moyenne des valeurs non nulles
  data$OvertimePay[is.na(data$OvertimePay)] <- mean(data$OvertimePay,na.rm=T)
  mean(data$OvertimePay)
  
  #On va grouper les données par Year et calculer la moyenne pour chaque année
   l <- c(aggregate(x= data$OvertimePay,     
            # Specify group indicator
            by = list(data$Year),      
            # Specify function (i.e. mean)
            FUN = mean))
  
  OvertimePayMean <- l[[2]]
  Year <- l[[1]]
  df <- data.frame(x = OvertimePayMean,  y = Year)
  ggplot(df, aes(Year, OvertimePayMean, fill = OvertimePayMean)) +   
    geom_bar(stat = "identity") + ylim(0,6000)
  
  #On remarque que la moyenne du Overtime a évolué durant les années
 
  
#Benefits
  data$Benefits[is.na(data$Benefits)] <- mean(data$Benefits,na.rm=T)
  mean(data$Benefits)
  
  l <- c(aggregate(x= data$Benefits,     
                   # Specify group indicator
                   by = list(data$Year),      
                   # Specify function (i.e. mean)
                   FUN = mean))
  
  BenefitsMean <- l[[2]]
  Year <- l[[1]]
  df <- data.frame(x = BenefitsMean,  y = Year)
  ggplot(df, aes(Year, BenefitsMean, fill = BenefitsMean)) +   
    geom_bar(stat = "identity") + ylim(0, 30000)

#OtherPay
  data$OtherPay[is.na(data$OtherPay)] <- mean(data$OtherPay,na.rm=T)
  mean(data$OtherPay)
  
  l <- c(aggregate(x= data$OtherPay,     
                   #Specify group indicator
                   by = list(data$Year),      
                   # Specify function (i.e. mean)
                   FUN = mean))
  OtherPayMean <- l[[2]]
  Year <- l[[1]]
  
  df <- data.frame(x = OtherPayMean,  y = Year)
  ggplot(df, aes(Year, OtherPayMean, fill = OtherPayMean)) +   
    geom_bar(stat = "identity") + ylim(0,4000)

#Veuillez cliquer sur zoom pour voir la figure plus grande
  
#Visualiser les 10 premiers jobs les premiers fréquenté(sauf le premier)
jobs <- unique(data$JobTitle)
h <-c()
for (val in 1:1000)
{
  v <- jobs[val]
  h<- c(h,sum(data$JobTitle == v))
}
R <- sort(h,decreasing=T)
Title <- c()
for ( val in 1:10)
{
  index = which(R == R[val])
  Title <- c(Title,jobs[index])
}
Title
barplot(R[1:10],
        main = "Most 10 common Jobs",
        names.arg = Title,
        col = "darkred",las=2,cex.names=0.3) 

#10 jobs who have the highest TotalPayBenefits
jobs <- unique(data$JobTitle)
R <- c()
for ( val in 1:1000)
{
  index = which(jobs == jobs[val])
  R <- c(R,data$TotalPayBenefits[index])
}
R <- sort(R,decreasing=T)
for ( val in 1:10)
{
  index = which(h == h[val])
  Title <- c(Title,jobs[index])
}
Title <- Title[1:10]
barplot(h[1:10],
        main = "10 highest TotalPayBenefits",
        names.arg = Title,
        col = "darkred",las=2,cex.names=0.3)



  
  
    
 
  

  
  
  
  
  
  