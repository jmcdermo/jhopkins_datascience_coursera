setwd('C:\\Users\\jmcdermo\\Documents\\GitHub\\datasciencecoursera\\getting_cleaning_data\\week_two')
addr <- 'http://biostat.jhsph.edu/~jleek/contact.html'

conn <- url(addr)
lines <- readLines(conn)

print(nchar(lines[10]))
print(nchar(lines[20]))
print(nchar(lines[30]))
print(nchar(lines[100]))

#library('httr')
#page <- GET(addr)
#cont <- content(page, as='text')