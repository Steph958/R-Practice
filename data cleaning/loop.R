#�y�{����

# �bR�̭��A�y�{������O�D�n�i�H�����T���G
# 
# �޿�P�_�G>�B<�B==�B!=�B%in%�B&�B|�B!
# ������O�Gif�Belse�Bifelse�Bswitch
# �j����O�Gfor�Bwhile�Brepeat�Bbreak�Bnext


##############################################################
#�޿�P�_:
x <- 5
y <- c(0,2,3)

x %in% c(1,2,3,4,5) 
y %in% c(1,2,3,4,5)

x <- 5
y <- 8

!(x > 3)         
## [1] FALSE

x > 3 & y > 10   # AND�G�M�F�涰(&)
## [1] FALSE

x > 3 | y > 10   # OR �G�ΡF�p��(|)
## [1] TRUE

# &�M&&���ϧO�G

c(T,T,T) & c(F,T,T)    # �Τ@��&�A�|�N�V�q�����C�@�Ӥ������ۤ��A�P�_�OTrue/False
## [1] FALSE  TRUE  TRUE
c(T,T,T) && c(F,T,F)   # �Ψ��&�A�u�|�N�V�q�����u�Ĥ@�Ӥ����v���ۤ��Ӥw
## [1] FALSE


######################################################################
#������O:

if(3 > 2){
    TRUE
}else{
    FALSE
}


score<-95
if(score>=90){
    print("�u�q")
}else if(score>=60){
    print("�ή�")
}else{
    print("���ή�")
}


CHscore<-95 ##��妨�Z
ENscore<-55 ##�^�妨�Z
if(CHscore>=60){
    if(ENscore>=60){
        print("�����ή�")
    }else{
        print("���ή�A�^��A�[�o")
    }
}else{
    if(ENscore>=60){
        print("�^��ή�A���A�[�o")
    }else{
        print("�������ή�")
    }
}





# ���g�k
if(3 > 2) TRUE else FALSE

score<-80
ifelse(score>=60,"�ή�","���ή�")

ifelse(2 > 3, T, F)

scoreVector<-c(30,90,50,60,80)
ifelse(scoreVector>=60,"�ή�", "���ή�")


switch(2,      # ���w����ĤG��{���X�A�G�^��4�C(�Цۦ�ק�Ʀr�A�ݤ��P�����G)
       1+1,    # �Ĥ@��G1+1
       2^2,    # �ĤG��G2������
       3*6)    # �ĤT��G3*6

switch("Tom",  # ���w����W�٬�Tom���o��{���X�A�G�^��7 (�Цۦ�ק�W�١A�ݤ��P�����G)
       Tom = 2+5,         
       Susan = 1*0,       
       Helen = "Apple",
       Lee = 1024)

######################################################################
#�j����O:

#for-loop

result <- 0

for(i in c(1:135)){ 
    # for-loop�̡Ai�|�̧Ǳa�J1~135���ȡA���ƶi��A�������{���X
    
    # �j�餺���ƶi�檺�ʧ@
    result <- result + i
}

result

#while-loop

i <- 1
result <- 0

while(i < 136){   
    # while-loop���ŦX�̭�������ɡA�N�|�@�����ƬA�������{���X�A���줣�ŦX����
    
    # �j�餺���ƶi�檺�ʧ@
    result <- result + i
    i <- i + 1
}

result

#repeat-loop

i <- 1
result <- 0

repeat{         
    # repeat�Mwhile�ܹ��A�t�O�b�����i�H�g�b����a��A�åB�ϥ�break���X�j��
    
    if(i > 135) break # ��i��135�j�ɡA��break���X�j��
    
    # �j�餺���ƶi�檺�ʧ@
    result <- result + i
    i <- i + 1
}

result



#break�Mnext

# break �D�n�ΨӸ��X�j��
for(i in c(1:5)){
    
    if(i == 3) break  # ��i����3���ɭԡA���X�j��
    
    # �j�餺���ƶi�檺�ʧ@
    print(i)  
}


# next �D�n�ΨӬٲ������j�骺�欰�A�����i�J�U�@���j��

for(i in c(1:5)){
    
    if(i == 3) next  # ��i����3���ɭԡA�ٲ������j��(skip)���ʧ@�A�q�U�@��i=4�}�l
    
    # �j�餺���ƶi�檺�ʧ@
    print(i)  
}