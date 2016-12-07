#========================
# PCA Budget France
#========================
# 

# 1. Load the data set
Budget = read.table("Budget.txt", sep=',')
head(Budget)

rownames(Budget) = Budget$AN

colnames(Budget) = c("AN", "PVP", "AGR", "CMI", "TRA", "LOG", "EDU", "ACS", "ANC", "DEF", "DET", "DIV")

#Omit the years since its not a variable
Budget=Budget[,-1]

# 2. Scale and Center data set
Budget.scaled <- scale(Budget, center = TRUE, scale = TRUE) #=> since center = TRUE, scale = TRUE: scaling is done by dividing the (centered) columns of x by their standard deviations

# 3. Building the Correlation matrix
res.cor <- cor(Budget.scaled)

# 4. Calculation of eigenvectors/eigenvalues
res.eig <- eigen(res.cor)

# 5. compute the new dataset :

# Transpose eigenvectors
eigenvectors.t <- t(res.eig$vectors)
# Transpose the adjusted data
Budget.scaled.t <- t(Budget.scaled)
# Set new dataset, transpose it and rename columns
Budget.new <- t(eigenvectors.t %*% Budget.scaled.t)

# Set new PC Column names
colnames(Budget.new) <- c("PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7", "PC8","PC9", "PC10", "PC11")
head(Budget.new)

#couldnt figure out what following means: 
#a.	Cos2 to check whether data is well represented
# Maybe with package factoextra and functions fviz_contrib(), fviz_ca_row() or get_ca_row():
#row$cos2
#col$cos2

#b.	Plot (Zi,Zj)
#c.	Variables against Zi,Zj
