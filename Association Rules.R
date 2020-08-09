
# ���p���W�h
#
# �Ω�q�j�q�ƾڤ������X�����Ȫ��ƾڶ��������������Y�A
# ��h�����Ҽ{���ت����ǡA�ӶȦҼ{��զX�C
# �ۦW���ʪ��x���R (Market Basket Analysis)�Y�����p���W�h���R�����ΡC
# Apriori�t��k�O�������L���p�W�h (Boolean association rules) �W�c��������k

install.packages("arules")

library(arules)

#�H�U�H�W����Ƭ��ҡA�ϥ����p���W�h���R�����ʪ��x���R�C
#������Ū�J�W�����O���

# Load the libraries
if (!require('arules')){
    install.packages("arules");
    library(arules) #for Apriori�t��k
}
if (!require('datasets')){
    install.packages("datasets");
    library(datasets) #for Groceries data
}

data(Groceries) # Load the data set
Groceries@data@Dim #169 �ذӫ~�A9835��������



#�i�ϥ�arules�M�󤤪�apriori��ƨӹ�@apriori�t��k
# Get the rules

rules <- apriori(Groceries, # data= Groceries
                 parameter = list(supp = 0.001, conf = 0.8), #�ѼƳ̧C����
                   control = list(verbose=F)) #���n���output

# �����(min support)�G�u�W�h�v�b��Ƥ��㦳���M�ʡA�]�N�O�o�� A �� B �P�ɥX�{�����v�h��
# �H���(min confidence)�G�u�W�h�v�n���@�w���H�ߤ��ǡA�]�N�O���ʶR A ���A�U�A�]�|�ʶR B ��������v

#rules
options(digits=2) # Only 2 digits
inspect(rules[1:5]) # Show the top 5 rules









#�ھڭp�⵲�G�A��Ū�ҫ�����k�p�U�G
#
#��s=>����
#
# Support: �@��������A�]�A�W�h�������~�����v�C�R��s�P�ɶR���������v�C�涰
# Confidence: �]�t���䪫�~A������]�|�]�t�k�䪫�~B��������v�C�b�R�F��s���U�Ȥ��A���R��������ҡC
# Lift: �W�h���H�ߤ����Ȱ��h�֡C�]�R�F��s�H��A���R���������v�^/�]�b�Ҧ��U�ȸs���R���������v�^
    # lift=1: items on the left and right are independent.



#�αƧǥ\��Ƨǫ�A�C�X�̦����s�]confidence�̰��^���X���W�h

rules<-sort(rules, by="confidence", decreasing=TRUE) #����confidence�Ƨ�
inspect(rules[1:5]) # Show the top 5 rules



#�S�O�w��Y���ӫ~�]�k���ܼơ^
#���O�G�R�F����F�誺�H�A�|�R�����O�H
rulesR<-apriori(data=Groceries, parameter=list(supp=0.001,conf = 0.08),
                appearance = list(default="lhs",rhs="whole milk"), #�]�w�k��@�w�n�O����
                control = list(verbose=F)) #���n���output

rulesR<-sort(rulesR, decreasing=TRUE,by="confidence") #����confidence�Ƨ�
inspect(rulesR[1:5]) # Show the top 5 rules


#�S�O�w��Y���ӫ~�]�����ܼơ^
#���O�G�R�F�������H�A�|�R����O�H
rulesL<-apriori(data=Groceries, parameter=list(supp=0.001,conf = 0.15,minlen=2),
                appearance = list(default="rhs",lhs="whole milk"), #�]�w����@�w�n�O����
                control = list(verbose=F)) #���n���output

rulesL<-sort(rulesL, decreasing=TRUE,by="confidence") #����confidence�Ƨ�
inspect(rulesL[1:5]) # Show the top 5 rules







#���W�h�P�_�P�h��

# ���ھ� support �j�p�Ƨ� rules:

sort.rules <- sort(rules, by="support")

# 'arules' version = 1.4-2 , under R-3.2.5
subset.matrix <- is.subset(x=sort.rules, y=sort.rules)
subset.matrix 

# 'arules' version = 1.5-2 , under R-3.4.0
subset.matrix <- as.matrix(is.subset(x=sort.rules, y=sort.rules))
subset.matrix  #�bX�����ءA�p�G�OY���ت��l��(subset)�A�N�|�^��TRUE�C
              #���A��RStudio���}subset.matrix�o���ܼƮɡA�|�ݨ��@��kxk���x�}


#�A�i��H�U�B�J�G

# ��o�ӯx�}���U�T���h���A�u�d�W�T������T
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
subset.matrix

# �p��C��column��TRUE���ӼơA�Y���@�ӥH�W��TRUE�A�N����column�O�h�l��
redundant <- colSums(subset.matrix, na.rm=T) >= 1
str(redundant)

# �����h�l���W�h
sort.rules <- sort.rules[!redundant]
sort.rules

inspect(sort.rules)









#�W�h��ı��

if (!require('arulesViz')){
    install.packages("arulesViz"); 
    library(arulesViz)
}

plot(sort.rules)
plot(sort.rules, method="graph")
plot(sort.rules,method="graph",interactive=TRUE,shading=NA) 
plot(sort.rules, method="grouped")
#�|�]�@�}�l







