library(RCurl)
library(XML)
library(rvest)

theurl <- "http://www.commeaucinema.com/box-office/france"
webpage <- getURL(theurl)
webpage <- readlines(tc <- testConnection(webpage)); close(tc)

pagetree <- htmlTreeParse(webpage, error=function(...){}, useInternalNodes = TRUE, encoding = "UTF-8")

# Extract table header and contents
tablehead <- xpathSApply(pagetree, "//*/table[@class='boxoffice']/thead/tr/td", xmlValue)
results <- xpathSApply(pagetree, "//*/table[@class='boxoffice']/tbody/tr/td", xmlValue)

content <- as.data.frame(matrix(results, ncol = 5, byrow = TRUE))

content[,1] <- gsub("Â ", "", content[,1])print
tablehead <- gsub("Â ", "", tablehead)
names(content) <- tablehead

scrap <- read_html(theurl)
semaine <- scrap %>% html_node("h1 small") %>% html_text()

print(content)
print(semaine)