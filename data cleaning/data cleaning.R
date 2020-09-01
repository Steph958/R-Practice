########################################################################################
#��ƫ��O�ഫ
num<-100
cha<-'200'
boo<-T


is.numeric(num)
## [1] TRUE
is.numeric(cha)
## [1] FALSE
is.character(num)
## [1] FALSE
is.character(cha)
## [1] TRUE
is.logical(boo)
## [1] TRUE


class(num)
## [1] "numeric"
class(cha)
## [1] "character"
class(boo)
## [1] "logical"
class(Sys.Date())
## [1] "Date"


as.numeric(cha)
## [1] 200
as.numeric(boo)
## [1] 1
as.character(num)
## [1] "100"
as.character(boo)
## [1] "TRUE"
as.numeric("abc")
## Warning: NAs introduced by coercion
## [1] NA


library(lubridate)
ymd('2012/3/3')
## [1] "2012-03-03"
mdy('3/3/2012')
## [1] "2012-03-03"



########################################################################################
#��r�r��B�z

# ���� strsplit()
# �l�� substr()
# �j�p�g�ഫ toupper() tolower()
# ���r�s�� paste() paste0()
# ��r���N gsub()
# �e��ťեh�� str_trim() �ݦw��stringr(Wickham 2019b) package

strsplit ("Hello World"," ")
## [1] "Hello" "World"
toupper("Hello World")
## [1] "HELLO WORLD"
tolower("Hello World")
## [1] "hello world"
paste("Hello", "World", sep='')
## [1] "HelloWorld"
substr("Hello World", start=2,stop=4)
## [1] "ell"
gsub("o","0","Hello World")
## [1] "Hell0 W0rld"

library(stringr)
str_trim(" Hello World ")
## [1] "Hello World"




grep("A",c("Alex","Tom","Amy","Joy","Emma")) 
##�b�m�W��r�V�q���M��A�A�^�ǥ]�t"A"��������m
## [1] 1 3
grepl("A",c("Alex","Tom","Amy","Joy","Emma")) 
##�b�m�W��r�V�q���M��A�A�^�ǦU�����O�_�]�t"A"
## [1]  TRUE FALSE  TRUE FALSE FALSE


########################################################################################
#�l��Subset
#�@����� (�V�q)

letters 
##  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s"
## [20] "t" "u" "v" "w" "x" "y" "z"
letters[1] ##���Xletters�V�q���Ĥ@�Ӥ���
## [1] "a"
letters[1:10] ##���Xletters�V�q���e�Q�Ӥ���
##  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j"
letters[c(1,3,5)] ##���Xletters�V�q����1,3,5�Ӥ���
## [1] "a" "c" "e"
letters[c(-1,-3,-5)] ##���Xletters�V�q���F��1,3,5�Ӥ������~���Ҧ�����
##  [1] "b" "d" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v"
## [20] "w" "x" "y" "z"

#�Y�Q�n�ֳt���o�@�V�q���}�Y�P���������A�i�ϥ�head()�Mtail()���

head(letters,5) ##���Xletters�V�q���e���Ӥ���
## [1] "a" "b" "c" "d" "e"
tail(letters,3) ##���Xletters�V�q����T�Ӥ���
## [1] "x" "y" "z"


#�G�����
# �̱`�����G����Ƭ�data.frame��Ʈ�
#�H,���j�C�P�檺�z�����A��ƿz���h���eRow,��Column
#�Y���Q�z��C�A�h�b,�e��O���ťէY�i�C
# 
# �z��覡�i��J��m(index)�B���W�٩ο�J���L�ܼ�(TRUE/FALSE)
# 
# ��J��m: dataFrame[row index,column index]
# ��J���L�ܼ�: dataFrame[c(T,F,T),c(T,F,T)]
# ��J���W��: dataFrame[row name,column name]

data(iris)
iris[1,2] ##�Ĥ@�CRow�A�ĤG��Column
iris[1:3,] ##��1~3�CRow�A�Ҧ�����Column
iris[,"Species"] ##�Ҧ����CRow�A�W�٬�Species����Column
iris[1:10,c(T,F,T,F,T)] ##��1~10�CRow�A��1,3,5��Column (TRUE)
iris$Species ##�Ҧ����CRow�A�W�٬�Species����Column


#Row���z��i�ϥ�subset()��ơA�ϥΤ�k��subset(��ƪ�,�z���޿�)
subset(iris,Species=="virginica") ##Species����"virginica"���CRow�A�Ҧ�����Column
#Row���z��]�i�f�t�r��j�M���grepl()
knitr::kable(iris[grepl("color",iris$Species),]) ##Species�]�t"color"���C�A�Ҧ�����

tail(iris,3) ##���Xiris��Ʈت���T�C
head(iris,5) ##���Xiris��Ʈت��e���C


########################################################################################
#�Ƨ�order


#sort()��ƥi������V�q���Ѥp��j���Ƨ�
head(islands) ##�Ƨǫe���e�������
head(sort(islands)) ##�Ѥp��j�Ƨǫ᪺�e�������
head(sort(islands,decreasing = T)) ##�Ѥj��p�Ƨǫ᪺�e�������


#�p�ݹ��Ʈذ��ƧǡA�i�ϥ�order()���
#�^�ǥѤp��j��������m(index)
order(iris$Sepal.Length)
iris$Sepal.Length[14] #�ƭȳ̤p����������14�Ӥ���

order(iris$Sepal.Length,decreasing = T)
iris$Sepal.Length[132] #�ƭȳ̤j����������132�Ӥ���


head(iris[order(iris$Sepal.Length),]) 
##�̷�Sepal.Length���ƭȤj�p�Ƨǫ᪺�e������ơA�w�]decreasing = F
head(iris[order(iris$Sepal.Length,decreasing = T),]) 
##�אּ�Ѥj��p�ƧǪ��e�������



########################################################################################
#��ƲզX

rbind(c(1,2,3), #�Ĥ@�C
      c(4,5,6)  #�ĤG�C
) 


irisAdd<-rbind(iris, #��Ʈ�
               c(1,1,1,1,"versicolor")  #�s�W�@�C >> 151�C
) 
tail(irisAdd)


cbind(c(1,2,3), #�Ĥ@��
      c(4,5,6)  #�ĤG��
) 

irisAdd<-cbind(iris, #��Ʈ�
               rep("Add",nrow(iris))  #�s�W�@��
) 
tail(irisAdd)


########################################################################################
#��Ƶ��X

nameDF<-data.frame(ID=c(1,2,3,4,5),
                   Name=c("Amy","Bob","Chris","David","Emma"))

scoreDF<-data.frame(ID=c(1,2,4),
                    Score=c(60,90,50))

nameDF
scoreDF

merge(nameDF,scoreDF,by="ID")
merge(nameDF,scoreDF,by="ID",all=T)
merge(nameDF,scoreDF,by="ID",all.x=T)
merge(nameDF,scoreDF,by="ID",all.y=T)


#dplyr�M�󴣨ѧ󦳮Ĳv����Ƶ��X��k�A�]�A:

install.packages("dplyr")
library(dplyr) #�ϥΫe�������J�M��

inner_join(nameDF,scoreDF,by="ID") #�O�d�������쪺���
##   ID  Name Score
## 1  1   Amy    60
## 2  2   Bob    90
## 3  4 David    50

left_join(nameDF,scoreDF,by="ID")#�O�d���䪺���Ҧ����C
##   ID  Name Score
## 1  1   Amy    60
## 2  2   Bob    90
## 3  3 Chris    NA
## 4  4 David    50
## 5  5  Emma    NA

right_join(nameDF,scoreDF,by="ID")#�O�d�k�䪺���Ҧ����C
##   ID  Name Score
## 1  1   Amy    60
## 2  2   Bob    90
## 3  4 David    50

full_join(nameDF,scoreDF,by="ID")
##   ID  Name Score
## 1  1   Amy    60
## 2  2   Bob    90
## 3  3 Chris    NA
## 4  4 David    50
## 5  5  Emma    NA

semi_join(nameDF,scoreDF,by="ID") #�d�U���䪺ID�]���X�{�b�k�䪺�����C�A�k����Ƥ��|��X
##   ID  Name
## 1  1   Amy
## 2  2   Bob
## 3  4 David

anti_join(nameDF,scoreDF,by="ID")



