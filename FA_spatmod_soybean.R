rm(list=ls())
source('https://raw.githubusercontent.com/saulo-chaves/May_b_useful/main/fa.outs.R')
library(asreml)

# Data --------------------------------------------------------------------
data = read.csv("data/data_soy.csv")
str(data)

data = transform(data, 
                 gen = factor(gen),
                 block = factor(block),
                 env = factor(env),
                 row = factor(row),
                 col = factor(col))
data = data[order(data$env, data$row, data$col),]

# Models ------------------------------------------------------------------

asreml::asreml.options(pworkspace = '4Gb', workspace = '4Gb')

# FA 1
mod1 = asreml(fixed = yield ~ block:env + env + 
                at(env, c(1,2,3,4,8,9,10,11,15,18,20,23,
                          29,33,34,35,36,37,38,41,43,45,47,48,49)):lin(row),
              random = ~ at(env, c(6,31,38)):row + gen:fa(env, 1),
              data = data, maxit = 50, 
              na.action = na.method(x="include", y = "include"),
              residual = ~dsum(~id(row):id(col) + ar1(row):ar1(col)|env, 
                               levels=list(c(12,13,14,16,24,26,27,32,39,40,42,46),
                                           c(which(!1:nlevels(data$env) %in% 
                                                     c(12,13,14,16,24,26,27,32,39,40,42,46))))))


# FA 2
mod2 = asreml::asreml(fixed = yield ~ block:env + env + 
                at(env, c(1,2,3,4,8,9,10,11,15,18,20,23,
                          29,33,34,35,36,37,38,41,43,45,47,48,49)):lin(row),
              random = ~ at(env, c(6,31,38)):row +gen:fa(env, 2),
              data = data, maxit = 100, 
              na.action = na.method(x="include", y = "include"),
              residual = ~dsum(~id(row):id(col) + ar1(row):ar1(col)|env, 
                               levels=list(c(12,13,14,16,24,26,27,32,39,40,42,46),
                                           c(which(!1:nlevels(data$env) %in% 
                                                     c(12,13,14,16,24,26,27,32,39,40,42,46))))))

sum.mod2 = summary(mod2)$varcomp

# FA 3
initg<-sum.mod2[grep('fa',rownames(sum.mod2)),'component']
initgfa3<-c(initg, rep(0.2, nlevels(data$env)))

mod3 = asreml(fixed = yield ~ block:env + env + 
                at(env, c(1,2,3,4,8,9,10,11,15,18,20,23,
                          29,33,34,35,36,37,38,41,43,45,47,48,49)):lin(row),
              random = ~ at(env, c(6,31,38)):row +gen:fa(env, 3, init = initgfa3), 
              tol = c(6,6),
              data = data, maxit = 100, 
              na.action = na.method(x="include", y = "include"),
              residual = ~dsum(~id(row):id(col) + ar1(row):ar1(col)|env, 
                               levels=list(c(12,13,14,16,24,26,27,32,39,40,42,46),
                                           c(which(!1:nlevels(data$env) %in% 
                                                     c(12,13,14,16,24,26,27,32,39,40,42,46))))))

sum.mod3 = summary(mod3)$varcomp

# FA 4 
initg<-sum.mod3[grep('fa',rownames(sum.mod3)),'component']
initgfa4<-c(initg*.9, rep(0.1, nlevels(data$env)))

mod4 = asreml(fixed = yield ~ block:env + env + 
                at(env, c(1,2,3,4,8,9,10,11,15,18,20,23,
                          29,33,34,35,36,37,38,41,43,45,47,48,49)):lin(row),
              random = ~ at(env, c(6,31,38)):row +gen:fa(env, 4, init = initgfa4), 
              data = data, maxit = 500, 
              na.action = na.method(x="include", y = "include"),
              residual = ~dsum(~id(row):id(col) + ar1(row):ar1(col)|env, 
                               levels=list(c(12,13,14,16,24,26,27,32,39,40,42,46),
                                           c(which(!1:nlevels(data$env) %in% 
                                                     c(12,13,14,16,24,26,27,32,39,40,42,46))))))
