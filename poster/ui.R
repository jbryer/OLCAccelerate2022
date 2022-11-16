shinyUI(navbarPage(
	id = 'shiny_poster',
	header = '',
	position = 'static-top',
	windowTitle = poster_title,
	title = navbar_title,
	tabPanel(
        'Overview',
        fluidRow( # Title and Authors
        	style = 'position: relative; top: -15px;',
        	column(
        		width = 12,
        		div(style = 'font-size: 26px; padding-bottom: 10px;',
        			align = 'center',
        			poster_title
        		),
        		div(align = 'center',
        			style = 'padding-bottom: 5px',
        			poster_authors
        		)
        	)
        ),
        fluidRow( # Row 1 (three column layout)
        	column( # Column 1
        		width = 4,
        		style='padding:0px;',
	        	box(title = 'Abstract',
	        		width = 12,
	        		includeMarkdown('docs/abstract.md')
	        	),
        		box(title = 'Goals',
        			width = 12,
        			includeMarkdown('docs/goals.md')
        		),
        		box(title = 'Technical Details',
        			width = 12,
        			includeMarkdown('docs/method.md')
        		)
        	),
        	column( # Column 2
        		width = 4,
        		style='padding:0px;',
        		box(title = 'Formative Assessments',
        			width = 12,
        			includeMarkdown('docs/formative.md')
        		),
        		box(title = 'One Minute Paper',
        			width = 12,
        			includeMarkdown('docs/omp.md')
        		)
        	),
        	column( # Column 3
        		width = 4,
        		style='padding:0px;',
				box(title = 'Math Anxiety Survey Scale',
					width = 12,
					plotOutput('mass_figure', height = '275px')
				),
				box(title = 'One Minute Papers',
					width = 12,
					tabsetPanel(
						tabPanel(
							'1. Important',
							h5('What was the most important thing you learned during this class?'),
							plotOutput('omp_figure1', height = '275px')
						),
						tabPanel(
							'2. Questions',
							h5('What important question remains unanswered for you?'),
							plotOutput('omp_figure2', height = '275px')
						)
					)
				)
        	)
        ),
        # fluidRow( # Row 2 (two column layout)
        # 	column( # Column 1
        # 		width = 6,
        # 		style='padding:0px;',
        # 		box(title = 'Pairs Plot',
        # 			width = 12,
        # 			plotOutput('figure1', height = '400px')
        # 		)
        # 	),
        # 	column( # Column 2
        # 		width = 6,
        # 		style='padding:0px;',
        # 		box(title = 'Regression Output',
        # 			width = 12,
        # 			# plotOutput('figure2', height = '400px'))
        # 			verbatimTextOutput('lm_summary')
        # 		)
        # 	)
        # ),
        ##### Added Web Dependencies #############################################
        # Note that these need to be present within a tabPanel so to not create
        # an empty tab that is clickable and therefore blank.
        useShinydashboard(),
        shinyjs::inlineCSS(".navbar .navbar-default .navbar-static-top {margin-bottom: 0px}"),
        fullscreen_all(click_id = "page_full"),
        ##### Set Background Color
        tags$head(
        	tags$script("Shiny.addCustomMessageHandler('background-color', function(color) {
        document.body.style.backgroundColor = color; });
		")
        ),
        ##### Full Screen Button
        tags$script(
        	HTML("var header = $('.navbar > .container-fluid');
                              header.append('<div style=\"float:right; padding-top: 8px\"><button id=\"page_full\" type=\"button\" class=\"btn btn-outline-primary action-button\" onclick=\"page_full()\">View Full Screen</button></div>')")
        )
        ##### End Web Dependencies #############################################
	),
	##### Demographics Tab #####################################################
	tabPanel(
		'Math Anxiety',
		fluidRow(
			column(4, uiOutput('formative_semester'))
			# column(4, uiOutput('omp_topic'))
		),
		tabsetPanel(
			tabPanel('Math Anxiety',
					 plotOutput('mass_plot', height = '700px')),
			tabPanel('Familarity',
					 plotOutput('familiarity_plot', height = '700px')),
			tabPanel('Table',
					 DT::dataTableOutput('formative_table'))
		)

	),
	tabPanel(
		'One Minute Paper',
		fluidRow(
			column(4, uiOutput('omp_semester')),
			column(4, uiOutput('omp_topic'))
		),
		tabsetPanel(
			tabPanel('Word Cloud',
					 fluidRow(
					 	column(6,
					 		   h4('What was the most important thing you learned during this class?'),
					 		   plotOutput('word_cloud_learned', height = '700px')),
					 	column(6,
					 		   h4('What important question remains unanswered for you?'),
					 		   plotOutput('word_cloud_unanswered', height = '700px'))
					 )
			),
			tabPanel('Table',
					 DT::dataTableOutput('omp_table'))
		)
	),
    ##### Paper / About Tab ####################################################
    tabPanel(
        'Extended Abstract',
        includeMarkdown('docs/paper.md')
    ),
))
