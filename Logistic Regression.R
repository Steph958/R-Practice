


mydata <- read.csv("https://raw.githubusercontent.com/CGUIM-BigDataAnalysis/BigDataCGUIM/master/binary.csv")
str(mydata)

mydata$admit <- factor(mydata$admit) # ���O�ܶ��n�ରfactor
mydata$rank <- factor(mydata$rank) # ���O�ܶ��n�ରfactor


mydata$Test<-F 
#�s�W�@�ӰѼƬ�������
mydata[sample(1:nrow(mydata),nrow(mydata)/3),"Test"]<-T 
#�H����1/3��Test set
c(sum(mydata$Test==F),sum(mydata$Test==T)) 
# Training set : Test set�ǥͼ�
## [1] 267 133



#�ק�@�Ufactor��level
mydata$admit<-factor(mydata$admit,levels=c(1,0))
mydata$admit




# GRE:�Y�Ҹզ��Z, GPA:�b�ե������Z, rank:�Ǯ��n��
library(MASS)

mylogit <- glm(admit ~ gre + gpa + rank,
               data = mydata[mydata$Test==F,], family = "binomial")

finalFit<-stepAIC(mylogit,direction = "both",trace=FALSE) 
# ���V�v�B��ܼҫ�

summary(finalFit)





#�ιw���չw���s�ǥͥi���i�H�����A�����ҵ���

AdmitProb<-predict(finalFit, # ��Training set�����ҫ�
                   newdata = mydata[mydata$Test==T,], #Test==T, test data
                   type="response") #���G���C�ӤH�Q���������v

#AdmitProb
head(AdmitProb)

table(AdmitProb<0.5,mydata[mydata$Test==T,]$admit) 
# �V�c�x�} Confusion Metrix
#
# Accuracy(�ǽT��):���T�w�������v 
(2+36)/(2+8+87+36)
# Recall(�l�^�v):��ڬ�TRUE�]�Q�w����TRUE�����v
36/(87+36)
# Specificity(���T�v):��ڬ�FALSE�]�Q�w����FALSE�����v
2/(2+8)
# Precision(��T��):�Q�w����True�����A��ڬ�True�����v
36/(8+36)



#�p��w���į�Ѽ�
install.packages("caret")

library(caret) 

AdmitAns = ifelse(AdmitProb > 0.5,1,0)
AdmitAns <- factor(AdmitAns)

sensitivity(AdmitAns,mydata[mydata$Test==T,]$admit)

specificity(AdmitAns,mydata[mydata$Test==T,]$admit)

posPredValue(AdmitAns,mydata[mydata$Test==T,]$admit)

negPredValue(AdmitAns,mydata[mydata$Test==T,]$admit)

