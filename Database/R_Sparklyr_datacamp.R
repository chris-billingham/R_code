#install.packages("sparklyr")
#install.packages(c("nycflights13", "Lahman"))
#https://campus.datacamp.com/courses/introduction-to-spark-in-r-using-sparklyr/light-my-fire-starting-to-use-spark-with-dplyr-syntax?ex=1

#########################################
# Load sparklyr
library(sparklyr)
library(dplyr)
library(pryr)
# Connect to your Spark cluster
spark_conn <- spark_connect("local")

# Print the version of Spark
spark_version(spark_conn)

# Disconnect from Spark
spark_disconnect(spark_conn)

# Explore track_metadata structure
track_metadata=read.csv('train.csv')
str(track_metadata)
dim(track_metadata)
# Connect to your Spark cluster
spark_conn <- spark_connect("local")

# Copy track_metadata to Spark
track_metadata_tbl <- copy_to(spark_conn, track_metadata,overwrite = TRUE)
track_metadata_tblv2 <- spark_read_csv(spark_conn,name ="track_metadata_V2", path='train.csv')
# List the data frames available in Spark
src_tbls(spark_conn)

# Disconnect from Spark
#spark_disconnect(spark_conn)

# Link to the track_metadata table in Spark
track_metadata_tbl <- tbl(spark_conn, "track_metadata")

# See how big the dataset is
dim(track_metadata_tbl)

# See how small the tibble is
object_size(track_metadata_tbl)

# Print 5 rows, all columns
print(track_metadata_tbl, n = 5, width = Inf)

# Examine structure of tibble
str(track_metadata_tbl)

# Examine structure of data
glimpse(track_metadata_tbl)

# track_metadata_tbl has been pre-defined
track_metadata_tbl

# Manipulate the track metadata
track_metadata_tbl %>%
  # Select columns
  select(Name, Sex)

track_metadata_tbl %>%
  # Select columns starting with artist
  select(starts_with("Se"))

track_metadata_tbl %>%
  # Select columns ending with id
  select(ends_with("d"))

track_metadata_tbl %>%
  # Select columns containing ti
  select(contains("ti"))

track_metadata_tbl %>%
  # Select columns matching ti.?t
  select(matches("Ti.?t"))

track_metadata_tbl %>%
  # Only return rows with distinct artist_name
  distinct(Pclass)

results=track_metadata_tbl %>%
  # Count the artist_name values
  count(Pclass, sort = TRUE) %>%
  # Restrict to top 20
  top_n(2)

results
class(results)

# Collect your results
collected <- results %>%
  collect()

# Examine the class of the collected results
class(collected)


