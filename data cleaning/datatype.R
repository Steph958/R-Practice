

#�򥻸�ƫ��A

###################################################################
#integer, number, logic, character,date
dateBook<-Sys.Date()
dateBook

library(lubridate)
ymd('2012/3/3')
## [1] "2012-03-03"
mdy('3/3/2012')
## [1] "2012-03-03"

?ymd   #HELP!!

a <- 3     
b <- 1.6 
str(a)   #R�w�]�Ʀr���A��number

num1<-1.568
num2<-2.121
round(num2,digits = 1) #2.121�|�ˤ��J�ܤp���I�Ĥ@��
## [1] 2.1
floor(num1) ##1.568
## [1] 1
ceiling(num2) ##2.121
## [1] 3

a <- as.integer(3)
str(a)

# ��ƫ��A	�ഫ�禡
# integer	as.integer()
# number	as.numeric()
# character	as.character()
# factor	as.factor()
# matrix	as.matrix()
# vector	as.vector()
# list	as.list()
# data frame	as.data.frame()

is.integer(a)
is.integer(b)

# ��ƫ��A	�P�_�禡
# integer	is.integer()
# number	is.numeric()
# character	is.character()
# factor	is.factor()
# matrix	is.matrix()
# vector	is.vector()
# list	is.list()
# data frame	is.data.frame()


a <- TRUE
b <- FALSE
str(a)        
is.integer(b)

TRUE & TRUE
## [1] TRUE
TRUE & FALSE
## [1] FALSE
TRUE | TRUE
## [1] TRUE
TRUE | FALSE
## [1] TRUE

!TRUE
## [1] FALSE
!FALSE
## [1] TRUE

a <- "Dr.Lee"    
professor <- a   
str(professor)   

##########################################################3333333#####
#vector
#�bvector�̦��@�ӻݭn�`�N���W�h
#�C�@��element���|�O�ۦP�����A

a <- c(5,10,15,20,25)           # �إߤ@��number vector
b <- c("Tom", "Henry", "John")  # �إߤ@��character vector
a
b

1:20 ## c(1,2,...,19,20)
seq(from=1,to=20,by=1) ##1~20�A�����۹j1

a[3]      # Ans: 15           (����3��element)
a[1:3]    # Ans: 5 10 15      (����1~��3��element)
a[c(2,4)] # Ans: 10 20        (����2�M��4��element)

a <- c(1, "john", 3) # �Y�O��number�Mcharacter�P�ɩ�Jvector�̡A
a                    # R�|�۰ʱN�Ҧ�element�����A�A���ܦ�character 

b <- c(T, 3, F)      # logic�Mnumber�bvector�̪���
b                    # T�MF�|�Q�۰��ഫ��1�M0�A�ܦ��Ʀr��vector


#vector�ƾǹB��:

a <- c(7,8,6,9,5) # �إߤ@��number vector
b <- c(2,4,6,0,1) # �إߤ@��number vector

a * b             # a�Mb���Ĥ@��element�ۭ��A�ĤG��element�ۭ�......
b^3               # ��b�������C�@��element�T����
b > 3             # �P�_b���������ǭȤj�� 3 �A�M��^�� TRUE
a%%b              #�p��l��



###################################################################
#factor
#
# factor�����A�A�D�n�ΨӪ��ܡu���O�ܼơv(category variable)�C
# (�Ҧp�G�ʧO(�k�B�k)�A�~��(�p�@�B�p�G�K.�Ӥ@�B�ӤG)�A�a��(�_�B���B�n�B�F)�K�����C)
# �b��R�i���Ƥ��R�ɡA���J��o���u���O�ܼơv�ɡA�n�ഫ��factor����ƫ��A�A�A��J�ҫ�(model)�i����R�C
# factor����ƫ��A�Mvector�ܬۦ��A�t�O�b��factor�㦳�B�~�����O�ݩ�(Levels)�C
# �n�إ�factor���ܼơA�i�H�ϥ�factor()�禡�G
gender <- c("boy", "girl", "boy", "boy", "girl")  
gender <- factor(gender)  
gender      

levels(gender)  #�d�ݸ̭��s�b�ۭ������O

#factor(��ƦV�q,levels=���O����)�Alevels�Ѽƥi�]�w�U���O������
factor(c("�j�ǥ�","�Ӥh�Z�ǥ�","�դh�Z�ǥ�"),
       levels = c("�j�ǥ�","�Ӥh�Z�ǥ�","�դh�Z�ǥ�"))


###################################################################
#list
#
#list�i�H�s��u���󫬺A�v���ܼ�
Dr.Lee <- list(gender="man", age=18, 
               hobby=c("tease", "be teased"))
Dr.Lee 

str(Dr.Lee)
Dr.Lee[[3]] 
## [1] "tease"     "be teased"
Dr.Lee[3]   
## $hobby
## [1] "tease"     "be teased"

str(Dr.Lee[[3]] )     # Ans:�ϥΨ�Ӥ��A���A���X�Ӫ���ƬOvector
str(Dr.Lee[3] )       # Ans:�ϥΤ@�Ӥ��A���A���X�Ӫ���ƬOlist

listSample<-list(Students=c("Tom","Kobe","Emma","Amy"),Year=2017,
                 Score=c(60,50,80,40),School="CGU")

listSample$Students
#[1] "Tom"  "Kobe" "Emma" "Amy"

listSample$Year
#[1] 2017

listSample$Score
#[1] 60 50 80 40

listSample$School
#[1] "CGU"

listSample[[1]] ##���o�������Ĥ@���ܶq����
## [1] "Tom"  "Kobe" "Emma" "Amy"

#�p�G�u�ϥγ椤�A���A�^�Ǫ���ƫ��A�|�O�C��list�A�ëD�C��������
listSample[1] ##���o�������Ĥ@���ܶq�]�C�����A�^
## $Students
## [1] "Tom"  "Kobe" "Emma" "Amy"


#�C����Ƥ]�i�M�V�q��Ƥ@�ˡA���s�s��]�w
listSample[[1]] 
## [1] "Tom"  "Kobe" "Emma" "Amy"
listSample[[1]]<-c("�p��","�j��","�D��","�p�s","�j��") ##�NStudents�ܶq���s�]�w
listSample[[1]] 
## [1] "�p��" "�j��" "�D��" "�p�s" "�j��"

#���F�s��H�~�A�C����Ƥ]���$�Ÿ��P<-�ܼƳ]�w�Ÿ��s�W
listSample$Gender<-c("M","F","M","F","M") ##�s�WGender�ܶq�A�ó]�w�V�q��

#�Y�ݧR���Y�ܶq�A�i�N�ܶq�ȳ]�w��NULL
listSample$Score<-NULL ##�R��Score�ܶq



###################################################################
#matrix

a <- matrix(c(1:6), nrow=3, ncol=2) #�إߤ@��3x2���x�}�A�̷�column���O��J1~6����
a

b <- matrix(c(3:8), nrow=2, ncol=3) #�إߤ@��2x3���x�}�A�̷�column���O��J3~8����
b

a[2,2]
b[1, ] 

a %*% b #�x�}�ۭ�

# �M�x�}�������B��禡�G
# 
# t(x)�G�N�x�}��m�C
# %*%�G�x�}�ۭ��C
# diag()�G���ͤ@�ӹ﨤�x�}�A�Φ^�ǯx�}���﨤�u�V�q
# det()�G�p��x�}��C���ȡA�@�w�O�n��ٯx�}�C
# solve()�G�Ǧ^�x�}���ϯx�}�A�D�`�A�X�ѽu�ʤ�{���C
# eigen()�G�p��x�}���S�x�V�q�P�S�x�ȡC

#�إߤ@��3x2���x�}�A�H���q1~100����J6�ӭ�
a <- matrix(sample(1:100, size=6), nrow=3, ncol=2) 
#�إߤ@��2x3���x�}�A�H���q1~100����J6�ӭ�
b <- matrix(sample(1:100, size=6), nrow=2, ncol=3) 
#�إߤ@��4x4����}�A�H���q1~100����J16�ӭ�
c <- matrix(sample(1:100, size=16), nrow=4, ncol=4)


x = 1:30
x.matrix = matrix(x,5,6)   #�w�]��byrow = FALSE
x.matrix_2 = matrix(x,5,6,byrow = TRUE)

#�d�߯x�}�ݩ�
str(x.matrix)
nrow(x.matrix)
ncol(x.matrix)
dim(x.matrix)
length(x.matrix)


Vince=c(1,2,3,4,5)
Curry=c(9,8,7,6,5)
Klay=c(-1,-2,-3,-4,-5)
rmatrix = rbind(Vince,Curry,Klay)
cmatrix = cbind(Vince,Curry,Klay)
#�h���������: matrix[�C�A��]
#Ex:
rmatrix[-1,-2]
cmatrix[-2,-1]
rmatrix[ ,2:4]
rmatrix[ ,-2:-4]
rmatrix[-1:-2]
rmatrix[1,2] = NA


#�]�w���W��
colnames(rmatrix) = c("hobby","figure","score","speed","jump")

#��m�x�}
t(rmatrix)


###################################################################
#�T���}�C��:Array()
high.dim = array(1:1000,dim=c(10,10,10))







###################################################################
#dataframe

#Ū�J:

#��k�@
AV.data.csv = read.csv(file.choose())
AV.data.csv #�z�L��ܮت�������n�}�Ҫ��ɮ�

#��k�G
AV.data.csv = read.csv("C:/Users/USER/Desktop/R resourse/R/AV data.csv")
AV.data.csv #�z�L�ɮת�������|�I�s

str(AV.data.csv)

#�۳y:
tmp <- data.frame(Student_ID=c(1,2,3,4,5),
                  name=c("Helen", "Lun", "Leon", "Kevin", "Tommy"),
                  score=c(80,36, 88.9, 97.5, 60))
tmp       

tmp[4,3]
tmp[1, ] 
tmp[, 3]
tmp$name  
tmp[tmp$name == "Leon", ]
tmp[c(FALSE, FALSE, TRUE, FALSE, FALSE), ]



name=c("�e�Э�´","��������","������","�i�h������","Edita","Princessdolly")
nation = c("JAPAN","JAPAN","JAPAN","JAPAN","Russia","Taiwan")
genre = c("DP","Anal","Group","Gangbang","bigtit","hugecock")
breast = c("middle","proper","middle","E cup","small","D cup")
episodes = c(12,16,14,36,10,6)

AV.data=data.frame(name,nation,genre,breast,episodes)
AV.data

#���o�������
AV.data["genre"]
AV.data$genre

AV.data["name","breast"]

AV.data[2]
AV.data[3, ]

colnames(AV.data)
rownames(AV.data)
str(AV.data)

#�����
AV.data$episodes[2] <- 39
AV.data
AV.data$episodes <- NULL
AV.data

#�W�[���
rbind(AV.data,c("�ۿA�n","JAPAN","Gangbang","middle",20,18500))

#�W�[���
salary = c(10500,9500,10000,25000,16590,20500)
AV.data$salary = salary

#�z�L�s�边�s�W���
AV.data.edit = edit(AV.data)
AV.data.edit


#���|
getwd()
setwd("C:/Users/USER/Documents/R")

#�s���ɮסB�s���ɮ�
cat("Hello\nWorld!",file="practice.txt")
cat("\n","Do you wanna I give you an assfuck?",file="practice.txt",append = TRUE)

#�N��Ʈج[�g�X�ɮ�
write.csv(AV.data, file = "AV data.csv")



###################################################################
#����ݩʬd��
islands

head(islands)
head(names(islands))

USArrests

head(USArrests) #�Y����ƮءA�h�|��ܦ�]���^�W��
head(names(USArrests))

dimnames(USArrests) 

length(USArrests) #�Y��Ʀ�A����ƮءA�h�|��ܦ�]���^��
length(islands) 

dim(USArrests) #���C���

�ϥ�class()��ƥi���D�ܼ����O

class(1)
## [1] "numeric"
class("Test")
## [1] "character"
class(Sys.Date())
## [1] "Date"

#�ϥ�table()��ƥi���D�V�q���C�ӭȥX�{�X��
iris$Species ##��l��
table(iris$Species) ##�έp���G


