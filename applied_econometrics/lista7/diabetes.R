# instala pacotes
#install.packages("ggplot2")
#install.packages("MASS")

# importa pacotes
library(ggplot2)
library(MASS)

# load data
train_df <- rbind(Pima.tr, Pima.tr2)
test_df <- Pima.te

# first look at the data
head(train_df)
head(test_df)

# descriptive statistics
summary(train_df) #train_df tem valores nulos
summary(test_df) #test_df não tem valores nulos

# initial data adjustments
train_df$type <- as.integer(train_df$type) - 1L
test_df$type <- as.integer(test_df$type) - 1L

# verifying adjustments
head(train_df)
head(test_df)

# verifying amount of cases for train and test datasets
# check if they're balanced or unbalanced
    # they're balanced
sum(train_df$type) / (nrow(train_df) * 1.0)
sum(test_df$type) / (nrow(test_df) * 1.0)

# verify missing data on train and test
    # there's missing data in the train
sapply(train_df, function(x) sum(is.na(x)))
sapply(test_df, function(x) sum(is.na(x)))

# plotting all columns for train data
    # I don't know how to interpret this output yet!
#pairs(subset(train_df, select = -c(type)),
#      col = as.factor(train_df$type))

# null data handling
    # remove NA for now, think on a better method afterwards
#train_df_comp <- na.omit(train_df) #drop nulls
train_df_comp <- data.frame(train_df)

### substitute null values with mean
#NA2mean <- function(x) replace(x, is.na(x), mean(x, na.rm = TRUE))
#train_df_comp[] <- lapply(train_df_comp, NA2mean)

sapply(train_df_comp, function(x) sum(is.na(x))) #verifying

# exercise 1 (DONE!)
### fit logit model
lg_skin_only <- glm(type ~ skin, data = train_df_comp, family = binomial())
summary(lg_skin_only)
### resposta: sim, skin tem impacto positivo (devido ao valor do coeficiente 
###   de 0.04624) com significância estatística menor que 1% 
###   (Pr(>|z|) = 5.89e-06)

# exercise 2 (DONE!)
lg_skin_bmi_age <- glm(type ~ skin + bmi + age, data = train_df_comp, family = binomial())
summary(lg_skin_bmi_age)
### resposta: não, skin tem impacto negativo (devido ao valor do coeficiente 
###   de -0.0009408) e não possui significância estatística (Pr(>|z|) = 0.946)

# exercise 3 (DONE!)
lg_bmi_age <- glm(type ~ bmi + age, 
                       data = train_df_comp, 
                       family = binomial())
summary(lg_bmi_age)
### predict probability
predict(lg_bmi_age, type="response", newdata = data.frame(bmi = 31, age = 60))

# exercise 4 (DONE!)
exp(coef(lg_bmi_age))

# exercise 5 (DONE!)
lg_bmi_age_npreg <- glm(type ~ bmi + age + npreg, 
                  data = train_df_comp, 
                  family = binomial())
summary(lg_bmi_age_npreg)
### predict probability
predict(lg_bmi_age_npreg, type="response", newdata = data.frame(bmi = 26, 
                                                                age = 45,
                                                                npreg = 2))

# exercise 6 (DONE!)
exp(coef(lg_bmi_age_npreg))
