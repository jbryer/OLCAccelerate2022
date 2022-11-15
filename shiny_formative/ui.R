shinyUI(navbarPage(
    title = 'Formative Assessments',
    tabPanel(
        'Math Anxiety',
        fluidRow(
            column(4, uiOutput('formative_semester'))
            # column(4, uiOutput('omp_topic'))
        ),
        tabsetPanel(
            tabPanel('Math Anxiety',
                     plotOutput('mass_plot')),
            tabPanel('Familarity',
                     plotOutput('familiarity_plot')),
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
                                plotOutput('word_cloud_learned')),
                         column(6,
                                h4('What important question remains unanswered for you?'),
                                plotOutput('word_cloud_unanswered'))
                        )
            ),
            tabPanel('Table',
                     DT::dataTableOutput('omp_table'))
        )
    )
))
