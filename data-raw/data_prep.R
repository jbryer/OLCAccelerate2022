library(tidyverse)

formative_results <- readRDS(file = 'data-raw/Formative_Results.rds')
one_minute_paper_results <- readRDS(file = 'data-raw/One_Minute_Papers_Results.rds')


mass_items <- c(
	'I find math interesting.',
	'I get uptight during math tests.',
	'I think that I will use math in the future.',
	'Mind goes blank and I am unable to think clearly when doing my math test.',
	'Math relates to my life.',	'I worry about my ability to solve math problems.',
	'I get a sinking feeling when I try to do math problems.',
	'I find math challenging.',
	'Mathematics makes me feel nervous.',
	'I would like to take more math classes.',
	'Mathematics makes me feel uneasy.',
	'Math is one of my favorite subjects.',
	'I enjoy learning with mathematics.',
	'Mathematics makes me feel confused.'
)

familiarity_items <- c(
	'Descriptive Statistics (e.g. mean, median, mode, standard deviation)',
	'Probability',	'Data visualizations (e.g. box plots, bar plots, histograms, scatter plots)',
	'Correlation',
	'Central Limit Theorem',
	'Null hypothesis testing',
	'ANOVA',
	'Chi-squared tests',
	'Type I and II errors',
	'Assumptions for regression',
	'Linear regression',
	'Multiple regression',
	'Logistic regression',
	'Predictive modeling',
	'SPSS',
	'R',
	'Python',
	'Derivatives',
	'Integrals',
	'Limits'
)

