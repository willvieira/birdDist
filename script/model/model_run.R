#Model Running
  #Script based in Pollock et al. (2014)

#setting working directory
#setwd("C:/Users/kvieka/Documents/GitHub/birdDist")
setwd(paste(getwd(), "/script/model", sep = ""))


#packages
packages.needed <- setdiff(c('R2jags', 'MASS', 'MCMCpack', 'abind', 'random', 'mclust'),rownames(installed.packages()))
if(length(packages.needed)) install.packages(packages.needed)

#Simulating enviromental data
#2 environmental variables and 500 sites
n_env_vars <- 2
n_sites <- 3404
X <- matrix(rnorm(n_sites * n_env_vars), ncol=n_env_vars)
head(X)

#Simulating matrix of species response to environmental data (8 species)
# Coef will have 3 colums, the first column of the matrix coefs are the species intercept terms
# that will influence the prevalence of each species. The other two are the variables
n_species <- 4
coefs <- matrix(runif(n_species * (n_env_vars + 1), -1, 1), ncol=n_env_vars + 1)
coefs

#Get the matrix of occurance (presence/absence) data for each of the 500 sites
#as a function of the environmental data and matrix of regression coefficients
Occur <- apply(pnorm(cbind(1, X) %*% t(coefs)), 1:2, function(x) rbinom(1, 1, x))
head(Occur)

#Running MCMC
#to run, n.chains, the number of iterations per chain, n.iter, how many samples to discard as
#burn-in, n.burn, and the factor to thin the post-burn-in samples by, n.thin.
n.chains <- 5
n.iter <- 150000
n.burn <- 110000
n.thin <- 40

#Choose the degrees of freedom for the correlation matrix
# Important to remember that increasing the degrees of freedom is assigning greater weight,
# in the priors for the correlation coefficients, on values closer to zero
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
source("fit_JSDM.R")

#Running the model to mensure time consuming
library(profvis)
p <- profvis({
source("fit_JSDM.R")
})
#save time results as html
htmlwidgets::saveWidget(p, "profile.html")

# Open time results in browser from R
browseURL("profile.html")
