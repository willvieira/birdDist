
# results

#setwd("/Users/wvieira/Documents/GitHub/birdDist/results/")
setwd("C:/Users/kvieka/Documents/NIBIO/kurs/EcologicalDatasynthesis/JSDM_course_project/results")
model <- load("sim1.Rdata")

library(lattice)

Diagnose(Beta, 'rhat')
Diagnose(Beta, 'effn')
TPLOT(Beta, 2, 2)
TPLOT(Rho, 1, 2)
DPLOT(Beta, 2, 2)
SUMMARY(Beta, mean)
SUMMARY(Beta, sd)
SUMMARY(EnvRho, mean)
SUMMARY(EnvRho, sd)
SUMMARY(Rho, mean)
SUMMARY(Rho, sd)

#save results
sim1 <- list(Beta, Rho, EnvRho, Mu)

save(sim1, file = "sim1")
