

# ���g�ؿ�

    # ���h�����s(Hierarchical Clustering)
    # ���Φ����s(Partitional Clustering)
        # K-Means
        # K-Medoid

    # ���s���̨μƥ�(Optimal number of clusters)
        # Elbow Method
        # Average Silhouette Method

    # �Ф��s(Spectral Clustering)
        # ��ʹ���Ф��s
        # �ϥήM��kernlab


##################################################################################################################
# �D�n�i�H������������G
# 
# ��o��(Compactness):�|�Ʊ�u���餧�����Z���V�p�V�n�v�A���s�餺���V��o�V�n�G
    # ���h�����s(Hierarchical Clustering)�G���ݫ��w���s�ƥءA����Ʀ۰ʥѤW���U/�ѤU���W���X�_�ӡC
    # ���Φ����s(Partitional Clustering)�G�ݨƥ����w���s�ƥءA�g�L���_�����N�A����s�����ܲ��̤p�C
# �s�q��(Connectedness)�A�|�Ʊ�u�i�H�걵��������b�P�@�s�v�G
    # �Ф��s(Spectral Clustering)�G���Ͻ׸�Graph Laplacian����k�A���u��ƪ��Ϊ�(shape)�v�Ҷq�i��


##################################################################################################################
#���h�����s(Hierarchical Clustering)

head(iris)

# �ѩ���s�ݩ�u�D�ʷ����ǲߡv���t��k�A
# �]���ڭ̥���iris�����~��(Species)��쮳���A�H�ѤU����ƶi����s�G
data <- iris[, -5]  
head(data)       



E.dist <- dist(data, method="euclidean") # �ڦ��Z��
M.dist <- dist(data, method="manhattan") # �ҫ��y�Z��



#�ھڸ�ƶ����Z���A�Ӷi�涥�h�����s�A�ϥ�hclust()�G

par(mfrow=c(1,2)) # ���Ϥ��H1x2���覡�e�{�A�Ա��Ш�(4)ø��-��Ƶ�ı��

# �ϥμڦ��Z���i����s
h.E.cluster <- hclust(E.dist)
plot(h.E.cluster, xlab="�ڦ��Z��")

# �ϥΰҫ��y�Z���i����s
h.M.cluster <- hclust(M.dist) 
plot(h.M.cluster, xlab="�ҫ��y�Z��")





#�bhclust()�̭��i�H�վ�Ѽ�method�A��ܤ��P�����X��k�G

# hclust(E.dist, method="single")   # �̪�k
# hclust(E.dist, method="complete") # �̻��k
# hclust(E.dist, method="average")  # �����k
# hclust(E.dist, method="centroid") # ���ߪk
# hclust(E.dist, method="ward.D2")  # �ؼw�k

#�b�o�ӨҤl���A�ڭ̴N�μڦ��Z���f�t�ؼw�k�A�Ӷi�涥�h�����s�G

E.dist <- dist(data, method="euclidean")      # �ڦ��Z��
h.cluster <- hclust(E.dist, method="ward.D2") # �ؼw�k






# ��ı��
plot(h.cluster)
abline(h=9, col="red")

# �ѤW�ϡA�i�H�[��̨Ϊ����s�ƥجO3�ӡA
# �]���ڭ̥i�H�Q��cutree()�A����Ӷ��h�����c�Y��A�ܦ������T�s�����A�G

cut.h.cluster <- cutree(h.cluster, k=3)  
cut.h.cluster                            
# [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# [40] 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 3
# [79] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 3 2 3 3 3 3 2 3 3 3 3 3 3 2 2 3 3
# [118] 3 3 2 3 2 3 2 3 3 2 2 3 3 3 3 3 2 2 3 3 3 2 3 3 3 2 3 3 3 2 3 3 2

table(cut.h.cluster, iris$Species)       
# ���s���G�M��ڵ��G���
# cut.h.cluster setosa versicolor virginica
#         1     50          0         0
#         2      0         49        15
#         3      0          1        35


library(ggplot2)
qplot(x=Petal.Length,                               
      y=Petal.Width,                              
      data=iris,                      
      geom="point",                  # �ϧ�=scatter plot
      main = "Scatter Plot of Flower Species", #���D
      xlab="Petal.Length",                          
      ylab="Petal.Width",                    
      color= Species    # �H�C��е��~�ءA�ƦX����������
)

# �Ϥ����k�W���A���@��virginica(�Ŧ�)�Mversicolor(���)�a�o�Q����



##################################################################################################################
#���Φ����s(Partitional Clustering)



#K-Means
#�ϥΨ禡�Okmeans()�G
# �����T�s
kmeans.cluster <- kmeans(data, centers=3) 

# �s�����ܲ���
kmeans.cluster$withinss

# ���s���G�M��ڵ��G���
table(kmeans.cluster$cluster, iris$Species)  
# setosa versicolor virginica
# 1      0          2        36
# 2      0         48        14
# 3     50          0         0


# ��ı�� k-means ���s���G(���ggplot2���y�k)
install.packages("factoextra")
library(factoextra)

fviz_cluster(kmeans.cluster,           # ���s���G
             data = data,              # ���
             geom = c("point","text"), # �I�M����(point & label)
             frame.type = "norm")      # �ج[���A






# K-Medoid
# �ϥΨ禡�Opam()�A�bcluster�o�ӮM��̭��G

require(cluster)

# pam = Partitioning Around Medoids
kmedoid.cluster <- pam(data, k=3) 

# �s�����ܲ���
kmedoid.cluster$objective

# ���s���G�M��ڵ��G���
table(kmedoid.cluster$clustering, iris$Species) 
# setosa versicolor virginica
# 1     50          0         0
# 2      0         48        14
# 3      0          2        36


# ��ı�� k-medoid ���s���G(���ggplot2���y�k)
require(factoextra)
fviz_cluster(kmedoid.cluster,       # ���s���G
             data = data,           # ���
             geom = c("point"),     # �I (point)
             frame.type = "norm")   # �ج[���A



##################################################################################################################
#���s���̨μƥ�


#Elbow Method
#��X�@�ӼƦrn�A�ϱo��ƳQ����n�s�ɡA�s�����`�ܲ�(SSE)�|�̤p
#����n = �̨Ϊ����s�ƥ�(optimal number for clusters)

require(factoextra)

# Elbow Method ���Φb���h�����R
# �`�N�G�o�̨ϥΪ��Ohcut()�A�ݩ�factoextra�M��A�ëD�W������hclust()
fviz_nbclust(data, 
             FUNcluster = hcut,  # hierarchical clustering
             method = "wss",     # total within sum of square
             k.max = 12          # max number of clusters to consider
) + labs(title="Elbow Method for HC") +
    geom_vline(xintercept = 3,       # �b X=3���a�� 
               linetype = 2)         # �e�@����u


# Elbow Method ���Φb K-Means
fviz_nbclust(data, 
             FUNcluster = kmeans,# K-Means
             method = "wss",     # total within sum of square
             k.max = 12          # max number of clusters to consider
) +labs(title="Elbow Method for K-Means") +
    geom_vline(xintercept = 3,        # �b X=3���a�� 
               linetype = 2)          # �e�@��������u


# Elbow Method ���Φb K-Medoid
fviz_nbclust(data, 
             FUNcluster = pam,   # K-Medoid
             method = "wss",     # total within sum of square
             k.max = 12          # max number of clusters to consider
) +labs(title="Elbow Method for K-Medoid") +
    geom_vline(xintercept = 3,       # �b X=3���a�� 
               linetype = 2)         # �e�@��������u






# Average Silhouette Method
#
# ���F�p��SSE�H�~�A�t�@�ӿŶq���s�ĪG����k�A�٬��������v�k(Average silhouette Method)�C
# 
# ���v�t��(Silhouette Coefficient)�|�ھڨC�Ӹ���I(i)�����E�O�M�����O�A�Ŷq���s���ĪG(quality)�C

#�bR�̭��A�g�k�MElbow Method�����@�Ҥ@�ˡA
#�t�O�u�b��Ѽ�method="silhouette"�Ӥw�G

#�|K-Means����:

require(factoextra)

# Avg. Silhouette ���Φb K-Means
fviz_nbclust(data, 
             FUNcluster = kmeans,   # K-Means
             method = "silhouette", # Avg. Silhouette
             k.max = 12             # max number of clusters
) + labs(title="Avg.Silhouette Method for K-Means") 





##################################################################################################################
#�Ф��s(Spectral Clustering)























