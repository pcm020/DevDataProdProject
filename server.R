library(shiny)
library(reshape2)
suppressPackageStartupMessages(library(googleVis))

#Data transformation for DevDataProds Course Project
dat <- read.csv("data/turismo_01.csv", skip=2, header=FALSE, stringsAsFactors=FALSE, 
                strip.white = TRUE, na.strings = ".")

#Add months
last <- NULL
for(i in seq(along=dat[1,])) {
    if (is.na(dat[1,i]) || dat[1,i]=="" ) {
        dat[1,i] <- last
    } else {
        last <- dat[1,i] 
    }
}

#rotate data
dat2 <- as.data.frame(t(dat), stringsAsFactors=FALSE)
dat3 <- data.frame(dat2[,1:2],dat2[,5:13], stringsAsFactors=FALSE)
colnames(dat3) <- dat3[1, ]
dat3 <- dat3[-1, ]
dat3 <- dat3[1:dim(dat3)[1]-1, ]

#SUM Region
dat3[, 3:11] <- sapply(dat3[, 3:11], as.numeric)
dat3["CASTILLA_LEON"] <-  rowSums(dat3[, 3:11], na.rm = TRUE)

#translate to english
colnames(dat3)[1] <- "MONTH"
colnames(dat3)[2] <- "CATEGORY"
dat3$CATEGORY <- sub("AGENCIAS DE VIAJE", "TRAVEL AGENCIES", dat3$CATEGORY)
dat3$CATEGORY <- sub("ALOJAMIENTOS DE TURISMO RURAL", "RURAL TOURISM", dat3$CATEGORY)
dat3$CATEGORY <- sub("ALOJAMIENTOS HOTELEROS", "HOTELS", dat3$CATEGORY)
dat3$CATEGORY <- sub("APARTAMENTOS TURISTICOS", "TOURIST APARTMENTS", dat3$CATEGORY)
dat3$CATEGORY <- sub("CAFETERIAS", "CAFE", dat3$CATEGORY)
dat3$CATEGORY <- sub("CAMPAMENTOS TURISTICOS", "TOURIST CAMPS", dat3$CATEGORY)
dat3$CATEGORY <- sub("EMPRESAS NO REGLAMENTADAS", "OTHERS", dat3$CATEGORY)
dat3$CATEGORY <- sub("RESTAURANTES", "RESTAURANT", dat3$CATEGORY)
dat3$CATEGORY <- sub("TURISMO ACTIVO", "ACTIVE TOURISM", dat3$CATEGORY)
dat3$CATEGORY <- sapply(dat3$CATEGORY, as.factor)

#datMelt <- melt(dat3,id=c("MONTH","CATEGORY"),measure.vars=c("AVILA", "BURGOS", "LEON",         
#                                                             "PALENCIA", "SALAMANCA", "SEGOVIA", "SORIA", "VALLADOLID", "ZAMORA",
#                                                             "CASTILLA_LEON"))
#datMelt$variable <- sub("VALLADOLID", "ES-EX", datMelt$variable)                               
shinyServer(
  function(input, output) {
      #datFilter <- reactive({datMelt[datMelt$CATEGORY %in% "RESTAURANT"
      #                               & datMelt$MONTH %in% "12-2000",]})
      output$map <-  renderGvis({
          #datFilter <- datMelt[datMelt$CATEGORY %in% input$category,]
          #datFilter <- datMelt[datMelt$CATEGORY %in% input$category
          #                     & datMelt$MONTH %in% input$month,]
          dat3Filter <- dat3[dat3$CATEGORY %in% input$category
                               & dat3$MONTH %in% input$month,]
          #G2 <- gvisGeoChart(datFilter, locationvar = "variable",
          #                        colorvar = "value", 
          #                        options = list(width = 600,  height = 400, region = "ES", resolution="provinces"))
          #gvisSteppedAreaChart 
          if (length(input$provinces)==0) {
              prov <- "CASTILLA_LEON"
          } else {
              prov <- input$provinces
          }
          G2 <- gvisColumnChart(dat3Filter, xvar="MONTH", 
                               yvar= prov,
                               options=list(isStacked=TRUE, width = 600,  height = 600))
          return(G2)})
  }
)
