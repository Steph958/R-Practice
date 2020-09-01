naVec<-c("a","b",NA,"d","e")
is.na(naVec)

naVec[!is.na(naVec)] 
##�O�d�Ҧ��bis.na()�ˬd�^��FALSE������

head(airquality) 
#��Ʈ�
#�ϥ�complete.cases�ӿ�X���㪺��ƦC�A�p�G��ƦC�O���㪺�A�h�|�^�ǯuTRUE

complete.cases(airquality) 
head(airquality[complete.cases(airquality),]) 
##�O�d�Ҧ��bcomplete.cases()�ˬd�^��TRUE������






#############################################################################################
#�Q�κt��k�ɭȤ]�O�@�ظѨM��k�A
#�i�Ѧ�_skydome20_��R���O�V(10)��|�ȳB�z(Impute Missing Value)�оǡC

tmp <- c(1,5,8,NA,5,NA,6)
is.na(tmp)
## [1] FALSE FALSE FALSE  TRUE FALSE  TRUE FALSE
# �p���|�Ȫ��Ӽ�
sum(is.na(tmp))


install.packages("missForest") # prodNA() function

library(missForest)
# �biris��Ƥ��A�H������10%����|��
data <- prodNA(iris, noNA = 0.1)
# �i�H�`�N��A��Ƹ̭���NA���s�b�A�N��Not-Available(��|��)
head(data)

#############################################################################################
#  1. ������������|�Ȫ����

# ���@����ƬO���㪺�A�^��TRUE�F���@����Ʀ���|�ȡA�^��FALSE
complete.cases(data)
# ��������|�Ȫ����
rm.data <- data[complete.cases(data), ] #�w�]��TRUE
rm.data



#############################################################################################
# 2. �Ρu�����ơv�B�u�Ĥ@�|����ơv�K�Ӷ�ɿ�|��
# �H�U�Υ����ơA�Ӷ�ɬY�@��쪺��|��

mean.data <- data

mean.1 <- mean(mean.data[, 1], na.rm = T)  # �Ĥ@��쪺������
na.rows <- is.na(mean.data[, 1])           # �Ĥ@��줤�A����|�Ȧs�b�����

# �βĤ@��쪺�����ơA��ɲĤ@��쪺��|��
mean.data[na.rows, 1] <- mean.1





#############################################################################################
# 3. ��K-Nearest Neighbours��ɿ�|��
#��M�ۤv�ܹ���K�ӾF�~�A�M��q�L�̨��W"�ƻs"�ۤv�ҨS�����F��

install.packages("DMwR")
library(DMwR)

imputeData <- knnImputation(data)
head(imputeData)



#############################################################################################
# 4. ��MICE��ɿ�|��
#�{�b�ڭ̦����V1,V2,V3�K�KVn�A�C�����̭�������|�ȡC
# ���ڭ̭n���V1����|�ȮɡA�N����V2,V3�K�KVn�������@���ܼ�(X)�A��V1���@���ܼ�(Y)�A�åB�i��ؼҡA�M��ιw�������G�Ӷ��V1����|�ȡC
# �P�z�A�w��V2�A�N��V1,V3�K�KVn�ؼҡA�M��ιw�������G�Ӷ��V2����|�ȡC

install.packages("mice")
library(mice)

mice.data <- mice(data,
                  m = 3,           # ���ͤT�ӳQ��ɦn����ƪ�
                  maxit = 50,      # max iteration
                  method = "cart", # �ϥ�CART�M����A�i���|�ȹw��
                  seed = 188)      # set.seed()�A�O��˨C�����@��

# ��l���(����|��)
data

# ��ɦn����ơG�]��m=3�A�ҥH�|���T�Ӷ�ɦn����ƶ��A�i�H�ΥH�U�覡���X

complete(mice.data, 1) # 1st data
complete(mice.data, 2) # 2nd data
complete(mice.data, 3) # 3rd data


#�i�H�����䤤�@�ӡu��ɦn����ơv�A�Ӷi����򪺫ؼҤF�I

# e.g. ���ĤG�Ӹ�ơA�@���ګ�����R�����
df <- complete(mice.data, 2)
head(df)
# �M��Hdf�i��u�ʰj�k�B�����g�����B�D�������R...����
