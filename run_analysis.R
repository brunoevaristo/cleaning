# Reading files
training <- read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
ultimo <- ncol(training)
training[,ultimo + 1] <- read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
training[,ultimo + 2] <- read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

testing <- read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
testing[,ultimo + 1] <- read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
testing[,ultimo + 2] <- read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

aLabels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

# Renaming the feature names
features <- read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
features[,2] <- gsub('-mean', 'Mean', features[,2])
features[,2] <- gsub('-std', 'Std', features[,2])
features[,2] <- gsub('[-()]', '', features[,2])

# Merging training and testing sets together
dados <- rbind(training, testing)

# Get only the data on mean and standard deviation
colunas <- grep(".*Mean.*|.*Std.*", features[,2])

# First reduce the features table to what we want
features <- features[colunas,]

# Now add the last two columns (subject and activity)
colunas <- c(colunas, ultimo + 1, ultimo + 2)

# And remove the unwanted columns from dados
dados <- dados[,colunas]

# Add the column names (features) to dados
colnames(dados) <- c(features$V2, "Activity", "Subject")
colnames(dados) <- tolower(colnames(dados))

currentActivity = 1
for (currentActivityLabel in aLabels$V2) {
  dados$activity <- gsub(currentActivity, currentActivityLabel, dados$activity)
  currentActivity <- currentActivity + 1
}

dados$activity <- as.factor(dados$activity)
dados$subject <- as.factor(dados$subject)

tidy = aggregate(dados, by=list(activity = dados$activity, subject=dados$subject), mean)

# Remove the subject and activity column, since a mean of those has no use
ultimo2 <- ncol(dados)
tidy[,ultimo2+2] <- NULL
tidy[,ultimo2+1] <- NULL

# write the .txt file
write.table(tidy, "tidy_file.txt", sep="\t", row.name=FALSE)

