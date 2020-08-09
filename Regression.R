
#�HNBA��Ƭ��ҡA�������N���Ū�J


install.packages("SportsAnalytics")
library(SportsAnalytics)

NBA1516<-fetch_NBAPlayerStatistics("15-16")

str(NBA1516)


#�������򥢭Ȫ����
NBA1516<-NBA1516[complete.cases(NBA1516),] 
str(NBA1516)


#���V�m�ջP���ղ�

# �q1��10�A�H�����T�ӼƦr
sample(1:10,3) 
#�q�Ĥ@���̫�@��A�H����1/3���
sample(1:nrow(NBA1516),nrow(NBA1516)/3) 
#�s�W�@������x�sFALSE
NBA1516$Test<-F 
#�A��䤤1/3�אּTRUE
NBA1516[sample(1:nrow(NBA1516),nrow(NBA1516)/3),]$Test<-T 


# Training set : Test set�y����
c(sum(NBA1516$Test==F),sum(NBA1516$Test==T))
## [1] 317 158






#�ΰV�m�ժ���ơ]NBA1516$Test==F�^�A�V�m�@�Ӧh�ܼƽu�ʰj�k�ҫ�
fit<-glm(TotalPoints~TotalMinutesPlayed+FieldGoalsAttempted+
             Position+ThreesAttempted+FreeThrowsAttempted,
         data =NBA1516[NBA1516$Test==F,])

#fit
 summary(fit)$coefficients





#�v�B��ܼҫ� stepwise ��h�ǲߡG
library(MASS)

##�ھ�AIC�A���v�B���, �w�]�˰h�ǲ� direction = "backward"
finalModel_B<-stepAIC(fit,direction = "backward",trace=FALSE) #trace=FALSE: ���n��ܨB�J

summary(finalModel_B)$coefficients



#�v�B��ܼҫ� stepwise ���e�ǲߡG

##�ھ�AIC�A���v�B���, ���e�ǲ� direction = "forward"
finalModel_F<-stepAIC(fit,direction = "forward",trace=FALSE)

summary(finalModel_F)$coefficients




#�v�B��ܼҫ� stepwise ���V�ǲ�
##�ھ�AIC�A���v�B���, ���V�ǲ� direction = "both"
finalModel_Both<-stepAIC(fit,direction = "both",trace=FALSE)

summary(finalModel_Both)$coefficients





#��Test set�ӵ����ҫ�
#�ϥ�predict���
#�N���ղո�Ʃ�J�w���ҫ���

predictPoint<-predict(finalModel_Both, 
                      newdata = NBA1516[NBA1516$Test==T,])


predictPoint<-predict(fit, 
                      newdata = NBA1516[NBA1516$Test==T,])                                        
#str(predictPoint)
#str(NBA1516[NBA1516$Test==T,])





# self-defined �� R-squared �禡
R_squared <- function(actual, predict){
    mean_of_obs <- rep(mean(actual), length(actual))
    
    SS_tot <- sum((actual - mean_of_obs)^2)  #�`�ܲ�
    
    SS_reg <- sum((predict - mean_of_obs)^2) #�i�������ܲ�
    
    #SS_res <- sum((actual - predict)^2)     #���i�������ܲ�
    
    R_squared <- SS_reg/SS_tot               #1 - (SS_res/SS_tot)
    R_squared
}


c(R_squared(NBA1516[NBA1516$Test==T,]$TotalPoints, predictPoint))




#�����Y��
cor(x=predictPoint,y=NBA1516[NBA1516$Test==T,]$TotalPoints) 

plot(x=predictPoint,y=NBA1516[NBA1516$Test==T,]$TotalPoints)
























