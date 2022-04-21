library(Seurat)
# The output of this function is a dataframe with genes as columns and cluster IDs
# as rows. This dataframe is populated with gene averages (means) for each cluster.
# There are examples at the bottom of this file to show how to use this function 
# as well as if you wanted to compute cluster averages for a different clustering.

average_by_cluster <- function(object, slot = "counts") {
  #grab the data from Seurat object and coerce it into a dataframe
  exprs <- as.data.frame(t(as.matrix(GetAssayData(object, slot = slot))))
  #split the count data into a list of dataframes for each cluster
  groups <- split(exprs, f = Idents(object)) 
  #create an empty group-means matrix to fill with group means
  group_means <- matrix(nrow = length(groups), ncol = ncol(exprs)) 
  colnames(group_means) <- colnames(exprs)
  #loop through the groups and calculate the colMeans (gene means), then add
  #it as a row in group_means
  for (i in 1:length(groups)){
    group_means[i,] <- colMeans(groups[[i]]) 
  }
  rownames(group_means) <- names(groups)
  group_means <- as.data.frame(group_means)
  return(group_means)
}


#example of how to use this function
data("pbmc_small")
group_means <- average_by_cluster(pbmc_small)

#example of if you wanted to choose a different factor to cluster by
data("pbmc_small")
Idents(pbmc_small) <- pbmc_small$groups
group_means <- average_by_cluster(pbmc_small)
