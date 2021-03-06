
# # Regular Expression (正規表示式)是指一組能用來表示字串共同格式 (common structure)的樣式 (Pattern)
# 像是@符號會固定出現在email中，或是手機號碼固定是10碼，等等樣式。 
# 在所有的程式語言中，只要用到字串比對與字串取代等字串相關功能，都會用到正規表示式。
# 雖然正規表示式在不同程式語言中會有些許差異，但核心概念是相同的。
# 
# 可以用正規表示式的R函數如下：
# grep()
# grepl()
# gsub()
# str_split()
# stringr package中的諸多函數

# 正規表示式的常用語法分類如下：

# 逃脫字元
#  ****

# 表示數量
# *:出現0~無限多次
# +: 出現1~無限多次
# ?: 出現0~1次
# {n}: 出現n次
# {n,}: 出現n~無限多次
# {n,m}: 出現n~m次

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

# 表示位置
# ^: 出現在字串開始的位置
# $: 出現在字串結束ˇ的位置
# \b: 出現空字串(空白)開始或結束的位置
# \B: 出現非字串開始或結束的位置

stringVector<-c("abc","bcd","cde","def","abc def","bcdefg abc")
grep("^bc",stringVector,value=T)
## [1] "bcd"        "bcdefg abc"

grep("bc$",stringVector,value=T)
## [1] "abc"        "bcdefg abc"

grep("\\bde",stringVector,value=T)
## [1] "def"     "abc def"

grep("\\Bde",stringVector,value=T)
## [1] "cde"        "bcdefg abc"

# 運算子
# .: 出現所有的字元一次，包括空字串
# [...]: 出現字元清單(…)中的字元一次，可用-表示範圍，如[A-Z]，[a-z]，[0-9]
# [^...]: 不出現字元清單(…)中的字元
# \: 要搜尋字串中的特殊字元時，前方須加上\
# |: 或

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


# 特殊符號
# \d: 數字，等於 [0-9]
# \D: 非數字，等於 [^0-9]
# [:lower:]: 小寫字，等於 [a-z]
# [:upper:]: 大寫字，等於 [A-Z]
# [:alpha:]: 所有英文字，等於 [[:lower:][:upper:]] or [A-z]
# [:alnum:]: 所有英文字和數字，等於 [[:alpha:][:digit:]] or [A-z0-9]
# \w: 文字數字與底線，等於 [[:alnum:]_] or [A-z0-9_]
# \W: 非文字數字與底線，等於 [^A-z0-9_]
# [:blank:]: 空白字元，包括空白和tab
# \s: 空白字元, 
# \S: 非空白字元
# [:punct:]: 標點符號 ! " # $ % & ’ ( ) * + , - . / : ; < = > ? @ ^ _ ` { | } ~.

stringVector<-c("03-2118800","02-23123456","0988123456",
                "07-118","0-888","csim@mail.cgu.edu.tw","http://www.is.cgu.edu.tw/")
grep("\\d{2}-\\d{7,8}",stringVector,value=T)
## [1] "03-2118800"  "02-23123456"

grep("\\d{10}",stringVector,value=T)
## [1] "0988123456"

grep("\\w+@[a-zA-Z0-9._]+",stringVector,value=T)
## [1] "csim@mail.cgu.edu.tw"
