# importing dataset
animeDataset <- read.csv(file="https://raw.githubusercontent.com/SpdPnd98/AnimeDatasetAnalysis/master/anime.csv", header=TRUE, sep=",") # this my github follow me eksdee

# migrate datapreprocessing here
animeDataset <- animeDataset[complete.cases(animeDataset),]
animeDataset <- animeDataset[!(animeDataset$episodes=="Unknown"),]
animeDataset <- animeDataset[!(animeDataset$type==""),]
animeDataset <- animeDataset[!(animeDataset$genre==""),]
write.csv(animeDataset, file="cleanDataset.csv")
animeDataset <- read.csv(file="cleanDataset.csv")

# observing dataset to ensure dataset was imported
head(animeDataset)

#split the dataset as a train test split of 9:1, then split train into train and validation of ratio 8:2

#define sample size
sampleSize <- floor(0.9*nrow(animeDataset))

#fix randomness
set.seed(123)
# remove empty cells
animeDataset <- na.omit(animeDataset)
trainIndex <- sample(seq_len(nrow(animeDataset)), size = sampleSize)

#train test datasets
combinedDataset <- animeDataset[trainIndex, ]
testDataset <- animeDataset[-trainIndex, ]

#splitting validation from train dataset
sampleSize <- floor(0.2*nrow(combinedDataset))
validationIndex <- sample(seq_len(nrow(combinedDataset)), size = sampleSize)
validationDataset <- combinedDataset[validationIndex,]
trainDataset <- combinedDataset[-validationIndex,]

#save datasets
write.csv(trainDataset, file="trainDataset.csv")
write.csv(validationDataset, file="validationDataset.csv")
write.csv(testDataset, file="testDataset.csv")

trainDatasetList <- split(trainDataset, trainDataset$type)
stratifyClass <- names(trainDatasetList)
stratifyClass <- stratifyClass[-1]

for (subclass in stratifyClass){
    write.csv(trainDatasetList[[subclass]], file=paste("subclasses/",subclass,".csv", sep=""))
}