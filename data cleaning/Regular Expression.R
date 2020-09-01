
# # Regular Expression (���W���ܦ�)�O���@�կ�ΨӪ��ܦr��@�P�榡 (common structure)���˦� (Pattern)
# ���O@�Ÿ��|�T�w�X�{�bemail���A�άO������X�T�w�O10�X�A�����˦��C 
# �b�Ҧ����{���y�����A�u�n�Ψ�r����P�r����N���r������\��A���|�Ψ쥿�W���ܦ��C
# ���M���W���ܦ��b���P�{���y�����|���ǳ\�t���A���֤߷����O�ۦP���C
# 
# �i�H�Υ��W���ܦ���R��Ʀp�U�G
# grep()
# grepl()
# gsub()
# str_split()
# stringr package�����Ѧh���

# ���W���ܦ����`�λy�k�����p�U�G

# �k��r��
#  ****

# ���ܼƶq
# *:�X�{0~�L���h��
# +: �X�{1~�L���h��
# ?: �X�{0~1��
# {n}: �X�{n��
# {n,}: �X�{n~�L���h��
# {n,m}: �X�{n~m��

stringVector<-c("a","abc","ac","abbc","abbbc","abbbbc")
grep("ab*",stringVector,value=T)
## [1] "a"      "abc"    "ac"     "abbc"   "abbbc"  "abbbbc"

grep("ab+",stringVector,value=T)
## [1] "abc"    "abbc"   "abbbc"  "abbbbc"

grep("ab?c",stringVector,value=T)
## [1] "abc" "ac"

grep("ab{2}c",stringVector,value=T)
## [1] "abbc"

grep("ab{2,}c",stringVector,value=T)
## [1] "abbc"   "abbbc"  "abbbbc"

grep("ab{2,3}c",stringVector,value=T)
## [1] "abbc"  "abbbc"    

# ���ܦ�m
# ^: �X�{�b�r��}�l����m
# $: �X�{�b�r�굲��������m
# \b: �X�{�Ŧr��(�ť�)�}�l�ε�������m
# \B: �X�{�D�r��}�l�ε�������m

stringVector<-c("abc","bcd","cde","def","abc def","bcdefg abc")
grep("^bc",stringVector,value=T)
## [1] "bcd"        "bcdefg abc"

grep("bc$",stringVector,value=T)
## [1] "abc"        "bcdefg abc"

grep("\\bde",stringVector,value=T)
## [1] "def"     "abc def"

grep("\\Bde",stringVector,value=T)
## [1] "cde"        "bcdefg abc"

# �B��l
# .: �X�{�Ҧ����r���@���A�]�A�Ŧr��
# [...]: �X�{�r���M��(�K)�����r���@���A�i��-���ܽd��A�p[A-Z]�A[a-z]�A[0-9]
# [^...]: ���X�{�r���M��(�K)�����r��
# \: �n�j�M�r�ꤤ���S���r���ɡA�e�趷�[�W\
# |: ��

stringVector<-c("03-2118800","02-23123456","0988123456",
                "07-118","0-888","csim@mail.cgu.edu.tw","csim@.","csim@",
                "http://www.is.cgu.edu.tw/")
grep("[0-9]{2}-[0-9]{7,8}",stringVector,value=T)
## [1] "03-2118800"  "02-23123456"

grep("[0-9]{10}",stringVector,value=T)
## [1] "0988123456"

grep("02|03",stringVector,value=T)
## [1] "03-2118800"  "02-23123456"

grep("[a-zA-Z0-9_]+@[a-zA-Z0-9._]+",stringVector,value=T)
## [1] "csim@mail.cgu.edu.tw" "csim@."


# �S���Ÿ�
# \d: �Ʀr�A���� [0-9]
# \D: �D�Ʀr�A���� [^0-9]
# [:lower:]: �p�g�r�A���� [a-z]
# [:upper:]: �j�g�r�A���� [A-Z]
# [:alpha:]: �Ҧ��^��r�A���� [[:lower:][:upper:]] or [A-z]
# [:alnum:]: �Ҧ��^��r�M�Ʀr�A���� [[:alpha:][:digit:]] or [A-z0-9]
# \w: ��r�Ʀr�P���u�A���� [[:alnum:]_] or [A-z0-9_]
# \W: �D��r�Ʀr�P���u�A���� [^A-z0-9_]
# [:blank:]: �ťզr���A�]�A�ťթMtab
# \s: �ťզr��, 
# \S: �D�ťզr��
# [:punct:]: ���I�Ÿ� ! " # $ % & �� ( ) * + , - . / : ; < = > ? @ ^ _ ` { | } ~.

stringVector<-c("03-2118800","02-23123456","0988123456",
                "07-118","0-888","csim@mail.cgu.edu.tw","http://www.is.cgu.edu.tw/")
grep("\\d{2}-\\d{7,8}",stringVector,value=T)
## [1] "03-2118800"  "02-23123456"

grep("\\d{10}",stringVector,value=T)
## [1] "0988123456"

grep("\\w+@[a-zA-Z0-9._]+",stringVector,value=T)
## [1] "csim@mail.cgu.edu.tw"