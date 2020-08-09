
# ²��

    # ���

# Bagging
    # R Code for Bagging Implement
    # Random Forest

# Boosting
    # Gradient Boosting Machine(XGboost)

# Stacking
    # R Code for Stacking Implement
        # �Ĥ@���q(Stacking)
        # �ĤG���q(Blending)

##############################################################################
install.packages("lasso2")

data(Prostate, package="lasso2")
str(Prostate)

data <- Prostate


# �����ưϤ��� train=0.8, test=0.2 
set.seed(22)
train.index <- sample(x=1:nrow(data), size=ceiling(0.8*nrow(data) ))

train = data[train.index, ]
test = data[-train.index, ]


##############################################################################


# Bootstrap aggregating (Bagging)
#
#�q�r���W�ӬݡA�N�O�N��Ƹ˦��@�ӳU�l�@�ӳU�l(Bag)�A�M��N�C�ӳU�l�����G���X�b�@�_�C
# 
# �t��k�W�A�O�N�˥����Ʃ��(�����^)�A���ͦh�Ӥl��ƶ�(Subsets)��A�̧ǫإߦh�Ӽҫ��A�̫�A�N�Ҧ��ҫ������G�J��b�@�_�C
#
# �b�ҫ� Bias �� Variance ��ĳ�D�W�ABagging ����k���U�󭰧C variance�C
# 
# ���C�Ӥl����Ʀb�ؼҪ��ɭԡA�C�Ӽҫ��Y�W�ۮ��X�ӬݡA�|�o�{���O�@�ӡu�j�ҫ��v(���������ҫ�)�A�㦳�C bias �� variance ���S�ʡF
# �Ӧp���A�ڭ̧⤣�P�� variance ���ҫ����X�b�@�_��A�]���O����(�벼)�������A�䵲�G�N�|�ͪ����骺�������{�A�]�� variance �N���|�Ӥj�C
# 






#Bagging ���@�}�l�A�O�n�����ư����Ʃ�ˡA
#�]�����N Train �����T�Ӥl��ƶ�(n=40)�G

# Subset-1
set.seed(1)
ind_1 = sample(1:nrow(train), 40)
subset_1 = train[ind_1, ]

# Subset-1
set.seed(2)
ind_2 = sample(1:nrow(train), 40)
subset_2 = train[ind_2, ]

# Subset-3
set.seed(3)
ind_3 = sample(1:nrow(train), 40)
subset_3 = train[ind_3, ]



#��subset_1�Asubset_2�Asubset_3���O�إ߽u�ʰj�k�ҫ��A
#�A�N Test ���w�����G�����_�ӡG

# Model-1 : linear regression
model_1 = lm(lpsa~., subset_1)
y1 = predict(model_1, test)

# Model-2 : linear regression
model_2 = lm(lpsa~., subset_2)
y2 = predict(model_2, test)

# Model-3 : linear regression
model_3 = lm(lpsa~., subset_3)
y3 = predict(model_3, test)

# Average Prediction Results
ave_y = (y1+y2+y3)/3


#�ѩ�lpsa�O�s��ȡA�]���ϥ� MSE �Ӥ���쥻�ҫ��P Bagging �᪺���{�n�a�C

# MSE Comparision between three models and the bagging model
c(mean((y1 - test$lpsa)^2),   # linear regression of subset_1
  mean((y2 - test$lpsa)^2),   # linear regression of subset_2
  mean((y3 - test$lpsa)^2),   # linear regression of subset_3
  mean((ave_y - test$lpsa)^2))  # bagging model

#[1] 0.6269814 0.5254751 0.5822511 0.5169099


##############################################################################

# Random Forest
# 
# �ҿת��H���˪L�A�N�O�B�� Bagging + CART�M����A
#�]�N�O��Model-1 ~ Model-n�������O�ΨM����ӫؼҡA�ӳo��h�ʪ���զX�b�@�_�A�ҥH�~�٬��u�˪L�v�C
# 
# �n�`�N���O�A�H���˪L�b��˹L�{���A���u�O�� Row �i���ˡA�P�ɤ]�|�� Column ��ˡA
#�]�����ͪ��l����ơA���O�����C��˫᪺���G�C
#����A�w��o�Ǥl����ơA�U�۰V�m�@�ʨM����A�Φ��H���˪L�C
# 
# �ƹ�W�A�b�����Ƥ����@�u��(collinearity)�����O������(Class Imbalance Problem)�A
#�ӳo�ǰ��D�|��w�����G�y�����}�v�T�ɡA�H���˪L�O�����C�����t��k�C
#
#(�Y�O���Q��u�ܼƸ����ʡv���v�T�A�h�ݭn�� Lasso �� Stepwise �ӸѨM)�A
#
#�䷧�����Ӥ����z�ѡG
    #�� Row ��ˮɡA�i�H�����ѨM���O�����ŨӼv�T�w�������D�F
    #�� Column ��ˮɡA�i�H�����ѨM�@�u�ʨӼv�T�w�������D

require(randomForest)

rf_model = randomForest(lpsa~.,
                        data=train,
                        ntree=150  # �M���𪺼ƶq
)
# #
# Call:
#     randomForest(formula = lpsa ~ ., data = train, ntree = 150) 
# Type of random forest: regression
# Number of trees: 150
# No. of variables tried at each split: 2
# 
# Mean of squared residuals: 0.674582
# % Var explained: 48.74




# �w��
rf_y = predict(rf_model, test)
mean((rf_y - test$lpsa)^2) # MSE
#[1] 0.6547685




# Observe that what is the best number of trees
plot(rf_model) 
#70�ʾ�N���F






# �b�M�w�nntree���ƶq��A�t�@�ӰѼ�mtry���]�ݭn�h Tune�A
# �o�ӰѼƥN���C����ˮɻݭn��u�h�֭��ܼơv���N��C
#  
# �ڭ̥i�H�ϥ�tuneRF()�� tune mtry���ȡA
# �îھڤU�������G�P�ϡA�o���C����ˮɡu��2���ܼơv�|�O����n����ܡG

tuneRF(train[,-9], train[,9])
#
# mtry = 2  OOB error = 0.6186665 
# Searching left ...
# mtry = 1 	OOB error = 0.7621107 
# -0.2318603 0.05 
# Searching right ...
# mtry = 4 	OOB error = 0.6615442 
# -0.06930667 0.05 
# mtry  OOBError
# 1    1 0.7621107
# 2    2 0.6186665
# 4    4 0.6615442




#�ھ���o�Ѽƭ��s�]�@���ҫ�
rf_model = randomForest(lpsa~.,
                        data = train,
                        ntree = 50, # �M���𪺼ƶq
                        mtry = 2    #�C����ˮɻݭn�⪺�ܼƼƶq
)

# �w��
rf_y = predict(rf_model, test)
mean((rf_y - test$lpsa)^2) # MSE
#[1] 0.6341545




#�ܼƬD��
#
# Variable Importance of Random Forest
rf_model$importance
#
# IncNodePurity
# lcavol      31.993850
# lweight     10.468467
# age          7.444329
# lbph         4.398892
# svi          8.350435
# lcp         14.816933
# gleason      6.295688
# pgg45       11.632984

varImpPlot(rf_model)





##############################################################################

#  Boosting
# 
# �� Bagging �ϥΦh�ӡu�j�ҫ��v���P�A Boosting �|�j�ըϥΤW�ݭn�h�ӡu�z�ҫ��v�~�i�H�C
# 
# ���� M1 M2 M3 �p�G�ӽ���(�ӱj)�A�����������N�|���ۤz�Z�A�v�T�̫�w��/�������G�F
#�ߦ��������O�u�z�ҫ��v�A�~��n�n�M�`�b�ۤv�������w��/�����A�M��A�⩼�������G���X�@�_�A�o�N�O Boosting �������C
#(���M�H�p��Ĳv���Ҷq�A�o�˰��]�����)
# 
# �b�t��k���A�n�q��Ƥ��� M1 M2 M3�K���ҫ��O�����Ǫ��A������ Bagging�������@�ˡG
# 
# �b Bagging �ɡA�ڭ̬O�N��ư���ˡA�]����o�\�h�l����ơA�æU�O�ؼҫ�A�⵲�G����/�벼�C
# 
# �b Boosting ��:
    #�@�}�l���ؤ@��²�檺�ҫ� M1 �A���ɷ|���w�����~����ơA
    #��o�Ǹ�ƪ��v���[�j�A�� M2 �ҫ��A
    #�M��S�|���w��������ơA�A���ƪ��v���[�j�A�� M3 �ҫ��K
# 
# �b�ҫ� Bias �� Variance ��ĳ�D�W�ABoosting ����k���U�󭰧C bias�C
# 
# �ѩ�ϥΤW�O���u�z�ҫ��v�ӥΡA�o�Ǯz�ҫ����O�� bias �� �C variance ���A
# �åB�C�����N���ɭԡA���|�����e���ҫ��W�i���u��
# (�α�פU���k�A�M�w�o���ҫ��ئb���̯�Ϸl����ƤU���̦h)�C
# �J�M�O���C�l����ơA���ܹL�{���|�V�ӶV�G���ڭȡA
# ���y�ܻ��A�N�O�v�����C bias ���N��C
# 

##############################################################################

# Gradient Boosting Machine(XGboost)

# �ҿת� GBM ��O�@�ط����A�O�N��פU���k(Gradient Descending)�� Boosting �M��`�X�b�@�_���t��k�A�ӫ᭱�� Machine �����S�w���ҫ��A�u�n��α�פU���k��M��V���ҫ����i�H�C
# 
# �ثe�����W�A�p�G�ϥ� gbm ���M��A�򥻤W���O Tree-based ���D�A�]�N�O�N�ƦʭӮz�M����(CART)�A���פU���k�M Boosting ���X�b�@�_�C
# 
# �� XGboost �S���ǳ\���P�A�O���Ӫ� Gradient Boosting Decision Tree(GBDT)����}����



##############################################################################
# 1. �N��Ʈ榡(Data.frame)�A��`xgb.DMatrix()`�ഫ�� xgboost ���}���x�}
install.packages("xgboost")

require(xgboost)

dtrain = xgb.DMatrix(data = as.matrix(train[,1:8]),
                     label = train$lpsa)

dtest = xgb.DMatrix(data = as.matrix(test[,1:8]),
                    label = test$lpsa)
#
# dtrain
# xgb.DMatrix  dim: 78 x 8  info: label  colnames: yes
# 
#dtest
# xgb.DMatrix  dim: 19 x 8  info: label  colnames: yes



##############################################################################
# 2. �]�wxgb.params�A�]�N�O xgboost �̭����Ѽ�
# 
xgb.params = list(
#     #col����ˤ�ҡA�V�����ܨC�ʾ�ϥΪ�col�V�h�A�|�W�[�C�ʤp�𪺽�����
     colsample_bytree = 0.5,

#     # row����ˤ�ҡA�V�����ܨC�ʾ�ϥΪ�col�V�h�A�|�W�[�C�ʤp�𪺽�����
     subsample = 0.5, 
     booster = "gbtree",

#     # �𪺳̤j�`�סA�V�����ܼҫ��i�H���o�V�`�A�ҫ������׶V��
     max_depth = 2,    

#     # boosting�|�W�[�Q����������v���A�Ӧ��ѼƬO���v�����|�W�[������֡A�]���V�j�|���ҫ��U�O�u
     eta = 0.03,
#     # �Υ�'mae'�]�i�H

     eval_metric = "rmse",                      
     objective = "reg:linear",

#     # �V�j�A�ҫ��|�V�O�u�A�۹諸�ҫ������פ���C
     gamma = 0)               




##############################################################################
# 3. �ϥ�xgb.cv()�Atune �X�̨Ϊ��M����ƶq
#
# �L�{���A�{���|�ھ� Train �M Validation ���������{�A�۰ʧP�_�ҫ��O�_�� overfitting�A
# �̫��X���n�� nrounds�A�|�O�@�ӳ̤� overfitting ���ҫ��C
# 
# �n�`�N���O�A�o�ӳ̤� overfitting ���ҫ��A�O�إߦb�@�}�l���򥻰ѼƳ]�w���U�A�ҥH���@�w�O�̦n���C
# �p�G�o�ͬY�Ǳ��p�A�N�o�^�h�� xgb.params�A�~�����|��o��n���ҫ��C

cv.model = xgb.cv(
    params = xgb.params, 
    data = dtrain,
     nfold = 5,    
    # 5-fold cv
    # ��nround=1�A���ܲ{�b�V�m�u�u���@�ʾ�v���ҫ��C
    # ��Ʒ|����5����(�]���O��5-fold cv)�C
    # �o�ɡA��Ĥ@��������Ʒ��@ Validation�A�ѤU���@Train�A�V�m�@���ҫ��A�o��Train �� Validation ���w�����{�F
    # �H�W���k���� 5 ���A�A��������� stand deviation�A�N�|�O nround=1 �ɪ��ҫ��������{�F
    # nrounds=2 �ɡA���ƤW�����ʧ@�C�H������
    
    nrounds=200,   # ����1-100�A�U�Ӿ��`�ƤU���ҫ�
    # �p�G��nrounds < 30 �ɡA�N�w�g��overfitting���p�o�͡A�����ܤ����~��tune�U�h�F�A�i�H��������                
    early_stopping_rounds = 30, 
    print_every_n = 20 # �C20�ӳ��~��ܤ@�����G�A
) 
#
# [1]	train-rmse:2.170414+0.073478	test-rmse:2.169813+0.289608 
# Multiple eval metrics are present. Will use test_rmse for early stopping.
# Will train until test_rmse hasn't improved in 30 rounds.
# 
# [21]	train-rmse:1.397099+0.035320	test-rmse:1.428450+0.234440 
# [41]	train-rmse:0.982208+0.019527	test-rmse:1.038109+0.184029 
# [61]	train-rmse:0.761991+0.008893	test-rmse:0.862965+0.175182 
# [81]	train-rmse:0.640592+0.016733	test-rmse:0.787176+0.154625 
# [101]	train-rmse:0.570471+0.025216	test-rmse:0.765982+0.142871 
# [121]	train-rmse:0.522613+0.024496	test-rmse:0.753904+0.123841 
# [141]	train-rmse:0.488789+0.023782	test-rmse:0.751154+0.114101 
# [161]	train-rmse:0.461967+0.024659	test-rmse:0.752928+0.104080 
# [181]	train-rmse:0.438543+0.024053	test-rmse:0.756316+0.098537 
# Stopping. Best iteration:
# [153]	train-rmse:0.471549+0.023408	test-rmse:0.748672+0.108083


#�e���[�� CV �L�{��Train �� Validation ��ƪ����{
#(����GTrain�A�Ŧ�GValidation)�G

tmp = cv.model$evaluation_log

plot(x=1:nrow(tmp), y= tmp$train_rmse_mean, 
     col='red', 
     xlab="nround", 
     ylab="rmse", 
     main="Avg.Performance in CV") 

points(x=1:nrow(tmp), y= tmp$test_rmse_mean, col='blue') 

legend("topright", 
       pch=1, 
       col = c("red", "blue"), 
       legend = c("Train", "Validation") )
# 
# �@��ӻ��ATrain �����{�|�� Validation �٭n�n�A�o�ɦ���ر��p�n��ҡG
# 
    # �p�G Train �� Validation �۪�A���ܼҫ�����٥i�H�V�m�o��n(�����)�A
    #�ǥѴ��� Train �����{�A�[�� Validation �O�_�����|���ɡA
    #�]���i�H�եH�U�ѼơA�H�����ҫ������ת������i��G
        #
        # max_depth �հ� 1 ��� (�̫�ĳ�ճo��)
        # 
        # colsample_bytree�Bsubsample�հ���� (�ճo�Ӥ]����)
        # 
        # eta�էC (���o�H�~�ճo��)
        # 
        # gamma �էC (���o�H�~�ճo��)
 
    # �p�G Train �� Validation �n�Ӧh�A�N���ܦ� ovrfitting�����D�o�͡A
    #�o�ɭԤW�����ѼƴN�n�ϹL�ӽաA�H���C�ҫ������ת������Ӷi��C

# ��o best nround
best.nrounds = cv.model$best_iteration 
best.nrounds
# 153


##############################################################################
# 4. ��xgb.train()�إ߼ҫ�
xgb.model = xgb.train(paras = xgb.params, 
                      data = dtrain,
                      nrounds = best.nrounds) 

# �p�G�n�e�X xgb �����Ҧ��M����A�i�H�ΥH�U�禡(���]���|�ܦh�A�o�̴N���e�F)
# xgb.plot.tree(model = xgb.model) 

# �w��
xgb_y = predict(xgb.model, dtest)
mean((xgb_y - test$lpsa)^2) # MSE
# 0.7854097


##############################################################################

#  Stacking
# 
# �u�b�V�m�h�Ӽҫ��B�o��h�ӹw����/�������G��A�P��ϥΧ벼�k(hard voting)�Υ����k(average)�N�o�ǵ��G��X(ensemble)�_�ӡA
#���󤣦h�V�m�@�Ӽҫ��Ӱ��o�˪���X�O�H�v
# 
# �|�ҡG
# 
# �u���Ѥw�g�V�m�n�T�Ӿ����ǲߪ��ҫ��A���O�O linear regression, support vector regression �� CART decision tree�C
# �����@���s��ƻݭn�w���ɡA�|�U�۱o��T�ӹw����(y1, y2, y3)�A
# �M�ᱵ�U�ӧ@���̲׼ҫ�(�S�� meta-model, blender, meta learner)����J�ȡA
# �o��̲׹w�����G(y.final)�v
#
#�ǲΤW�����k�A�ڭ̪�ı�W�|��(y1, y2, y3)�����G�������ӥ���(�w�����D)�Χ벼�k(�������D)�A�o��̫᪺���G�C
# 
# ���L Stacking �ĥΥt�@�Ӽҫ�(blender)�Ө��N�o�˪������C
#���y�ܻ��A�]�N�O�u�⥻�Ӫ��w�����G�A�i�@�B���w���v���Pı�C
# 
# �]���AStacking ���t��k�i�H������Ӷ��q�A���Ӥ����z�ѡG
    # 
    # Stacking�G���V�m�h�Ӫ�l�ҫ��A��w�����G�s�� Meta-Data�A�@���̲׼ҫ�(Meta-Model; Blender)������J�C
    # 
    # Blending�G�̲׼ҫ��|���o Meta-Data �A��X�X�̫ᵲ�G(Predicted Results)�C

#############################################################################################################################################################################################################################################

#R Code for Stacking Implementing


#�Ĥ@���q(Stacking)


#�@�}�l�A�ڭ̧�V�m��� Train �����T��(3-folds)�G
# 3-folds
n = 3
n.folds = rep(1:n, each=nrow(train)/n)

# [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
# [44] 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
train.folds = split(train, n.folds)

# $`1`
# lcavol  lweight age       lbph svi        lcp gleason pgg45     lpsa
# 9  -0.7765288 3.539509  47 -1.3862944   0 -1.3862944       6     0 1.047319
# 88  1.7316555 3.369018  62 -1.3862944   1  0.3001046       7    30 3.712352
# 74  1.8389611 3.236716  60  0.4382549   1  1.1786550       9    90 3.075005
# 94  3.8210036 3.896909  44 -1.3862944   1  2.1690537       7    40 4.684443
# 44  1.7715568 3.896909  61 -1.3862944   0  0.8109302       7     6 2.374906
# 59  0.5423243 4.178226  70  0.4382549   0 -1.3862944       7    20 2.806386
# 81  1.4678743 3.070376  66  0.5596158   0  0.2231436       7    40 3.516013
# 67  2.0228712 3.878466  68  1.7833912   0  1.3217558       7    70 2.920470
# 48  1.1631508 4.035125  68  1.7137979   0 -0.4307829       7    40 2.568788
# 16  1.5411591 3.061052  66 -1.3862944   0 -1.3862944       6     0 1.446919
# 58  0.4637340 3.764682  49  1.4231083   0 -1.3862944       6     0 2.794228
# 72  1.1600209 3.341093  77  1.7491999   0 -1.3862944       7    25 3.037354
# 62  1.9974177 3.719651  63  1.6193882   1  1.9095425       7    40 2.853593
# 31  0.2851789 4.090169  65  1.9629077   0 -0.7985077       6     0 1.924249
# 65  2.0731719 3.623007  64 -1.3862944   0 -1.3862944       6     0 2.882004
# 49  1.7457155 3.498022  43 -1.3862944   0 -1.3862944       6     0 2.591516
# 21  1.1474025 3.419365  59 -1.3862944   0 -1.3862944       6     0 1.638997
# 68  2.1983351 4.050915  72  2.3075726   0 -0.4307829       7    10 2.962692
# 33  1.2753628 3.037354  71  1.2669476   0 -1.3862944       6     0 2.008214
# 32  0.1823216 6.107580  65  1.7047481   0 -1.3862944       6     0 2.008214
# 56  1.2669476 4.280132  66  2.1222615   0 -1.3862944       7    15 2.718001
# 51  1.0919233 3.993603  68 -1.3862944   0 -1.3862944       7    50 2.656757
# 77  2.0108950 4.433789  72  2.1222615   0  0.5007753       7    60 3.392829
# 38  0.4574248 2.374906  64 -1.3862944   0 -1.3862944       7    15 2.191654
# 97  3.4719665 3.974998  68  0.4382549   1  2.9041651       7    20 5.582932
# 23 -0.5447272 3.375880  59 -0.7985077   0 -1.3862944       6     0 1.695616
# 
# $`2`
# lcavol  lweight age        lbph svi         lcp gleason pgg45       lpsa
# 25  0.385262401 3.667400  69  1.59938758   0 -1.38629436       6     0  1.7316555
# 11  0.254642218 3.604138  65 -1.38629436   0 -1.38629436       6     0  1.2669476
# 84  2.677590994 3.838376  65  1.11514159   0  1.74919985       9    70  3.5709402
# 79  2.648300197 3.582129  69 -1.38629436   1  2.58399755       7    70  3.4578927
# 1  -0.579818495 2.769459  50 -1.38629436   0 -1.38629436       6     0 -0.4307829
# 13  1.613429934 3.022861  63 -1.38629436   0 -0.59783700       7    30  1.2669476
# 95  2.907447359 3.396185  52 -1.38629436   1  2.46385324       7    10  5.1431245
# 63  2.775708850 3.524889  72 -1.38629436   0  1.55814462       9    95  2.8535925
# 34  0.009950331 3.267666  54 -1.38629436   0 -1.38629436       6     0  2.0215476
# 15  1.205970807 3.442019  57 -1.38629436   0 -0.43078292       7     5  1.3987169
# 29  1.040276712 3.128951  67  0.22314355   0  0.04879016       7    80  1.8484548
# 50  1.220829921 3.568123  70  1.37371558   0 -0.79850770       6     0  2.5915164
# 55  3.153590358 3.516013  59 -1.38629436   0 -1.38629436       7     5  2.7047113
# 40  0.797507196 3.013081  56  0.93609336   0 -0.16251893       7     5  2.2772673
# 76  3.141130476 3.263849  68 -0.05129329   1  2.42036813       7    50  3.3375474
# 53  0.512823626 3.633631  64  1.49290410   0  0.04879016       7    70  2.6844403
# 20  0.182321557 3.825375  70  1.65822808   0 -1.38629436       6     0  1.5993876
# 70  1.193922468 4.780383  72  2.32630162   0 -0.79850770       7     5  2.9729753
# 19 -0.562118918 3.267666  41 -1.38629436   0 -1.38629436       6     0  1.5581446
# 42  1.442201993 3.682610  68 -1.38629436   0 -1.38629436       7    10  2.3075726
# 39  2.660958594 4.085136  68  1.37371558   1  1.83258146       7    35  2.2137539
# 54  2.127040520 4.121473  68  1.76644166   0  1.44691898       7    40  2.6912431
# 66  1.458615023 3.836221  61  1.32175584   0 -0.43078292       7    20  2.8875901
# 3  -0.510825624 2.691243  74 -1.38629436   0 -1.38629436       7    20 -0.1625189
# 96  2.882563575 3.773910  68  1.55814462   1  1.55814462       7    80  5.4775090
# 24  1.781709133 3.451574  63  0.43825493   0  1.17865500       7    60  1.7137979
# 
# $`3`
# lcavol  lweight age       lbph svi        lcp gleason pgg45       lpsa
# 73  1.21491274 3.825375  69 -1.3862944   1  0.2231436       7    20  3.0563569
# 30  2.40964417 3.375880  65 -1.3862944   0  1.6193882       6     0  1.8946169
# 43  0.58221562 3.865979  62  1.7137979   0 -0.4307829       6     0  2.3272777
# 35 -0.01005034 3.216874  63 -1.3862944   0 -0.7985077       6     0  2.0476928
# 80  2.77944020 3.823192  63 -1.3862944   0  0.3715636       7    50  3.5130369
# 91  3.24649099 4.101817  68 -1.3862944   0 -1.3862944       6     0  4.0298060
# 12 -1.34707365 3.598681  63  1.2669476   0 -1.3862944       6     0  1.2669476
# 27  0.51282363 3.719651  65 -1.3862944   0 -0.7985077       7    70  1.8000583
# 14  1.47704872 2.998229  67 -1.3862944   0 -1.3862944       7     5  1.3480731
# 71  1.86408013 3.593194  60 -1.3862944   1  1.3217558       7    60  3.0130809
# 82  2.51365606 3.473518  57  0.4382549   0  2.3272777       7    60  3.5307626
# 45  1.48613970 3.409496  66  1.7491999   0 -0.4307829       7    20  2.5217206
# 2  -0.99425227 3.319626  58 -1.3862944   0 -1.3862944       6     0 -0.1625189
# 22  2.05923883 3.501043  60  1.4747630   0  1.3480731       7    20  1.6582281
# 83  2.61300665 3.888754  77 -0.5276327   1  0.5596158       7    30  3.5652984
# 28 -0.40047757 3.865979  67  1.8164521   0 -1.3862944       7    20  1.8164521
# 47  2.72785283 3.995445  79  1.8794650   1  2.6567569       9   100  2.5687881
# 6  -1.04982212 3.228826  50 -1.3862944   0 -1.3862944       6     0  0.7654678
# 64  2.03470565 3.917011  66  2.0082140   1  2.1102132       7    60  2.8820035
# 46  1.66392610 3.392829  61  0.6151856   0 -1.3862944       7    15  2.5533438
# 8   0.69314718 3.539509  58  1.5368672   0 -1.3862944       6     0  0.8544153
# 7   0.73716407 3.473518  64  0.6151856   0 -1.3862944       6     0  0.7654678
# 36  1.30833282 4.119850  64  2.1713368   0 -1.3862944       7     5  2.0856721
# 4  -1.20397280 3.282789  58 -1.3862944   0 -1.3862944       6     0 -0.1625189
# 86  3.30284926 3.518980  64 -1.3862944   1  2.3272777       7    60  3.6309855
# 41  0.62057649 3.141995  60 -1.3862944   0 -1.3862944       9    80  2.2975726






#######################################################################################
#�� linear regression ���ҡA���g�@�� stacking �[�c�A�åB�x�smeta-x �� meta-y���ȡG

meta.x = vector()
meta.y = list()

# 1st fold for validation
stacking.train = rbind(train.folds[[2]], train.folds[[3]])  #��1,2�����V�m��
stacking.valid = train.folds[[1]]                        #��3�������Ҳ�
stacking.test = test                                  #Test Data

#��1�Ӽҫ��B�z
#��1����e����
model_1 = lm(lpsa~., stacking.train)
tmp.meta.x = predict(model_1, stacking.valid)
tmp.meta.y = predict(model_1, stacking.test)

meta.x = c(meta.x, tmp.meta.x) #�m�J�̪�Ыت��ŦV�qmeta.x
meta.y[[1]] = tmp.meta.y       #�m�J�̪�Ыت��ŦV�qmeta.y

# 2nd fold for validation
stacking.train = rbind(train.folds[[1]], train.folds[[3]])
stacking.valid = train.folds[[2]]
stacking.test = test

#��1�Ӽҫ��B�z
#��2����e����
model_1 = lm(lpsa~., stacking.train)
tmp.meta.x = predict(model_1, stacking.valid)
tmp.meta.y = predict(model_1, stacking.test)

meta.x = c(meta.x, tmp.meta.x)
meta.y[[2]] = tmp.meta.y

# 3rd fold for validation
stacking.train = rbind(train.folds[[1]], train.folds[[2]])
stacking.valid = train.folds[[3]]
stacking.test = test

#��1�Ӽҫ��B�z
#��3����e����
model_1 = lm(lpsa~., stacking.train)
tmp.meta.x = predict(model_1, stacking.valid)
tmp.meta.y = predict(model_1, stacking.test)

meta.x = c(meta.x, tmp.meta.x)
meta.y[[3]] = tmp.meta.y

# �ҥH�Ĥ@�ӽu�ʼҫ��]���T������A�N�|�o��@��meta.x��meta.y�A
# �A�򥻨Ӫ���ڭ�(train$lpsa, test$lpsa)���X�A
# �����Ĥ@�Ӽҫ���X�� meta.train.1�� meta.test.1�G

# Average Meta.X of Test
mean.meta.y = (meta.y[[1]] + meta.y[[2]] + meta.y[[3]]) / 3

meta.train.1 = data.frame(`meta.x` = meta.x, 
                          y=train$lpsa)

meta.test.1 = data.frame(`mete.y` = mean.meta.y, 
                         y = test$lpsa)

#######################################################################################
#���U�ӡA�ĤG�ҫ���support vector regression�A�]�O�@�˪��y�{�G

require(e1071)
meta.x = vector()
meta.y = list()

# 1st fold for validation
stacking.train = rbind(train.folds[[2]], train.folds[[3]])
stacking.valid = train.folds[[1]]
stacking.test = test

model_2 = svm(lpsa~., stacking.train)

tmp.meta.x = predict(model_2, stacking.valid)
tmp.meta.y = predict(model_2, stacking.test)

meta.x = c(meta.x, tmp.meta.x)
meta.y[[1]] = tmp.meta.y

# 2nd fold for validation
stacking.train = rbind(train.folds[[1]], train.folds[[3]])
stacking.valid = train.folds[[2]]
stacking.test = test

model_2 = svm(lpsa~., stacking.train)

tmp.meta.x = predict(model_2, stacking.valid)
tmp.meta.y = predict(model_2, stacking.test)

meta.x = c(meta.x, tmp.meta.x)
meta.y[[2]] = tmp.meta.y

# 3rd fold for validation
stacking.train = rbind(train.folds[[1]], train.folds[[2]])
stacking.valid = train.folds[[3]]
stacking.test = test

model_2 = svm(lpsa~., stacking.train)

tmp.meta.x = predict(model_2, stacking.valid)
tmp.meta.y = predict(model_2, stacking.test)

meta.x = c(meta.x, tmp.meta.x)
meta.y[[3]] = tmp.meta.y

# Average Meta.X of Test
mean.meta.y = (meta.y[[1]] + meta.y[[2]] + meta.y[[3]]) / 3

meta.train.2 = data.frame(`meta.x` = meta.x, 
                          y=train$lpsa)

meta.test.2 = data.frame(`mete.y` = mean.meta.y, 
                         y = test$lpsa)


#######################################################################################
#��ӤW�����y�{�A�ĤT�Ӽҫ��h�� CART �M����G

require(rpart)
meta.x = vector()
meta.y = list()

# 1st fold for validation
stacking.train = rbind(train.folds[[2]], train.folds[[3]])
stacking.valid = train.folds[[1]]
stacking.test = test

model_3 = rpart(lpsa~., stacking.train)

tmp.meta.x = predict(model_3, stacking.valid)
tmp.meta.y = predict(model_3, stacking.test)

meta.x = c(meta.x, tmp.meta.x)
meta.y[[1]] = tmp.meta.y

# 2nd fold for validation
stacking.train = rbind(train.folds[[1]], train.folds[[3]])
stacking.valid = train.folds[[2]]
stacking.test = test

model_3 = rpart(lpsa~., stacking.train)

tmp.meta.x = predict(model_3, stacking.valid)
tmp.meta.y = predict(model_3, stacking.test)

meta.x = c(meta.x, tmp.meta.x)
meta.y[[2]] = tmp.meta.y

# 3rd fold for validation
stacking.train = rbind(train.folds[[1]], train.folds[[2]])
stacking.valid = train.folds[[3]]
stacking.test = test

model_3 = rpart(lpsa~., stacking.train)

tmp.meta.x = predict(model_3, stacking.valid)
tmp.meta.y = predict(model_3, stacking.test)

meta.x = c(meta.x, tmp.meta.x)
meta.y[[3]] = tmp.meta.y

# Average Meta.X of Test
mean.meta.y = (meta.y[[1]] + meta.y[[2]] + meta.y[[3]]) / 3

meta.train.3 = data.frame(`meta.x` = meta.x, 
                          y=train$lpsa)

meta.test.3 = data.frame(`mete.y` = mean.meta.y, 
                         y = test$lpsa)

########################################################################################
#�W�z�y�{���z:

# 1.�����XTraining Data, Test Data

# 2.Training Data���O�m�J3�Ӽҫ�>> lm(), SVR(), CART() 

#For lm():

    #�NTraining Data�����T��subset(3-folds) 
    # �@�����Ω�V�m�@�����Ω�w��
    # ����3�ӹw�����G >> ���X�ഫ��Predict_X�A�]�N�OMeta-x  
    
    # Test Data��J�ҫ���]�i�H�o��Predict(�@3��)
    # �����Υ����k(�s����D)/�벼�k(�������D)��X��Predict_Y�A�]�N�OMeta-y

    # ��1�ӽu�ʼҫ��]���T������A�N�|�o��@��meta.x��meta.y�A
    # �A�򥻨Ӫ���ڭ�(train$lpsa, test$lpsa)���X�A
    # ������1�Ӽҫ���X�� meta.train.1�� meta.test.1

#For SVR():

    #�NTraining Data�����T��subset(3-folds) 
    # �@�����Ω�V�m�@�����Ω�w��
    # ����3�ӹw�����G >> ���X�ഫ��Predict_X�A�]�N�OMeta-x  
    
    # Test Data��J�ҫ���]�i�H�o��Predict(�@3��)
    # �����Υ����k(�s����D)/�벼�k(�������D)��X��Predict_Y�A�]�N�OMeta-y
    
    # ��2��SVR�ҫ��]���T������A�N�|�o��@��meta.x��meta.y�A
    # �A�򥻨Ӫ���ڭ�(train$lpsa, test$lpsa)���X�A
    # ������2�Ӽҫ���X�� meta.train.2�� meta.test.2

#For CART():

    #�NTraining Data�����T��subset(3-folds) 
    # �@�����Ω�V�m�@�����Ω�w��
    # ����3�ӹw�����G >> ���X�ഫ��Predict_X�A�]�N�OMeta-x  
    
    # Test Data��J�ҫ���]�i�H�o��Predict(�@3��)
    # �����Υ����k(�s����D)/�벼�k(�������D)��X��Predict_Y�A�]�N�OMeta-y
    
    # ��3��CART�ҫ��]���T������A�N�|�o��@��meta.x��meta.y�A
    # �A�򥻨Ӫ���ڭ�(train$lpsa, test$lpsa)���X�A
    # ������3�Ӽҫ���X�� meta.train.3�� meta.test.3



#�W���ܽd�ⶥ�q�����p�Ӥw�C
#��ڤW�b Kaggle ���ɤ��A�ܱ`�ݨ��o�i���T�B�|���q�� Stacking �ҫ��C

#######################################################################################

#�ĤG���q(Blending)



#�{�b�ڭ̤⤤���T�� Meta-Train �� �T�� Meta-Test�G
c(dim(meta.train.1), dim(meta.test.1))


#�غc�ĤG���q�� Meta-Model
#
### Meta- Model Construction 

# ����T�� Meta-Train�X�֤@�_�G
big.meta.train = rbind(meta.train.1, meta.train.2, meta.train.3)

# �ഫ�� xgboost ���榡
dtrain = xgb.DMatrix(data = as.matrix(big.meta.train[,1]), label = big.meta.train[, 2])
#xgb.DMatrix  dim: 234 x 1  info: label  colnames: no





# �V�m XGboost �ҫ�

# �䤤xgb.params �������ĤG�`(Boosting)���]�w
xgb.params = list(
    #     #col����ˤ�ҡA�V�����ܨC�ʾ�ϥΪ�col�V�h�A�|�W�[�C�ʤp�𪺽�����
    colsample_bytree = 0.5,
    
    #     # row����ˤ�ҡA�V�����ܨC�ʾ�ϥΪ�col�V�h�A�|�W�[�C�ʤp�𪺽�����
    subsample = 0.5, 
    booster = "gbtree",
    
    #     # �𪺳̤j�`�סA�V�����ܼҫ��i�H���o�V�`�A�ҫ������׶V��
    max_depth = 2,    
    
    #     # boosting�|�W�[�Q����������v���A�Ӧ��ѼƬO���v�����|�W�[������֡A�]���V�j�|���ҫ��U�O�u
    eta = 0.03,
    #     # �Υ�'mae'�]�i�H
    
    eval_metric = "rmse",                      
    objective = "reg:linear",
    
    #     # �V�j�A�ҫ��|�V�O�u�A�۹諸�ҫ������פ���C
    gamma = 0)   

# ²��� nrounds = 100
xgb.model = xgb.train(paras = xgb.params, data = dtrain, nrounds = 100) 





# ��T�� Meta-Test�i��w���G
dtest.1 = xgb.DMatrix(data = as.matrix(meta.test.1[,1]), label = meta.test.1[, 2])
# �ഫ�� xgboost ���榡
final_1 = predict(xgb.model, dtest.1)


dtest.2 = xgb.DMatrix(data = as.matrix(meta.test.2[,1]), label = meta.test.2[, 2])
# �ഫ�� xgboost ���榡
final_2 = predict(xgb.model, dtest.2)


dtest.3 = xgb.DMatrix(data = as.matrix(meta.test.3[,1]), label = meta.test.3[, 2])
# �ഫ�� xgboost ���榡
final_3 = predict(xgb.model, dtest.3)


# ��T�յ��G�����_�ӡA�M��� MSE
final_y = (final_1 + final_2 + final_3)/3
mean((final_y - test$lpsa)^2) # MSE
# 0.6444626






