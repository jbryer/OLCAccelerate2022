library(shiny)
library(googlesheets4)
library(DT)
library(likert)

# See setup.R for creating the .secrets folder.
gs4_auth(cache = '.secrets', email = "jason.bryer@gmail.com")

# URLs for the formative assessments (i.e. Google Sheets created from the Google Forms)
# The names will be used in the selection box.
formative_surveys <- c(
	DATA606_Fall2022 = "https://docs.google.com/spreadsheets/d/1mb2uPbZto0Bff0fF8PJksruqrVhrSRYQ9qTE28mGaz4/edit?resourcekey#gid=1727977695",
	DATA606_Spring2022 = "https://docs.google.com/spreadsheets/d/1Ig9qdkV_SnJutSqR_87vOdHiw5rr0nhE0ao1MKft3Uo/edit?resourcekey#gid=1675807648",
	DATA606_Fall2021 = "https://docs.google.com/spreadsheets/d/1cYsAX67q-sJ0ROu-XwoV3l5MO6YK2jT7I0SFBSaYfC8/edit?resourcekey#gid=1535188505",
	DATA606_Spring2021 = "https://docs.google.com/spreadsheets/d/1YsJCWxl0LEnk7yvaBIwPkaqqvmJwxnii4zWZpQMHVDY/edit?resourcekey#gid=233586613",
	EPSY630_Spring2021 = "https://docs.google.com/spreadsheets/d/1HfAFxvGex_33GxKtIjJBdxDP2KVFjCAsIYhe6cTWlT4/edit?resourcekey#gid=1826761801"
)

# URLs for the one minute papers (i.e. Google Sheets created from the Google Forms)
# The names will be used in the selection box.
one_minute_papers <- c(
	DATA606_Fall2022 = "https://docs.google.com/spreadsheets/d/1gsID5ZR6nC1M6HFBl40Q3UikphHBTomqF-Dt1FL-jj4/edit?resourcekey#gid=1183513938",
	DATA606_Spring2022 = "https://docs.google.com/spreadsheets/d/1QZkU6Skdjm3TDBTf1I_R-qWIP2ZCRbkvc6dO3pGxVf4/edit?resourcekey#gid=1920899805",
	DATA606_Fall2021 = "https://docs.google.com/spreadsheets/d/1mhAT8YeBQek1r7tqz0j96-fYhU3arZwpVw623RjlaBs/edit?resourcekey#gid=1608172812",
	DATA606_Spring2021 = "https://docs.google.com/spreadsheets/d/1vMgo-BhGiSF1DTpf9IbjKdekyAZsslFUV5xzUN7O6pg/edit?resourcekey#gid=965448308",
	EPSY630_Spring2021 = "https://docs.google.com/spreadsheets/d/19GAXKkE7VikWAypnNrVPnKfyCWDp27vwOwSD54Czvf0/edit?resourcekey#gid=1204644888"
)

# Stems for the Math Anxiety Scale Survey
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

# Stems for the familarity items
familiarity_items <- c(
	'Descriptive Statistics',
	'Probability',
	'Data visualizations',
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

