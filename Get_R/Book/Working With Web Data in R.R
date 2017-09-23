# Load pageviews
install.packages('pageviews')
library(pageviews)

# Get the pageviews for "Hadley Wickham"
hadley_pageviews <- article_pageviews(article = "Hadley Wickham")

# Examine the resulting object
str(hadley_pageviews)
hadley_pageviews

# Load the httr package
library(httr)

# Make a POST request to http://httpbin.org/post with the body "this is a test"
post_result <- POST(url = "http://httpbin.org/post", body = "this is a test")

# Print it to inspect it
post_result



# Get revision history for "Hadley Wickham"
resp_json <- rev_history("Hadley Wickham")

# Check http_type() of resp_json
http_type(resp_json)

# Examine returned text with content()
content(resp_json, as = "text")

# Parse response with content()
content(resp_json, as = "parsed")

# Parse returned text with fromJSON()
library(jsonlite)
fromJSON(content(resp_json, as = "text"))


library(httr)
library(jsonlite)
# Make a GET request to http://httpbin.org/get
get_result <- GET(url = "http://httpbin.org/get")

# Print it to inspect it
get_result

http_type(get_result)
content(get_result, as = "text")
content(get_result, as = "parsed")
fromJSON(content(get_result, as = "text"))

fromJSON(get_result, simplifyDataFrame=TRUE)

fromJSON(content(get_result, as = "text"),simplifyDataFrame=TRUE)

library(dplyr)

revs <- content(get_result)
revs

# Load dplyr
library(dplyr)
# Get revision history for "Hadley Wickham"
resp_json <- rev_history("Hadley Wickham")
# Pull out revision list
revs <- content(resp_json)$query$pages$`41916270`$revisions
revs
# Extract user and timestamp
revs %>%
  bind_rows() %>%
  select(user, timestamp)


# Load sparklyr
#install.packages('sparklyr')
library(sparklyr)
#spark_install()
# Connect to your Spark cluster
spark_conn <- spark_connect("local")

# Print the version of Spark
spark_version(spark_conn)

# Disconnect from Spark
spark_disconnect(spark_conn)


library(xml2)
x <- read_xml("<foo>
              <bar>text <baz id = 'a' /></bar>
              <bar>2</bar>
              <baz id = 'b' />
              </foo>")

xml_name(x)

xml_children(x)


# Find all baz nodes anywhere in the document
baz <- xml_find_all(x, ".//baz")
baz

xml_path(baz)

xml_attr(baz, "id")


x <- read_xml("<foo>
              <bar>text <baz id = 'a' /></bar>
              <bar>2</bar>
              <baz id = 'b' />
              <bar type='123'>2</bar>  
              </foo>")


node=xml_find_all(x, "//bar")
node

# get text
xml_text(node)
# find attributes 'type'
xml_attr(node, "type")



library(rvest)

# Hadley Wickham's Wikipedia page
test_url <- "https://en.wikipedia.org/wiki/Hadley_Wickham"

# Read the URL stored as "test_url" with read_html()
test_xml <- read_html(test_url)

# Print test_xml
test_xml

# xpath 
test_node_xpath='//*[contains(concat( \" \", @class, \" \" ), concat( \" \", \"vcard\", \" \" ))]'

# Use html_node() to grab the node with the XPATH stored as `test_node_xpath`
node <- html_node(x = test_xml, xpath = test_node_xpath)

# Print the first element of the result
node[[1]]




url='https://www.basketball-reference.com/leagues/NBA_2017.html'

test_xml <- read_html(url)
test_xml
table <- html_table(x = test_xml)
table

class="suppress_all sortable stats_table now_sortable"

node <- html_node(x = test_xml, xpath = '//*[@id="confs_standings_E"]')
table <- html_table(node)
table


url='https://www.basketball-reference.com/leagues/NBA_2017.html'

xml <- read_html(url)

all_table <- html_table(xml)
all_table
all_table[[1]]


# Load sparklyr
library(sparklyr)

# Connect to your Spark cluster
spark_conn <- spark_connect("local")

# Print the version of Spark
spark_version(spark_conn)

# Disconnect from Spark
spark_disconnect(spark_conn)
