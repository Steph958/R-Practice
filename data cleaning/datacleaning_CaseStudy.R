
#��ƲM�~��X�m��#####################################################

install.packages("SportsAnalytics")

library(SportsAnalytics)

NBA1516<-fetch_NBAPlayerStatistics("15-16")

str(NBA1516)
head(NBA1516)





#��ƱƧǫ�z��#####################################################


#�Q�n��X�X���Ƴ̰����e���W��⪺�Ҧ����
NBA1516Order<-NBA1516[order(NBA1516$GamesPlayed,decreasing = T),]

NBA1516Order[1:5,] 
##�r���e���1~5�A���ܨ�1~5�C�F�r�����ťաA���ܭn���Ҧ����



#�Q�n�X�X�������Ƴ̰����e�Q�W��⪺�W�r
NBA1516OrderM<-NBA1516[order(NBA1516$TotalMinutesPlayed,decreasing = T),]
NBA1516OrderM[1:10,"Name"] 
##�r���e���1~10�C�F�r������"Name"�A���ܨ��W�٬�Name�����



#���ȿz��#####

subset(NBA1516,Team=="BOS")

#�r�����j�M��z��#######################################################
#�N�Ҧ��W�r�̦���James��������ƨ��X

NBA1516[grepl("James",NBA1516$Name),]



