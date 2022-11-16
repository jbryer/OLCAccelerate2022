##### Math Anxiety Scale Survey ############################################
download_formative_results <- reactive({
	req(input$formative_semester)
	googlesheets4::read_sheet(formative_surveys[[input$formative_semester]])
})

get_formative_results <- reactive({
	form <- download_formative_results()
	return(form)
})

get_mass_results <- reactive({
	mass <- get_formative_results()
	n_items <- length(c(mass_items, familiarity_items))
	mass <- mass[,seq(ncol(mass) - n_items + 1, ncol(mass) - length(familiarity_items))]
	names(mass) <- mass_items
	return(mass)
})

get_familiarity_results <- reactive({
	familiar <- get_formative_results()
	familiar <- familiar[,seq(ncol(familiar) - length(familiarity_items) + 1, ncol(familiar))]
	names(familiar)[seq(ncol(familiar) - length(familiarity_items), ncol(familiar))] <- familiarity_items
	return(familiar)
})

output$formative_table <- DT::renderDataTable({
	form <- get_formative_results()
	form |>
		rename(Email = 'Your preferred email address:',
			   Name = 'Your Name',
			   Github = 'Your Github username:') |>
		select(!c(Email, Name, Github)) |>
		# mutate(Date = as.factor(as.character(Date)),
		#        Topic = as.factor(Topic)) |>
		datatable(options = list(pageLength = 50),
				  rownames = FALSE,
				  select = 'single',
				  filter = 'top')
})

output$mass_plot <- renderPlot({
	mass <- get_mass_results() |>
		as.data.frame(mass)
	for(i in seq_len(ncol(mass))) {
		mass[,i] <- factor(mass[,i],
						   levels = c('Strongly Disagree', 'Disagree',
						   		   'Neutral',
						   		   'Agree', 'Strongly Agree'),
						   ordered = TRUE)
	}
	likert(mass) |> plot()
})

output$familiarity_plot <- renderPlot({
	familiar <- get_familiarity_results() |>
		as.data.frame()
	for(i in seq_len(ncol(familiar))) {
		familiar[,i] <- factor(familiar[,i],
							   levels = c('Not at all familiar',
							   		   'Slightly familiar',
							   		   'Somewhat familiar',
							   		   'Moderately familiar',
							   		   'Extremely familiar'),
							   ordered = TRUE)
	}
	likert(familiar) |> plot()
})

output$formative_semester <- renderUI({
	shiny::selectInput('formative_semester',
					   label = 'Semester',
					   choices = names(formative_surveys))
})


##### One Minute Papers ####################################################
download_omp_results <- reactive({
	req(input$omp_semester)
	googlesheets4::read_sheet(one_minute_papers[[input$omp_semester]])
})

get_omp_results <- reactive({
	omp <- download_omp_results()
	req(input$omp_topic)
	if(input$omp_topic != 'All') {
		omp <- omp |> filter(Topic == input$omp_topic)
	}
	return(omp)
})

output$omp_semester <- renderUI({
	shiny::selectInput('omp_semester',
					   label = 'Semester',
					   choices = names(one_minute_papers))
})

output$omp_topic <- renderUI({
	omp <- download_omp_results()
	shiny::selectInput('omp_topic',
					   label = 'Topic',
					   choices = c('All', unique(omp$Topic)))
})

output$word_cloud_learned <- renderPlot({
	omp <- get_omp_results()
	ompWordCloud(omp[,'What was the most important thing you learned during this class?',drop=TRUE])
})

output$word_cloud_unanswered <- renderPlot({
	omp <- get_omp_results()
	ompWordCloud(omp[,'What important question remains unanswered for you?',drop=TRUE])
})

output$omp_table <- DT::renderDataTable({
	omp <- get_omp_results()
	omp |>
		rename(Email = 'Email Address',
			   Name = 'Your name:',
			   Date = 'Class Meetup Date') |>
		select(!c(Email, Name)) |>
		mutate(Date = as.factor(as.character(Date)),
			   Topic = as.factor(Topic)) |>
		datatable(options = list(pageLength = 50),
				  rownames = FALSE,
				  select = 'single',
				  filter = 'top')
})
