###############################################################
## Getting and Cleaning Data Course Project
## Ricardo Araujo
## 09-20-17
###############################################################



setwd('./data')

# start with the training files, renaming columns to make sense

x_train <- read.table('./train/X_train.txt')

subject_train <- read.table('./train/subject_train.txt')
names(subject_train)[1] <- 'subject'

label_train <- read.table('./train/y_train.txt')
names(label_train)[1] <- 'activity'
head(label_train)

# now the test files

x_test <- read.table('./test/X_test.txt')

subject_test <- read.table('./test/subject_test.txt')
names(subject_test)[1] <- 'subject'

label_test <- read.table('./test/y_test.txt')
names(label_test)[1] <- 'activity'
head(label_test)

# concatenate the train and test files

ttrain <- cbind(subject_train, label_train, x_train)
ttest <- cbind(subject_test, label_test, x_test)

# test the combination of the two files
a <- nrow(ttrain)
b <- nrow(ttest)
a
b
c <- a + b
c

# merge the files into one
dat <- rbind(ttrain, ttest)

#test the results
nrow(dat) # should equal the value of 'c'

# create a vector of column means
average_value <- apply(dat[3:563], 2, mean) 

#create a vector of column sd
standard_deviation <- apply(dat[3:563], 2, sd) 

# combine them
aggstats <- cbind(average_value, standard_deviation) 

# review a few records
head(aggstats, 10) 

# make sure of the column name for activities
names(dat[1:2])

dat$activity[which(dat$activity == 1)] <- 'Walking'
dat$activity[which(dat$activity == 2)] <- 'Walking upstairs'
dat$activity[which(dat$activity == 3)] <- 'Walking downstairs'
dat$activity[which(dat$activity == 4)] <- 'Sitting'
dat$activity[which(dat$activity == 5)] <- 'Standing'
dat$activity[which(dat$activity == 6)] <- 'Laying'

# Check a few records
head(dat$activity, 200)

# create column labels
features <- read.table('features.txt')
features$V1 <- NULL

# Assign each row name from the 'features' data frame to the appropriate column
# in the 'dat' data frame

m <- 1
n <- m + 2

while (m < 564) {
        ren <- features[m,]
        colnames(dat)[n] <- paste(ren)
        m = m + 1
        n = n + 1
}

# Take a look at a few records
head(dat[1:100])

# initialize a temporary data frame
sumdata <- aggregate(dat[,3] ~ subject + activity, data = dat, FUN = 'mean')

#calculate the means for each column
for (i in 4:ncol(dat)) {
        sumdata[,i] <- aggregate(dat[,i] ~ subject + activity, data = dat, FUN = 'mean')[,3]
}

# renames the columns to the descriptive name
colnames(sumdata) <- colnames(dat)


#review a few records
head(sumdata)

# go to the main data directory, and write the new tidy data file
setwd('..')
getwd()
write.table(sumdata, 'tidydata.txt')