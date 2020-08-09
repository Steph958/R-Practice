
# ���g�ؿ�

    # ²��
    # Support Vector Machine(SVM)�G�p���SVM�Ӥ���(���O)

    # SVM�b�h������(multi-class)���ޥ�
        # One-against-Rest
        # One-against-One

    # Support Vector Regression(SVR)�G�p���SVR�ӹw��(�s��)

    # �ѼưQ��
        # C(cost)
        # Epsilon (�`)
        # Gamma

    # �Ѽƽվ�(Tune Parameters)�G�p��վ�SVM���ѼơA���ҫ����{�X�̨Ϊ��A
        # Tune parameters in SVM(soft-margin)
        # Tune parameters in SVR

#####################################################################################

# SVM�O�@�ت��W���G��������(binary classifier)�A
# �ѫXù�����έp�ǮaVapnik ���H�Ҵ��X�A�@�ذ��έp�ǲ߲z�ת��t��k�C
# 
# ²��a���ASVM�O�@�غʷ����ǲߪ��t��k�A
# �չϱq��Ƥ��غc�@�ӶW����(hyperplane)�A�N��ưϤ���������O(2 classes)�A
# �̫�i��w��/�����C
#
# �@���H�ӡASVM�N�O��Ƭ�Ǥ��̨��w�諸�����t��k���@�C
#
# �L�׬O�p�ƾڪ��B��(�M�`�׾ǲ߻ݭn�j�ƾ�Big Data�b�I��䴩���P)�F
# �D�u�ʥi��(non-linear separability)�����D�F
# �����Ҧ��ѧO���D�W(��ǡB�Ϲ����ѡK)�ASVM�������������{�C
# 
# �䷧���O�غc�@�ӶW����(hyperplane)�A����Ʀb�Ŷ�������Q�Ϥ��������A�ҥH�S�Q�٬��G��������(binary classifier)�C
# 
# �b�G�����Ŷ����A�W���������N�O�u�@���u�v�F
# �T���Ŷ����A�h�O�u�@�ӥ����v�F
# ���ҥH���@�ӡu�W�v�r�A�O�]����Ʃ������|�u���G���B�T���C
# �b�󰪺����Ŷ����A�ڭ̵L�k�[��o�ӥ������Ϊ�����A��O�N�Ρu�W����(hyperplane)�v�@���ӷ��A�C

#####################################################################################

install.packages("e1071")

# �ϥήM��mlbench�������Glass��²��ܽd�C
# 
# �o�O�@�Ӥ������D�A
# ��Ƥ��O���F���ج������褺���ƾǤ����t�q�A�@��214���[���ȡA10���ܼơG
install.packages("mlbench")
data(Glass, package = "mlbench")
data = Glass
str(data)

#����80%���V�m���(Train)�A20%�����ո��(Test)�G
smp.size = floor(0.8*nrow(data)) 
set.seed(516)                     
train.ind = sample(seq_len(nrow(data)), smp.size)
train = data[train.ind, ] # 80%
str(train)
test = data[-train.ind, ] # 20%
str(test)


#####################################################################################


#�ϥ�svm()�V�mSVM�������ҫ��G
library(e1071)
model = svm(formula = Type ~ .,  # ���ܼ�(�b�o�̬OType)����ƧκA�n�OFactor
            data = train)


summary(model)   # �i�H�ݨ�SVM�w�]���ѼƳ]�w
#
# Call:
#     svm(formula = Type ~ ., data = train)
# 
# 
# Parameters:
#     SVM-Type:  C-classification 
# SVM-Kernel:  radial 
# cost:  1 
# 
# Number of Support Vectors:  149
# 
# ( 14 9 52 7 50 17 )
# 
# 
# Number of Classes:  6 
# 
# Levels: 
#     1 2 3 5 6 7

#####################################################################################

#�w��V�m��ơB���ո�ƶi��w���A�ϥ�predict()�禡�G

# �w��
train.pred = predict(model, train)
test.pred = predict(model, test)

# �V�m��ƪ��V�c�x�}
table(real=train$Type, predict=train.pred)
#
#        predict
# real  1  2  3  5  6  7
# 1    47 10  0  0  0  0
# 2    11 47  0  0  0  0
# 3     9  7  1  0  0  0
# 5     0  0  0 10  0  0
# 6     0  0  0  0  7  0
# 7     1  0  0  0  0 21

# ���ո�ƪ������ǽT�v
confus.matrix = table(real=test$Type, predict=test.pred) #�`�N:���O�V�m��ƪ��V�c�x�}!
#
#        predict
# real  1  2  3  5  6  7
# 1    12  1  0  0  0  0
# 2     4 12  0  0  1  1
# 3     0  0  0  0  0  0
# 5     0  0  0  2  0  1
# 6     0  0  0  0  2  0
# 7     0  0  0  0  0  7

sum(diag(confus.matrix))/sum(confus.matrix)
# 0.8139535


# �b�V�m�δ��ո�ƤW���o��76%���k���ǽT�v�A�ĪG�٤����A�ӥB�ҫ��ݰ_�ӨèS���o��overfitting�����D�C
# �ӥB�A�o�ȶȥu�O�ϥιw�]�Ѽ�(default)�ҫإߪ�SVM�����ҫ��C
# �u�n���o�i�@�B�վ�ѼơA�K�i�H���ҫ������{��Ӥ@�h�ӡC



#####################################################################################

#SVM�b�h������(multi-class)���ޥ�
#
#�u�@�ӤG��������SVM�A���ѨM���������O���h������(multi-class)���D�O�H�v


# (1) One-against-Rest(One-vs-All, OvA, OvR)�G�@��h

# �o�ӵ������Q�k�O�A�N�O�w��C�@�����O�A���O�إߤ@��SVM(�Ψ�L�G��������)�G
#�ݩ����O���˥�����(+1)�A��L���O���˥�����(-1)�A
#�p���@�ӡA�N�ഫ���@�ӤG�����������D�F
# 
# �H��1�`����Ƭ��ҡA��Ƥ����������O(1~6�A��������)�A���ڭ̫K�|�إߤ���SVM�G
# 
# �Ĥ@��SVM�G�ݩ����O1����Ƭ�(+1)�A��L���O��(-1)�A�o��SVM�ΨӰϧO�o���
# 
# �ĤG��SVM�G�ݩ����O2����Ƭ�(+1)�A��L���O��(-1)�A�o��SVM�ΨӰϧO�o���
# 
# �ĤT��SVM�G�ݩ����O3����Ƭ�(+1)�A��L���O��(-1)�A�o��SVM�ΨӰϧO�o���
# 
# �H�������K
# 
# ���y�ܻ��A�w�靈t�����O����ơA�N�|�s�b��t��SVM�C
# 
# �����@���s��ƭn�w���ɡA�|���O��i�ot��SVM�A�o��t�խ�(v1, v2, v3�Kvt)�A
#�A�q���P�O�̤j����(�p�G���O�O+1,-1)�X�{�ĴX�Ӧ�m�A���o����ƫK�O�ݩ󨺤@���C
# 
# �o�˪����k�ܪ�ı�A�ӥB����ɶ��P�O����ä��|���ӤӦh�C
# 
# �����I�O�A�N�u�ѤU���O�v�����P�@�����O(-1)���o�ذ��k�A�ܮe���ɭP(+1,-1)��������Ƶ��Ʈt�Z�ܤj�A�]�N�O���O������(class imbalance)�����D�C




# (2) One-against-One(OvO)�G�@��@
# �o�ӵ������Q�k�A�ܹ������ƾǪ��ƦC�զX�G
#�qT�����O������2�����O�A�@�|���X�زզX�H
# 
# ���׬O�GC(T,2) = T(T-1)/2
# 
# �ҥH�b�o�ӵ������U�A�ڭ̫K�|�q�h�����O(multi classes)����Ƥ��A����Y������O(2 classes)����ơA�V�m�@��SVM(�u��Ϥ��o������O)�A
#�í��Ƴo�˪��ʧ@�A����Ҧ������O�զX�A�����������SVM����C
# 
# �]���A�̫�|�� T(T-1)/2 ��SVM�ҫ��C
# 
# �����@���s��ƭn�w���ɡA�|���O��i�o T(T-1)/2 ��SVM�A�C�@��SVM���|�N�o����Ƥ���Y�@���A
#�N���O�벼�@�ˡA�����O�|�O��+1�A�̫�P�_���@�����O��o�̦h���ơA�Y�i�w���o������ݩ���@�����O�C
# 
# �MOne-against-Rest���P�A�o�ˤ���ä��|�y�����O�����Ū����D�F
# 
# ���۹諸�A�o�ӵ����һݪ��B��ɶ������F�]�Y���h���O����F�ӥB���ɭԷ|�o�ͨ�ӥH�W�����O��o�P���ƪ����p�A�y���P�_�W���x�Z�C



#�b�ϥ�svm()���ɭԡA�̭����w�g���FOne-against-One�C





#####################################################################################

#Support Vector Regression(SVR)
# 
# SVR�O����SVM���������A�A����B�z�s�򪺹w�����D�C
# 
# �be1071�M��̭��A�èS���@�Ө禡�s��svr()�A�ӬO�@�˥�svm()�C
# 
# �t�O�u�b��G
# 
    # ���ܼƪ����A�Ofactor�ɡAsvm()�|�إ�SVM���W�����A�ӳB�z�������D
    # ���ܼƪ����A�Onumeric�Asvm()�|�ରSVR�A�i��s��Ȫ��w���C


data = data.frame(x=1:20,
                  y=c(3,4,8,2,6,10,12,13,15,14,17,18,20,17,21,22,25,30,29,31))

# ��ƪ���l��
plot(data$x, data$y, pch=16, xlab="X", ylab="Y")


########################################################
#���Ԥ@��²�檺�u�ʰj�k�G

model <- lm(y ~ x , data) 

# lm�w��
lm.pred = predict(model, data)

# ��ƪ���l��(���I)
plot(data$x, data$y, pch=16, xlab="X", ylab="Y")
# lm���w����(���T����)
points(lm.pred, pch=2, col="red")
abline(model, col="red")


########################################################

#������SVR�ӫؼҡB�w���G

model <- svm(y ~ x , data) # ���ܼƪ����A�n�Onumeric

# �w��
svr.pred = predict(model, data)

# ��ƪ���l��(���I)
plot(data$x, data$y, pch=16, xlab="X", ylab="Y")
# SVR���w����(�Ťe)
points(svr.pred, pch=4, col="blue")


#########################################################

#����@�U�u�ʰj�k�MSVR�����{�A�P�ɭp��RMSE(root mean square error)�G

# ��ƪ���l��(���I)
plot(data$x, data$y, pch=16, xlab="X", ylab="Y")
# lm���w����(���T����)
points(lm.pred, pch=2, col="red")
# SVR���w����(�Ťe)
points(svr.pred, pch=4, col="blue")

# (lm, SVR) in RMSE
c(sqrt(mean((data$y - lm.pred)^2)),
  sqrt(mean((data$y - svr.pred)^2))
)
## [1] 1.914203 1.795094
#�i�H�o�{��A�b�o�ӨҤl�ASVR��lm���ĪG�٭n�n�@�Ǩ�(1.79 < 1.91)�C


#####################################################################################
# Most Important~
#
#�ѼưQ��:
#
# 
# svm(...
#   type    = �M�wsvm�O�n�Ψ�classification(���O)�B�٬Oregression(�s��)�C
#   scale   = �N��ƥ��W�Ʀ�(������, �зǮt) = (0,1) �����G�C
#   kernel  = �N��ƬM�g��S�x�Ŷ���kernel-fun�A�ΨӳB�z�u�D�u�ʥi���v�����D�C
#     

#   *cost    = �bLagrange formulation�����jC�A
    #�M�w���Q�~�t/��������ơu�h�֡v�g�@�ȡC

    #���ܦ��h�������s��

    # �@�}�l��SVM�A�O�n�M��@�ӯ�������N�u�Ҧ��v��Ƥ�������A�㦳�̤jmargin���W�����A�o�S�Q�٬���hard-margin SVM���C
    
    # ���ѩ�hard-margin SVM�A�l�D�n�N��Ƨ������n�A�]���ܮe����overfitting�����I�C
    
    # ��O1995�~�AVapnik���H���X�F��soft-margin SVM���A��SVM��e�\�@�ǳQ��������Ʀs�b�C
    
    # �bsoft-margin SVM���l�����(loss function)���A�o�ӤjC���s�b�A�N�O�e�����C
    
    #�ǥ�C�A�ڭ̯൹�����ǳQ����������g�@�ȡA����support vectors(�ΨӨM�w�W���������Ǹ���I)���v�T�O
    
    #���y�ܻ��G
        # C�V�j�A�N���e���V�p�A�V��support vectors�A�V����hard-margin SVM�������A�o�e��overfitting
        
        # C�V�p�A�N���e���V�j�A�V�hsupport vectors�A�i�H�l�D��j��margin�A�e��underfitting




#   *epsilon = margin of tolerance�C�V�j�A���ܦb�e�Խd�򤺪��~�t/��������ơA���|�Q�g�@�F�Ϥ��A�V����0�A�C�@�ӻ~�t/��������Ƴ��|�Q�g�@�C
    
    # �o�ӰѼƥD�n�v�T���|�OSVR�A�ӫDSVM�C�]���bSVR���l����Ƥ��A�ϥΪ��Oepsilon intensive hinge loss�C
    # 
    # Epsilon(�`)�������O�����@��margin of tolerance�A�гy�@�ӡu������v���Pı�C
    # 
    # �b�u������v��������I�|�Q�����A���̪��ݮt(error)�@�I���U�]�S���A���y�ܻ��G���̹�V�mSVR�@�I���U�]�S���C
    #
    #�]���ڭ̥i�H�o�˻��G
        # Epsilon�V�j�A�N���e�԰϶��V�j�A�V�h��Ʒ|�Q�����A�y���ҫ����ǽT�׶V�C�Asupport vectors���ƶq���
          #(�O�o�A�ҿת�support vectors�O����across margin������I�A���̪��ݮt�|�Q�ǤJ�Ҷq�A�ΨӨM�w�̫᪺margin)�C
        
        # Epsilon�V�C(��0+)�A�Ҧ�����ƴݮt(error)���|�Q�Ҽ{�A�o�]�e���y��overfitting�C




#    *gamma   = �bkernel-fun�̭����Ѽ�(linear-fun���~)�C
    # Gamma���N�q������H�����A���ϥ�kernel function�N��l��ƬM�g��S�x�Ŷ�(feature space)�ɡA
    #�����t�a�M�w�F��Ʀb�S�x�Ŷ������G���p�C
    # 
    # �H�X���[�I�ӬݡA��gamma�W�[�ɡA�|��Radial Basis Function(RBF)�̭����m�ܤp�A
    # �ӣm�ܤp���������G�|�S���S�G�A���u�b���񪺸���I���ҧ@�ΡC(�Ѧ�)
    # 
    # �b�w�q���AGamma = How far the influence of a single training example reaches�A�N��O(�Ѧ�)�G
        # 
        # gamma�j�A����I���v�T�O�d������A��W�����ӻ��A���I���v�T�O�v�����j�A�e���İǥX���X���I���W�����A�]�e���y��overfitting�C
        # 
        # gamma�p�A����I���v�T�O�d�������A��W�����ӻ��A����������I�]���v�T�O�A�]����İǥX���ơB������u���W�����C
#     ...
# )


#####################################################################################

#�Ѽƽվ�(Tune Parameters)
# 
# 
# �b�հѼƪ����q�A�ҨϥΪ���k�Q�٬�grid search�A
#�����O�w��C�@�ذѼƲզX�A���|�V�m�@�ӹ������ҫ��A�̫��[��ҫ������{�A�D�X���{�̨Ϊ��ҫ��C
# 
# �b�V�m���L�{���AR�|�۰ʤޤJcross validation����k�A�T�O�ҫ����i�a��(Robustness)�A��tune�X�Ӫ��ѼƬO�i�H�ĥΪ��C
# 
# 


#####################################################################################
# Tune parameters in SVM(soft-margin)
# �bSVM���A�@��|�h�ժ��ѼƬO(cost, gamma)�G

# data
require("mlbench")
data(Glass, package="mlbench")
data = Glass

# tune cost and gamma in SVM(soft-margin)
tune.model = tune(svm,
                  Type~.,
                  data=data,
                  kernel="radial", # RBF kernel function
                  range=list(cost=10^(-1:2), gamma=c(.5,1,2))# �հѼƪ��̥D�n�@��
)


summary(tune.model)
# 
# Parameter tuning of ��svm��:
#     
#     - sampling method: 10-fold cross validation 
# 
# - best parameters:
# cost gamma
# 10   0.5
# 
# - best performance: 0.3181818 
# 
# - Detailed performance results:
#     cost gamma     error dispersion
# 1    0.1   0.5 0.5807359 0.11632977
# 2    1.0   0.5 0.3456710 0.08564338
# 3   10.0   0.5 0.3181818 0.10774303
# 4  100.0   0.5 0.3746753 0.11663545
# 5    0.1   1.0 0.5852814 0.09453697
# 6    1.0   1.0 0.3599567 0.09478361
# 7   10.0   1.0 0.3694805 0.12618654
# 8  100.0   1.0 0.4021645 0.13339298
# 9    0.1   2.0 0.5803030 0.09526242
# 10   1.0   2.0 0.3883117 0.10576915
# 11  10.0   2.0 0.3701299 0.12517570
# 12 100.0   2.0 0.3699134 0.12305110



# �b�V�m���L�{���A�ڭ̰V�m���O�@��ҫ��A
# �]�tcost=10^-1, 10^0, 10^1, 10^2�Agamma=0.5, 1, 2�A�o��ذѼƪ��ƦC�զX�A
# ���y�ܻ��A�|�� 4x3=12 ��SVM�ҫ��C
# 
# �̭����ȬOclassification error


plot(tune.model)
# �i�@�B�A�i�H�ھڳo�i�ϡA�Y�pcost�Mgamma���d��A�A�h�htune��h���ѼƲզX�C
# 
# �̫�A�n�D�X���{�̨Ϊ��ҫ��A�i�H�����qtune()�^�Ǫ����G�����X($best.model)�G

# Best model in set of tuning models
tune.model$best.model
#
# Call:
#     best.tune(method = svm, train.x = Type ~ ., data = data, ranges = list(cost = 10^(-1:2), 
#                                                                            gamma = c(0.5, 1, 2)), kernel = "radial")
# 
# 
# Parameters:
#   SVM-Type:  C-classification 
# SVM-Kernel:  radial 
#       cost:  10 
# 
# Number of Support Vectors:  162


#####################################################################################

#Tune parameters in SVR
#�bSVR���A�@��|�h�ժ��ѼƬO(cost, epsilon)�G
# data
data = data.frame(x=1:20,
                  y=c(3,4,8,2,6,10,12,13,15,14,17,18,20,17,21,22,25,30,29,31))

# tune cost and epsilon in SVR
tune.model = tune(svm,
                  y~x,
                  data=data,
                  range=list(cost=2^(2:9), epsilon = seq(0,1,0.1))# �հѼƪ��̥D�n�@��
)

# �b�V�m���L�{���A�ڭ̰V�m���O�@��ҫ��A�]�tcost=2^2., 2^3. �K 2^9.�Aepsilon=0, 0.1, 0.2�K1�A�o��ذѼƪ��ƦC�զX�A
#���y�ܻ��A�|��8x11=88��SVR�ҫ��C
# 
# �̭����ȬOmean squared error

tune.model
#
# Parameter tuning of ��svm��:
#     
#     - sampling method: 10-fold cross validation 
# 
# - best parameters:
# cost epsilon
# 4     0.1
# 
# - best performance: 4.267714 


plot(tune.model)

# Best model in set of tuning models
tune.model$best.model
# Call:
# best.tune(method = svm, train.x = y ~ x, data = data, ranges = list(cost = 2^(2:9), 
#                                                                     epsilon = seq(0, 1, 0.1)))
# 
# 
# Parameters:
#   SVM-Type:  eps-regression 
# SVM-Kernel:  radial 
#       cost:  4 
#      gamma:  1 
#    epsilon:  0.1 
# 
# 
# Number of Support Vectors:  13

#####################################################################################

#����:
#
# SVM�O��Ƭ�Ǥ��̭��n���t��k���@�A���P�ɨ㦳�����ǲߩM�έp�z�ת����B�A�b�����ιw�������D�W�����{�o�����C
# 
# ���n�R���o��SVM/SVR�����B�A�ݭn�N�䤤���\�h�Ӹ`(�Ѽ�)���D�o�Q���M���A�P�ɨ㦳���ƪ��ӾU�פ~��C
# 
# �be1071�M��̪�svm()�A�t��k�K�O soft-margin SVM
