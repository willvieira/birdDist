#Model Running subseting just sites with present birds
  #Script based in Pollock et al. (2014)

# Subset model because only for sites where at least one sp has been observed

#setting working directory
setwd(paste(getwd(), "/script/model", sep = ""))

#packages
packages.needed <- setdiff(c('R2jags', 'MASS', 'MCMCpack', 'abind', 'random', 'mclust'),rownames(installed.packages()))
if(length(packages.needed)) install.packages(packages.needed)

#data
setwd("/Users/wvieira/Documents/GitHub/birdDist/")
dat <- read.csv("data/birdDist/Bird_presence_absence.csv")
str(dat)

  #subseting data
sub.data <- dat[!(dat$MOCH == 0 & dat$MOBL == 0 & dat$LEWO == 0 & dat$BBWO == 0),]
str(sub.data)

  #matrix
#for the enviromental data, we are using just temp. and pres. (without landuse)
X <- as.matrix(sub.data[,c(4, 5, 11: 23)]) #enviromental data
str(X)
n_env_vars <- dim(X)[2] #number of enviromental variables

Occur <- as.matrix(sub.data[,c(7:10)]) #species
str(Occur)
n_species <- dim(Occur)[2]

#Running MCMC
#to run, n.chains, the number of iterations per chain, n.iter, how many samples to discard as
#burn-in, n.burn, and the factor to thin the post-burn-in samples by, n.thin.
n.chains <- 3
n.iter <- 1000
n.burn <- 50
n.thin <- 10

#Choose the degrees of freedom for the correlation matrix
# Important to remember that increasing the degrees of freedom is assigning greater weight,
# in the priors for the correlation coefficients,R on values closer to zero
df <- 1

#Choose the name for the model
model_name <- 'sim_model'

#Source the model
#The model estimates posterior distributions for four key parameters:
# - Rho (residual correlations between species)
# - EnvRho (correlations between species due to the environment)
# - Beta (regression coefficients)
# - Mu (predicted probability of occurrence at a site)
#These four objects will be loaded into the R workspace when the script has finished running.
setwd(paste(getwd(), "/script/model", sep = ""))
source("fit_JSDM.R")

#Running the model to mensure time consuming
setwd(paste(getwd(), "/script/model", sep = ""))
library(profvis)
p <- profvis({
sim1 <- source("fit_JSDM.R")
})
#save time results as html
htmlwidgets::saveWidget(p, "profile.html")

# Open time results in browser from R
browseURL("profile.html")
