
# R���ܦh�i�H��{�`�׾ǲ�/�����g�������M��(neuralnet�Bnnet�Bh2o�Bmxnet)
# 
# �ϥ�mxnet�M��غc�H�U�ҫ��G
    # �`�ׯ��g����(DNN: Deep Neuron Networks)
    # ���n�����g����(CNN: Convolutional Neural Networks)

# �۸����L�M��A�ڬݤ�mxnet���u�I���|�ӡG
    # �㦳�j�j���u�ʡA���\�ۦ�]�p�ŦX�ݨD�������g�����ҫ�(�U���|����ԲӤ���)�C
    # �䴩GPU���B��C
    # ���{DNN, CNN, RNN-LSTM�K���`�׾ǲߺt��k�C
    # �P�ɨ㦳python�������A�g�k�X�G�@�Ҥ@�ˡA�ӥB�Mpython�t�@�Ӳ`�׾ǲߪ��M��keras�g�k�]�۪�F�Y���Ӧ����|�Hpython��@�`�׾ǲߡA��ܧִN�W��C

########################################################################################################################################################
#��ƹw�B�z:


# 42000���[���ȡA�C�@���N���@�i��g�Ʀr���Ϥ�
# 784�Ӧ��ܼơG 28 x 28 pixels�A�H�Ƕ���0~255���ܡC
# ���ܼ�label�A�N���o�i�Ϥ��H�x���Ʀr�A
# �]�O�b���ո��(test.csv)���n�w�����ȡC
train <- read.csv("C:/Users/USER/Desktop/R resourse/R Training/train.csv")
dim(train)
# [1] 42000   785


# 28000���[���ȡA�C�@���N���@�i��g�Ʀr���Ϥ�
# 784�Ӧ��ܼơG 28 x 28 pixels�A�H�Ƕ���0~255���ܡC
# �Llabel�A�n�w����
test <- read.csv('C:/Users/USER/Desktop/R resourse/R Training/test.csv')
dim(test)
# [1] 28000   784







# ����ഫ�� 28x28 ���x�}
obs.matrix <- matrix(unlist(train[1, -1]), # ignore 'label'
                     nrow = 28,            
                     byrow=T)
str(obs.matrix)
# int [1:28, 1:28] 0 0 0 0 0 0 0 0 0 0 ...


# �� image �e�ϡA�C����w���Ƕ��� 0~255
image(obs.matrix, 
      col=grey.colors(255))


# �ѩ�쥻���ϬO�˪��A�]���g�@��½�઺�禡�G
# rotates the matrix
rotate <- function(matrix){
    t(apply(matrix, 2, rev)) 
} 

# �e�X��1��~��8����ƪ���
par(mfrow=c(2,4))
for(x in 1:8){
    obs.matrix <- matrix(unlist(train[x, -1]), # ignore 'label'
                         nrow = 28,            
                         byrow=T)
    
    image(rotate(obs.matrix),
          col=grey.colors(255),
          xlab=paste("Label", train[x, 1], sep=": "),
          cex.lab = 1.5
    )
}




#�b�ؼҤ��e�A�]����Ƹ̭���pixels���Ȭ�0 ~ 255�A
#�]����²�氵���ഫ�A��pixels�b0~1�����G
#�o�B�J������!!
#
# data preparation
train.x <- t(train[, -1]/255) # train: 28 x 28 pixels
train.y <- train[, 1]         # train: label
test.x <- t(test/255)         # test: 28 x 28 pixels

########################################################################################################################################################

#�ҫ��غc (MXnet)

install.packages("Mxnet")


########################################################################################################################################################
# 
# DNN
#
# �ҿת�DNN�A�N�O�u�h�h���üh�v�������g�����C
# �@��ӻ��A�����g�������򥻫������O(8)���Ъ��u�˶ǻ������g����(BPN)�v�C
# 
# �M�ӡA��h�����h��BPN�A�b����j�ƾ�(Big Data)��ĳ�D�W�A��w���ĪG�M�B�z�Ĳv�S���Q�������n(�ר�O�Ϥ��B�z�B�v���B�z�B�y���B�z�K)�A
# 
# �]�����H���ҤޤJ�h�h���üh�A�X�i���g�������u�`�סv�G
# �{�b�����üh�Ѩ��X�uinput���@�ǯS�x�v��A���@�U�@���üh��input�C
# �H�ۼh�ƶV�h�A������Ѫ��u�S�x�v�]�|�V���T�C�H�������ӼW�[�̫᪺�w���ĪG�C
# 
# ���L�H�����üh�W�[�A�\�h���D�]�|����ӨӡG�u��״ݮt�����v�B�u�v���ƶq���W�v�K
# �]���S���H���۴��X�u�E�o��Ƨאּrelu�v�B�uDropout�����v�B�umin batch�v�K���Q�k�ӸѨM�o�ǰ��D�C

#����DNN���Ա��A�o�̤��h�[�حz�A�i�H�ѷӥx�j�����ݦѮv�����q�G �@�ѷd���`�׾ǲߡC

########################################################################################################################################################

# Build Model


# ��J�h
data <- mx.symbol.Variable("data")

# �Ĥ@���üh: 500�`�I�A���A�OFull-Connected
fc1 <- mx.symbol.FullyConnected(data, name="1-fc", num_hidden=500)
# �Ĥ@���üh���E�o���: Relu
act1 <- mx.symbol.Activation(fc1, name="relu1", act_type="relu")
# �o�̤ޤJdropout������
drop1 <- mx.symbol.Dropout(data=act1, p=0.5)

# �ĤG���üh: 400�`�I�A���A�OFull-Connected
fc2 <- mx.symbol.FullyConnected(drop1, name="2-fc", num_hidden=400)
# �ĤG���üh���E�o���: Relu
act2 <- mx.symbol.Activation(fc2, name="relu2", act_type="relu")
# �o�̤ޤJdropout������
drop2 <- mx.symbol.Dropout(data=act2, p=0.5)

# ��X�h�G�]���w���Ʀr��0~9�@�Q�ӡA�`�I��10
output <- mx.symbol.FullyConnected(drop2, name="output", num_hidden=10)
# Transfer the Evidence to Probability by Softmax-function
dnn <- mx.symbol.SoftmaxOutput(output, name="dnn")
# 
# �]����X�h�����G�O���O���A(0~9���Ʀr)�A�]���̫�@��ϥΪ��Osoftmax�C
# �Y�{�b�n�w�����O�s�򫬺A�A�N�אּmx.symbol.LinearRegressionOutput())

#�̫�A�гy�F�@�Ө㦳��h���üh(500, 400)�A�f�t�E�o���Relu�A�H�ΤޤJDropout�����������g�����C





#��ı�ƨ䵲�c�G

# ���g���������U�ӰѼƪ���T
arguments(dnn)

# ��ı��DNN���c
graph.viz(dnn$as.json(),
          graph.title= "DNN for Kaggle��Digit Recognizer")




########################################################################################################################################################

#Train Model

#���U�ӡA�N��train.x�ӰV�m���гy�����g�����A�����Ѽƪ��]�w�Q�����n�G

mx.set.seed(0) 

# �V�m���гy/�]�p���ҫ�
dnn.model <- mx.model.FeedForward.create(
    dnn,       # ���]�p��DNN�ҫ�
    X=train.x,  # train.x
    y=train.y,  #  train.y
    ctx=mx.cpu(),  # �i�H�M�w�ϥ�cpu��gpu
    num.round=10,  # iteration round
    array.batch.size=100, # batch size
    learning.rate=0.07,   # learn rate
    momentum=0.9,         # momentum  
    eval.metric=mx.metric.accuracy, # �����w�����G����Ǩ禡*
    initializer=mx.init.uniform(0.07), # ��l�ưѼ�
    epoch.end.callback=mx.callback.log.train.metric(100)

#
## Start training with 1 devices
## [1] Train-accuracy=0.859379474940333
## [2] Train-accuracy=0.932333333333333
## [3] Train-accuracy=0.944928571428571
## [4] Train-accuracy=0.9515
## [5] Train-accuracy=0.957095238095239
## [6] Train-accuracy=0.959952380952382
## [7] Train-accuracy=0.963761904761905
## [8] Train-accuracy=0.966047619047621
## [9] Train-accuracy=0.965904761904764
## [10] Train-accuracy=0.969190476190479

# 
# �˼ƲĤT�Ӫ��ѼơGeval.metric�C
# 
# �]���ϥΪ��Omx.metric.accuracy�A�Ψӵ����u�w�����ǽT�v�v�A�ҥH�b�V�m�ҫ��ɪ���X�~�|�OTrain-accuracy�C
# 
#�p�G�{�b�n�����u�s��ƭȡv���w���ĪG�A�i�H��ϥ�mx.metric.mae�Bmx.metric.rmse�A�o�˴N�|��MSE�U�p�U�n���覡�ӰV�m�ҫ��C
# 
# �̴Ϊ��O�A�p�G�ۤv���S���ݨD(�Ҧp�A�ڷQ�ݪ��OR-Squared)�A
# mxnet���\�ڭ̥i�H�ۦ�]�p�ݩ�ۤv�������禡�A�A�N�ѼƳ]�w���G eval.metric = my.eval.metric�N�n�G

# define my own evaluate function (R-squared)
my.eval.metric <- mx.metric.custom(
    name = "R-squared", 
    function(real, pred) {
        mean_of_obs <- mean(real)
        
        SS_tot <- sum((real - mean_of_obs)^2)
        SS_reg <- sum((predict - mean_of_obs)^2)
        SS_res <- sum((real - predict)^2)
        
        R_squared <- 1 - (SS_res/SS_tot)
        R_squared
    }
)




########################################################################################################################################################

#�w��:

# test prediction 
test.y <- predict(dnn.model, test.x)
test.y <- t(test.y)
test.y.label <- max.col(test.y) - 1

# Submission format for Kaggle
result <- data.frame(ImageId = 1:length(test.y.label),
                     label = test.y.label)








########################################################################################################################################################
# 
# CNN


#�إ߼ҫ�(�HLeNet����):


# ��J�h
data <- mx.symbol.Variable('data')


# �Ĥ@���n�h�Awindows�������j�p�O 5x5, filter=20
conv1 <- mx.symbol.Convolution(data=data, kernel=c(5,5), num_filter=20, name="1-conv")
# �Ĥ@���n�h���E�o��ơGtanh
conv.act1 <- mx.symbol.Activation(data=conv1, act_type="tanh", name="1-conv.act")
# �Ĥ@���n�h�᪺���Ƽh�Amax�A�j�p�Y�� 2x2
pool1 <- mx.symbol.Pooling(data=conv.act1, pool_type="max", name="1-conv.pool",
                           kernel=c(2,2), stride=c(2,2))

# �ĤG���n�h�Awindows�������j�p�O 5x5, filter=50
conv2 <- mx.symbol.Convolution(data=pool1, kernel=c(5,5), num_filter=50, name="2-conv")
# �ĤG���n�h���E�o��ơGtanh
conv.act2 <- mx.symbol.Activation(data=conv2, act_type="tanh", name="2-conv.act")
# �ĤG���n�h�᪺���Ƽh�Amax�A�j�p�Y�� 2x2
pool2 <- mx.symbol.Pooling(data=conv.act2, pool_type="max", name="2-conv.pool",
                           kernel=c(2,2), stride=c(2,2))


# Flatten
flatten <- mx.symbol.Flatten(data=pool2)


#�᭱�������N�MDNN�O�@�˪�


# �إߤ@��Full-Connected�����üh�A500�`�I
fc1 <- mx.symbol.FullyConnected(data=flatten, num_hidden=500, name="1-fc")
# ���üh���E�o�禡�Gtanh
fc.act1 <- mx.symbol.Activation(data=fc1, act_type="tanh", name="1-fc.act")

# ��X�h�G�]���w���Ʀr��0~9�@�Q�ӡA�`�I��10
output <- mx.symbol.FullyConnected(data=fc.act1, num_hidden=10, name="output")
# Transfer the Evidence to Probability by Softmax-function
cnn <- mx.symbol.SoftmaxOutput(data=output, name="cnn")


########################################################################################################################################################

#��ı�ƨ䵲�c�G

# ���g���������U�ӰѼƪ���T
arguments(cnn)

# ��ı��CNN���c
graph.viz(cnn$as.json(),
          graph.title= "CNN for Kaggle��Digit Recognizer"
)


########################################################################################################################################################

#Train Model

#�b�V�m���e���@��Ʊ��n�`�N�A�]��LeNet���n�D�J�w��input�榡()�A
#�MDNN���@�ˡA�ڭ̤��ઽ����train.x�ӰV�m�A
#�o���Ntrain.x�Mtest.x�ഫ���@�ӥ|���x�}�A�~��i��V�m�G


# Transform matrix format for LeNet 
train.array <- train.x
dim(train.array) <- c(28, 28, 1, ncol(train.x))
test.array <- test.x
dim(test.array) <- c(28, 28, 1, ncol(test.x))
mx.set.seed(0)


# �V�m���]�p��CNN�ҫ�
cnn.model <- mx.model.FeedForward.create(
    cnn,       # ���]�p��CNN�ҫ�
    X=train.array,  # train.x
    y=train.y,  #  train.y
    ctx=mx.cpu(),  # �i�H�M�w�ϥ�cpu��gpu
    num.round=10,  # iteration round
    array.batch.size=100, # batch size
    learning.rate=0.07,   # learn rate
    momentum=0.7,         # momentum  
    eval.metric=mx.metric.accuracy, # �����w�����G����Ǩ禡*
    initializer=mx.init.uniform(0.05), # ��l�ưѼ�
    epoch.end.callback=mx.callback.log.train.metric(100)
)

#
## Start training with 1 devices
## [1] Train-accuracy=0.913842482100241
## [2] Train-accuracy=0.977904761904765
## [3] Train-accuracy=0.98514285714286
## [4] Train-accuracy=0.989285714285717
## [5] Train-accuracy=0.992285714285717
## [6] Train-accuracy=0.994214285714287
## [7] Train-accuracy=0.996142857142858
## [8] Train-accuracy=0.997333333333334
## [9] Train-accuracy=0.99802380952381
## [10] Train-accuracy=0.99854761904762




########################################################################################################################################################


#Prediction


# test prediction 
test.y <- predict(cnn.model, test.array)
test.y <- t(test.y)
test.y.label <- max.col(test.y) - 1

# Submission format for Kaggle
result <- data.frame(ImageId = 1:length(test.y.label),
                     label = test.y.label)


# Kaggle Score = 0.98871












