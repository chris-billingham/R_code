library(rvest)
library(stringr)
library(dplyr)
#install.packages('wordcloud2')
library(wordcloud2)
library(ggplot2)

getwd()
# 指定需要抓取的URL
url <- 'https://zhuanlan.zhihu.com/p/22561617'

# 读取网页内容
page <- html_session(url)
# 获取电影的链接
movie_url <- html_nodes(page, 'p>a') %>% html_attr("href")
movie_url <- sapply(str_match_all(movie_url, '\\\\"(.*?)\\\\"'),'[',2)
# 获取电影名称
movie_name <- html_nodes(page, 'p>a') %>% html_text()
# 获取电影的其他描述信息
describe <- html_nodes(page, 'p') %>% html_text()
# 筛选出需要的子集
describe <- describe[16:443]
# 通过正则表达式匹配评分
score <- as.numeric(str_match(describe, '.* (.*?)分')[,2])
# 通过正则表达式匹配评价人数
evalue_users <- as.numeric(str_match(describe, '分 (.*?)人评价')[,2])
# 通过正则表达式匹配电影年份
year <- as.numeric(str_match(describe, '评价 (.*?) /')[,2])

# 由于生产国和电影类型用/分割，且没有固定的规律，故将生产国和电影类型存入到一个变量中
other <- sapply(str_split(describe, '/', n = 2),'[',2)
# 构建数据框
raw_data <- data.frame(movie_name, movie_url,score,evalue_users,year,other)
head(raw_data)
# 将抓取的数据写出到本地
write.csv(raw_data, 'movies.csv', row.names = FALSE)


# 数据处理
# 需要将电影的其他描述信息进行拆分
# 前往搜狗官网，下载所有国家名称的字典，再利用“深蓝词库转换”工具，将scel格式的字典转换成txt
# http://pinyin.sogou.com/dict/detail/index/12347
countrys <- readLines(file.choose())
# 把数据集中的other变量进行切割
cut_other <- str_split(raw_data$other, '/')
head(cut_other)
# 删除所有空字符串
cut_other <- sapply(cut_other, function(x) x[x != " "])
# 剔除字符串中的收尾空格
cut_other <- sapply(cut_other, str_trim)
head(cut_other)
# 提取出所有关于电影所属国家的信息
movie_country <- sapply(cut_other, function(x,y) x[x %in% y], countrys)
head(movie_country)
# 提取出所有关于电影所属类型的信息
movie_type <- sapply(cut_other, function(x,y) x[!x %in% y], countrys)
head(movie_type)

# 数据分析
# 1、参评人数最多的Top10的电影
# 配置画图的数据
p <- ggplot(data = arrange(raw_data, desc(evalue_users))[1:10,], 
            mapping = aes(x = reorder(movie_name,-evalue_users), 
                          y = evalue_users)) + 
# 限制y周的显示范围
  coord_cartesian(ylim = c(500000, 750000)) + 
# 格式化y轴标签的数值
  scale_y_continuous(breaks = seq(500000, 750000, 100000),
                     labels = paste0(round(seq(500000, 750000, 100000)/10000, 2), 'W')) + 
# 绘制条形图
  geom_bar(stat = 'identity', fill = 'steelblue') +
# 添加轴标签和标题
  labs(x = NULL, y = '评价人数', title = '评价人数最多的top10电影') + 
# 设置x轴标签以60度倾斜
  theme(axis.text.x = element_text(angle = 60, vjust = 0.5),
        plot.title = element_text(hjust = 0.5, colour = 'brown', face = 'bold'))

p

# 2、一部经典的电影需要多少国家或地区合拍
# 统计每一部电影合拍的国家数
movie_contain_countrys <- sapply(movie_country, length)
table(movie_contain_countrys)
# 由于电影的制作包含5个国家及以上的分别只有1部电影，故将5个国家及以上的当做1组
# 转化为数据框
df <- as.data.frame(table(movie_contain_countrys))
# 数据框变量的重命名
names(df)[1] <- 'countries'
# 数据类型转换
df$countries <- as.numeric(as.character(df$countries))
df$countries <- ifelse(df$countries<=4, df$countries, '5+')
# 聚合操作
groupby_countrys <- group_by(df, countries)
df <- summarise(groupby_countrys, Freq = sum(Freq))
# 数据类型转换，便于后面可视化
df$countries <- factor(df$countries)
df

# 运用环形图对上面的数据进行可视化
# 定义数据，用于画图
df$ymax <- cumsum(df$Freq)
df$ymin <- c(0, cumsum(df$Freq)[-length(df$ymax)])
# 生成图例标签
labels <- paste0(df$countries,'(',round(df$Freq/sum(df$Freq)*100,2),'%',')')
# 绘图
p <- ggplot(data = df, mapping = aes(xmin = 3, xmax = 4, ymin = ymin, 
                                     ymax = ymax, fill = countries)) + 
# 矩形几何图
  geom_rect(size = 5) + 
# 极坐标变换
  coord_polar(theta = 'y') + 
  # 环形图
  xlim(1,4) + 
  # 添加标题
  labs(x = NULL, y =NULL, title = '一部电影需要多少国家合作') + 
  # 设置图例
  scale_fill_discrete(breaks = df$countries, labels = labels) + 
  theme(legend.position = 'right', 
        plot.title = element_text(hjust = 0.5, colour = 'brown', face = 'bold'),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        panel.background = element_blank()
        )
p


# 3、经典电影产量top10都是哪些国家
# 罗列出所有电影的拍摄国家
top_countris <- unlist(movie_country)
# 频数统计，并构造数据框
df <- as.data.frame(table(top_countris))
# 降序排序
df <- arrange(df, desc(Freq))
df
# 香港，中国大陆和台湾入围前十，分别是第5，第7和第10名。前三的归美国，英国和日本。美国绝对是量产的国家，远远超过第二名的英国。
# 运用文字云对上面的数据进行可视化
wordcloud2(df, backgroundColor = 'black', rotateRatio = 2)

# 4、这些经典电影主要都是属于什么类型
# 罗列出所有电影的类型
top_type <- unlist(movie_type)
# 构造数据框
df <- as.data.frame(table(top_type))
# 降序排序
df <- arrange(df, desc(Freq))
df
# 由于几乎所有的电影都贴上剧情这个标签，我们暂不考虑这个类型，看看其他的类型top15分布
# 去除第一行的（剧情）类型
df <- df[-1,]
df$top_type <- as.character(df$top_type)
# 我们使用条形图来反馈上面的数据情况
# 提取出前15的类型
df$top_type <- ifelse(df$top_type %in% df$top_type[1:15], df$top_type, '其他')
# 数据聚合
groupby_top_type <- group_by(df, top_type)
df <- summarise(groupby_top_type, Freq = sum(Freq))
# 排序
df <- arrange(df, desc(Freq))
# 构造数值标签
labels <- paste(round(df$Freq/sum(df$Freq)*100,2),'%')
p <- ggplot(data = df, mapping = aes(x = reorder(df$top_type, Freq), y = Freq)) +
# 绘制条形图
  geom_bar(stat = 'identity', fill = 'steelblue') + 
# 添加文字标签
  geom_text(aes(label = labels), size = 3, colour = 'black', 
            position = position_stack(vjust = 0.5), angle = 30) + 
# 添加轴标签
  labs(x = '电影类型', y = '电影数量', title = 'top15的电影类型') + 
# 重组x轴的标签
  scale_x_discrete(limits = c(df$top_type[df$top_type!='其他'],'其他')) +
# 主题设置
  theme(plot.title = element_text(hjust = 0.5, colour = 'brown', face = 'bold'),
        panel.background = element_blank())
p
# 前三名的电影类型分别为爱情、喜剧和犯罪

# 5、哪些年代的电影好评度比较高
# 根据年份的倒数第二位，判读所属年代
raw_data$yearS <- paste0(str_sub(raw_data$year,3,3),'0','S')
# 对年代聚合
groupbyYS <- group_by(raw_data, yearS)
yearS_movies <- summarise(groupbyYS, counts = n())
# 绘图
p <- ggplot(data = yearS_movies, 
            mapping = aes(x = reorder(yearS, -counts), 
                          y = counts)) +
# 绘制条形图
  geom_bar(stat = 'identity', fill = 'steelblue') + 
# 添加轴标签和标题
  labs(x = '年代', y = '电影数量', title = '各年代的好评电影数量') + 
# 主题设置
  theme(plot.title = element_text(hjust = 0.5, colour = 'brown', face = 'bold'),
        panel.background = element_blank())
p

# 6、评分top5的电影类型
# 所有电影类型
types <- unique(unlist(movie_type))
# 定义空的数据框对象
df = data.frame()
# 通过循环，抓取出不同标签所对应的电影评分
for (type in types){
  res = sapply(movie_type, function(x) x == type)
  index = which(sapply(res, any) == 1)
  df = rbind(df,data.frame(type,score = raw_data[index, 'score']))
}
# 按电影所属类型，进行summary操作
type_score <- aggregate(df$score, by = list(df$type), summary)
# 数据集进行横向拼接为数据框
type_score <- cbind(Group = type_score$Group.1, as.data.frame(type_score$x))
# 按平均得分排序
type_score <- arrange(type_score, desc(Mean))
type_score
# 单从电影类型的平均得分来看，灾难片、恐怖片和儿童片位居前三，尽管分别只有3部，2部和12部。


# 7、评论人数和评分之间的关系
p <- ggplot(data = raw_data, mapping = aes(x = evalue_users, y = score)) + 
# 绘制散点图
  geom_point(colour = 'steelblue') + 
# 添加一元线性回归拟合线
  geom_smooth(method = 'lm', colour = 'red') + 
# 添加轴标签和标题
  labs(x = '评论人数', y = '评分', title = '评论人数与评分的关系') + 
# 设置x轴的标签格式
  scale_x_continuous(breaks = seq(30000, 750000, 100000),
                     labels = paste0(round(seq(30000, 750000, 100000)/10000, 2), 'W')) + 
  scale_y_continuous(breaks = seq(8, 9.6, 0.2)) + 
# 主题设置
  theme(plot.title = element_text(hjust = 0.5, colour = 'brown', face = 'bold'))
p  