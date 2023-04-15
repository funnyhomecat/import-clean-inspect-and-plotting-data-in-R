# lab 1 assignemt
# 1. In this lab, you will be working with two datasets: hsbc_basic.csv and hsbc_health.txt — both
#originating from a survey dataset, HSBC, containing information about the health of sample of Swedish
#students in 2014. Your first task is to import them to R. Note that columns are separated by white
#space in hsbc_health.txt and by commas in hsbc_basic.csv (Hint 1: you may use read.table and
#read.csv to import .txt and .csv files respectively) (Hint 2: ensure that header=TRUE to keep column
#names). Assign the imported data to R objects with the same names as the file names, i.e. hsbc_basic
#and hsbc_health.
hsbc_basic <- read.csv(file ="C:/Users/46765/OneDrive/Desktop/statistic 2/lab lecture/hsbc-basic.csv", header = TRUE )
hsbc_health <- read.table(file = "C:/Users/46765/OneDrive/Desktop/statistic 2/lab lecture/hsbc-health.txt", header = TRUE)

#2.After importing, your next task is to present the following basic information about the two datasets
#a. The number of rows and columns
nrow(hsbc)
#b. The number of numeric, integer, character, and Factor variables.
str(hsbc_basic)
str(hsbc_health)

#3. Your task is now to perform an inner-join to merge the two datasets, using id4 as they key (Hint: use the merge() function).
hsbc <- merge(x = hsbc_basic, y = hsbc_health, by = "id4", all = FALSE)
head(hsbc, n = 5)

# report number of rows and columns in hsbc.
nrow(hsbc)
ncol(hsbc)

#Explain why it has the number of rows it has

#4. Next up is data cleaning! Specifically, you are to investigate whether there are any rows of hsbc that
#contain missing values. If you find such instances, state which column(s) that are affected, and then
#filter out the rows with missing data.
hsbc[!complete.cases(hsbc),]
hsbc <- hsbc[complete.cases(hsbc),]
nrow(hsbc)
head(hsbc,5)
#5.Once you have ensured that hsbc does not contain any missing values, your next task is to produce a
#set of variable-level summaries. Specficially, report:
#a. The average life satisfaction (lifesat). (Hint: use the mean() function)
#b. The total number of observations in each age-category (AGECAT). (Hint: use the table() function).Which age-category have the most observations?
mean(hsbc$lifesat)

table(hsbc$AGECAT)
# Answer:  15

#6.Building on 5b, examine which age-category (AGECAT) that have the highest recorded number of bullied
#  kids (bully_dummy==1). (Hint: you may again use the table() function).
table(hsbc$AGECAT, hsbc$bully_dummy ==1)
#Answer: 11 

#7.Next, you are to perform a counting exercise that involves both continuous and categorical variables
#  simultaneously. Use conditional subsetting to report the following 
#  a. How many bullied kids (bully_dummy==1) there are with a lifesat score lower than 7
nrow(hsbc[hsbc$lifesat < 7 & hsbc$bully_dummy == 1,])

#  b. How many girls (sex==Girl) there are in age-category 13 (AGECAT==13) that have a lifesat
#  score greater than 8.
nrow(hsbc[hsbc$lifesat > 8 & hsbc$AGECAT == 13 & hsbc$sex == "Girl",])


#8. Create a new column in hsbc that is set to 1 if health_index is greater than or equal to 7, and set to
#   0 otherwise. Call the new column health_index_binary. (Hint: use ifelse())
hsbc$health_index_binary <- ifelse(test = hsbc$health_index >= 7, yes =1, no = 0)
#for chek
head(hsbc, n=5)

#9. Compute the conditional mean of lifesat given the two different statuses of health_index_binary
#   (0/1). For which out of the two do you find the highest average life satisfaction? 
aggregate(x=hsbc$lifesat,by = list(hsbc$health_index_binary), FUN = mean)

#ansewr: 
#the health_index greater and equal than 7 shows higher average life satisfaction.

#10.Next up is plotting! As preliminaries, first, load the ggplot2 package. Second, format the variable
#   health_index_binary as a Factor (Hint: using the factor() function). The latter step is performed
#   to make ggplot2 aware that health_index_binary is a discrete variable, and not a continuous one.
library(ggplot2)
hsbc$health_index_binary <- factor(hsbc$health_index_binary,levels = c(1,2))

#11.Construct a density plot of lifesat (Hint: use geom_density()). How would you characterize its
#   distribution?
 ggplot(hsbc,aes(x= lifesat)) + geom_density()

 #answer: it seems following the normal distribution.
 
 #12. Extend the plot in 11 by colouring the distribution based on the membership to either of the
 #    health_index_binary categories (0/1).
ggplot(hsbc,aes(x= lifesat,fill = health_index_binary)) + 
         geom_density(color = "lightblue", alpha = 0.5)
#Interpret: As we can observe from plot picture, the health_index greater and equal than
# 7 which fill with pink shows higher life satisifaction than health_index lower than 7.

#13.As a final task, export hsbc to your hard-drive (where exactly, you decide). You may export it either
#as .txt or .csv.
write.csv(x= hsbc, file = "C:/Users/46765/OneDrive/Desktop/statistic 2/lab lecture/hsbc.csv",row.names= FALSE)
write.table(x= hsbc, file = "C:/Users/46765/OneDrive/Desktop/statistic 2/lab lecture/hsbc.txt",row.names= FALSE)



