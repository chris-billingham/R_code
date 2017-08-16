#' Connect to eBay Teradata systems
#' 
#' @param system A teradata system - defaults to hopper, can pass IP address if prefered.
#' @param user A valid Teradata username.
#' @param password A valid Teradata password.
#' @param database The required Teradata database, default = access_views.
#' @param fastload TRUE if you want a FASTLOAD connection type, default = FALSE
#' @param csv TRUE if you want to use this connection for FASTLOADCSV, default = FALSE
#' @param session Number of concurrent sessions to use for fastload operations, default = 1
#' @param quiet Set to TRUE to suppress echoing of connection string, default = FALSE
#' @return An RJDBC connection to specified Teradata database.
#' @examples
#' \dontrun{
#' # Pass credentials inline and default to hopper
#' c <- teradataConnect(user="<username>",password="<password>")
#' # Pass credentials inline and connect to vivaldi
#' c <- teradataConnect(system="vivaldi",user="<username>",password="<password>")
#' # Or rely on TDParams
#' c <- teradataConnect()
#' # Initialise Teradata credential cache
#' teradataInit(user="<username>",password="<password>")
#' }
#' 
teradataConnect <- function(system="hopper", user="", password="", database="access_views", fastload = FALSE, csv = FALSE, sessions = 1, quiet = FALSE, fastexport = FALSE)
{
  #path <- path.package("ebaytd")
  path <- "~"
  f <- paste(path,"/.TDparams",sep="")
  
  if(user == "" & password == "" & !file.exists(f)) {
    stop("Either supply Teradata credentials or initialise your Teradata credential cache.  See ?teradataInit() for further information.")
  }
  
  if (system == "vivaldi" | system == "mozart" | system =="hopper") {
    system <- paste(system, ".vip.ebay.com", sep="")
  }
  
  if(user == "" & password == "")
  {
    load(f)  
  } else {
    u <- user
    p <- password
  }
  
  if (!require("RJDBC",quietly = TRUE)) {
    stop("RJDBC package required to connect to Teradata.", call. = FALSE)
  }
  
  if (fastload & fastexport) {
    stop("Connection can only support FASTLOAD or FASTEXPORT - not both.")
  }
  
  if (fastload) {
    if (csv) {
      ctype='FASTLOADCSV'
    } else {
      ctype='FASTLOAD'
    }
  }
  
  if (fastexport) {
    ctype ='FASTEXPORT'
  }
  
  td_jdbc_path <- path.package("ebaytd")
  jars <- c(paste(td_jdbc_path,"/terajdbc4.jar",sep=""),paste(td_jdbc_path,"/tdgssconfig.jar",sep=""))
  drv <- JDBC("com.teradata.jdbc.TeraDriver",jars)
  db <- paste("jdbc:teradata://",
              system,
              "/TMODE=",
              ifelse(fastload | fastexport,"ANSI","TERADATA"),
              ",charset=UTF8",
              ifelse(fastload | fastexport,paste(",TYPE=",trimws(ctype),",SESSIONS=",trimws(sessions),sep=""),""),
              sep="")
  
  if (!quiet){
    print(db)
  }
  
  conn <- dbConnect(drv, db, u, p, database )
  
  teradataConnect <- conn
    
}

#' Initialise Teradata credential cache
#' 
#' @param user A valid Teradata username.
#' @param password A valid Teradata password.
#' @examples
#' \dontrun{
#' # Initialise Teradata credential cache
#' teradataInit(user="<username>",password="<password>")
#' }
#' 
teradataInit <- function(user,password)
{
  #path <- path.package("ebaytd")
  path <- "~"
  f <- paste(path,"/.TDparams",sep="")  
  u <- user
  p <- password
  save(u,p,file=f) 
}


#' Delete table if it exists 
#' 
#' @param conn A valid Teradata connection
#' @param database A valid Teradata database name
#' @param table A valid Teradata table name
#' @examples
#' \dontrun{
#' conn <- teradataCteradataConnect()
#' dbExistsRemove(conn,"p_mg_t","test")
#' }
#' 
dbExistsRemove <- function(conn, database, table)
{
  if(database == "") {
    stop("You must provide a valid database name.")
  }
  
  if(table == "") {
    stop("You must provide a valid table name.")
  }
  
  if (dbExistsTable(conn,database, table)) {
    return(dbRemoveTable(conn,paste(database,table,sep=".")))
  } 
  else
  {
    return(1)
  }
}

#' Check if table exists - overrides RJDBC implementation which ignores database
#' 
#' @param conn A valid Teradata connection
#' @param database A valid Teradata database name
#' @param table A valid Teradata table name
#' @examples
#' \dontrun{
#' conn <- teradataCteradataConnect()
#' dbExistsTable(conn,"p_mg_t","test")
#' }
#' 
dbExistsTable <- function(conn, database, table)
{
  
  if(database == "") {
    stop("You must provide a valid database name.")
  }
  
  if(table == "") {
    stop("You must provide a valid table name.")
  }
  
  sql <- paste(
    "SELECT * FROM DBC.TABLES WHERE TABLENAME ='",
    table,
    "' AND DATABASENAME = '",
    database,
    "';", sep = "")
  
  df <- dbGetQuery(conn,sql)
  
  if (nrow(df) > 0 ) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}


#' Fast load R data.frame into eBay Teradata systems using a FASTLOADCSV connection
#' This function first writes data to CSV and then imports to Teradata
#' 
#' @param data The data frame to load to teradata
#' @param conn A normal JDBC connection to a teradata system
#' @param conn_fast A fast JDBC connection to a teradata system
#' @param database The database (PET space / VDM ) to create the table in
#' @param table The table name where the data frame will be copied
#' @param replace Whether to remove the table if it already exists - default TRUE
#' @param primary_index Vector of column numbers from data frame to use as primary index
#' @param field_names List mapping data frame column names to teradata data types - by default function with infer types from data frame
#' @param partition_date The date column index to use to create partition - if required else NULL
#' @param quiet Set to TRUE to suppress progress output message - default = FALSE
#' @param warnings Set to TRUE to display SQLWarning objects if they are created - default = FALSE
#' @return Success flag 1 = success, 0 = failed 
#' @examples
#' \dontrun{
#' c <- teradataConnect(database='p_eueda_t')
#' cf <- teradataConnect(database='p_eueda_t',fastload=TRUE, csv=TRUE)
#' df1 <- data.frame(x=seq(1,10),y=seq(11,20))
#' teradataFastloadCSV(df1, c, cf, "p_eueda_t", "test", replace = TRUE, primary_index = c(1), field_types=list('x'='int','y'='varchar(1024)'))
#' df2 <- dbGetQuery(c,'select * from p_eueda_t.matt_test')
#' print(df2)
#' }
#' 
teradataFastloadCSV <- function(data, conn, conn_fast, database, table, replace = TRUE, primary_index = NULL , field_types = NULL, partition_date = NULL, quiet = FALSE, warnings = FALSE) {
  
  if(is.null(data)) {stop('Data frame required for fastload.')}
  if(is.null(conn)) {stop('JDBC connection required for fastload.')}
  if(is.null(conn_fast)) {stop('Fast JDBC connection required for fastload.')}
  if(is.null(primary_index)) {stop('Primary index is reqiured.')}
  
  if(!is.null(field_types)) {
    if(!is.list(field_types)) { stop('Field types must be passed as list.')}
    if(length(field_types) != ncol(data) ) {
      stop('Field types and data frame do not match.')
    }
    if(length(names(field_types))!=length(unique(names(field_types)))) { stop('Duplicate names in field_types.')}
    if(!setequal(names(field_types), names(data))) { stop('Field types and data frame do not match.')}
  }
  
  if (sum(is.na(data)) > 0 ) {
    stop('Can only use teradataFastloadCSV when dataframe has no missing (NA) values.  Either recode or use teradataFastloadBatch().')
  }
  
  if (!quiet) {
    cat('Fastload preparing..writing data to file.\n')
  }
  
  full_table <- paste(database,table,sep='.')
  
  # remove dots from column names
  colnames(data) <- gsub("\\.", "_", colnames(data))
  
  pi_column <- colnames(data[primary_index])
  pi_column <- paste('"',pi_column,'"', sep='', collapse=',')
  
  if(!is.null(partition_date)) {
    pd_column <- colnames(data[partition_date])
    pd_column <- paste(pd_column, collapse=',')
  } else {
    pd_column <- NULL
  }
  
  dbBuildTableDefinition <-
    function (full_table, df, field_types = NULL, primary_index = NULL, partition_date = NULL, pi_column, pd_column...)
    {
      if (!is.data.frame(df))
        df <- as.data.frame(df)
      if (is.null(field_types)) {
        field_types <- lapply(df, tdDataType)
      }
      flds <- paste(paste('"',names(field_types),'"',sep=""), field_types)
      base = sprintf("CREATE MULTISET TABLE %s, no fallback, no before journal, no after journal (%s)", full_table,
                     paste(flds, collapse = ",\n"))
      if (!is.null(primary_index))
        base = sprintf("%s primary index(%s)", base, pi_column)
      if (!is.null(partition_date))
        base = sprintf("%s PARTITION BY RANGE_N(%s BETWEEN DATE '2005-01-01' AND DATE '2020-12-31' EACH INTERVAL '1' DAY, NO RANGE)", base, pd_column)
      return (base)
    }
  
  tdDataType <- function (obj)
  {
    rs.class <- class(obj)
    if (rs.class %in% c("integer", "int")) "bigint"
    else switch(rs.class,
                character = "varchar(1024)",
                logical = "byteint",
                Factor = "varchar(1024)",
                Date = "DATE format 'YYYY-MM-DD'",
                POSIXct = "timestamp(0)",
                numeric = "float",
                "varchar(1024)")
  }
  
  processWarnings <- function(obj)
  {
    w <- .jcall(obj, "Ljava/sql/SQLWarning;", "getWarnings")
    if(! is.null(w)) {
      cat('SQL Warnings:\n')
      while(! is.null(w)) {
        message <- .jcall(w,"Ljava/lang/String;", "getMessage")
        sqlState <- .jcall(w,"Ljava/lang/String;", "getSQLState")
        errorCode <- .jcall(w,"Ljava/lang/String;", "getErrorCode")
        cat('+')
        cat(paste(message,'\n',sep=''))
        cat(paste(sqlState,'\n', sep=''))
        cat(paste(errorCode,'\n', sep=''))
        w = .jcall(w,"Ljava/sql/SQLWarning;", "getNextWarning")
      }
    }
  }
  
  # check table if exist and whether user wants to replace or append
  if(replace == TRUE) {
    dbExistsRemove(conn, database, table)
    sql <- dbBuildTableDefinition(full_table, data, field_types, primary_index, partition_date, pi_column, pd_column )
    if (!quiet) {
      cat(sql)
      cat("\n")
    }
    dbSendUpdate(conn, sql)
  } else {
    if(!dbExistsTable(conn, database, table)) {
      sql <- dbBuildTableDefinition(full_table, data, field_types, primary_index, partition_date, pi_column, pd_column)
      if (!quiet) {
        cat(sql)
        cat("\n")
      }
      dbSendUpdate(conn, sql)
    }
  }
  
  # Just in case they were left behind!
  dbExistsRemove(conn, database, paste(table, "_ERR_1", sep=""))
  dbExistsRemove(conn, database, paste(table, "_ERR_2", sep=""))
  
  col.names <- colnames(data)
  
  prepared.statement <- .jcall(conn_fast@jc, "Ljava/sql/PreparedStatement;", "prepareStatement", 
                               paste("insert into ",full_table," values (",paste(rep("?",length(col.names)), collapse=","),")", sep = ""))
  
  if(warnings) processWarnings(conn_fast@jc)
  
  # write table to csv 
  csv_file <- tempfile()
  on.exit(unlink(csv_file))
  
  # colnames is required in the CSV (or the 1st line is ignored)
  write.table(data, file = csv_file, sep = ",", quote = FALSE, row.names = FALSE)
  
  java_file   <- .jnew("java/io/File", csv_file)
  java_stream <- .jnew("java/io/FileInputStream", java_file)
  
  # upload the data
  prepared.statement$setAsciiStream(1L, java_stream)
  if (!quiet) {
    cat("Fastload working....uploading data to Teradata.\n")
  }
  sstime <- Sys.time()
  prepared.statement$executeUpdate()
  
  if(warnings) processWarnings(prepared.statement)
  
  if (!quiet) {
    cat(paste0("Fastload done.......", nrow(data), " rows inserted in ", format(Sys.time() - sstime), ".\n"))
  }
  
  if (!quiet) {
    cat("Fastload cleaning...tidying up temporary tables.\n")
  }
  
  if (dbExistsTable(conn, database, paste(table, "_ERR_1", sep=""))) {
    e1 <- dbGetQuery(conn,paste('select * from ',database,'.',table, "_ERR_1", sep=""))
    if (nrow(e1) > 0) {
      warning(paste('Error table ',database,'.',table, "_ERR_1 not empty - check your data!", sep=""))
    } else {
      dbExistsRemove(conn, database, paste(table, "_ERR_1", sep=""))
    }  
  }
  
  if (dbExistsTable(conn, database, paste(table, "_ERR_1", sep=""))) {
    e2 <- dbGetQuery(conn,paste('select * from ',database,'.',table, "_ERR_2", sep=""))
    if (nrow(e2) > 0) {
      warning(paste('Error table ',database,'.',table, "_ERR_1 not empty - check your data!", sep=""))
    } else {
      dbExistsRemove(conn, database, paste(table, "_ERR_2", sep=""))
    }
  }
  
  if (!quiet) {
    cat("Fastload done!\n")
  }
}

#' Fast load R data.frame into eBay Teradata systems using a FASTLOAD connection.
#' This function uploads batches of data without writing to a csv file.
#' 
#' @param data The data frame to load to teradata
#' @param conn A normal JDBC connection to a teradata system
#' @param conn_fast A fast JDBC connection to a teradata system
#' @param database The database (PET space / VDM ) to create the table in
#' @param table The table name where the data frame will be copied
#' @param replace Whether to remove the table if it already exists - default TRUE
#' @param primary_index Vector of column numbers from data frame to use as primary index
#' @param field_names List mapping data frame column names to teradata data types - by default function with infer types from data frame
#' @param partition_date The date column index to use to create partition - if required else NULL
#' @param batchsize The number of records to insert in a single batch - default = 10000
#' @param quiet Set to TRUE to suppress progress output message - default = FALSE
#' @param warnings Set to TRUE to display SQLWarning objects if they are created - default = FALSE
#' @return Success flag 1 = success, 0 = failed 
#' @examples
#' \dontrun{
#' c <- teradataConnect(database='p_eueda_t')
#' cf <- teradataConnect(database='p_eueda_t',fastload=TRUE, csv=FALSE)
#' df1 <- data.frame(x=seq(1,10),y=seq(11,20))
#' teradataFastloadBatch(df1, c, cf, "p_eueda_t", "test", replace = TRUE, primary_index = c(1), field_types=list('x'='int','y'='varchar(1024)'), batchsize=10000)
#' df2 <- dbGetQuery(c,'select * from p_eueda_t.matt_test')
#' print(df2)
#' }
#' 
teradataFastloadBatch <- function(data, conn, conn_fast, database, table, replace = TRUE, primary_index = NULL , field_types = NULL, partition_date = NULL, batchsize = 10000, quiet = FALSE, warnings = FALSE) {
  
  if(is.null(data)) {stop('Data frame required for fastload.')}
  if(is.null(conn)) {stop('JDBC connection required for fastload.')}
  if(is.null(conn_fast)) {stop('Fast JDBC connection required for fastload.')}
  if(is.null(primary_index)) {stop('Primary index is reqiured.')}
  if(batchsize < 1) {
    stop('Batchsize must be a positive integer')
  }
  if(!is.null(field_types)) {
    if(!is.list(field_types)) { stop('Field types must be passed as list.')}
    if(length(field_types) != ncol(data) ) {
      stop('Field types and data frame do not match.')
    }
    if(length(names(field_types))!=length(unique(names(field_types)))) { stop('Duplicate names in field_types.')}
    if(!setequal(names(field_types), names(data))) { stop('Field types and data frame do not match.')}
  }
  
  if (!quiet) {
    cat('Fastload preparing..inspecting data frame.\n')
  }
  
  full_table <- paste(database,table,sep='.')
  
  # remove dots from column names
  colnames(data) <- gsub("\\.", "_", colnames(data))
  
  pi_column <- colnames(data[primary_index])
  pi_column <- paste('"',pi_column,'"', sep='', collapse=',')
  
  if(!is.null(partition_date)) {
    pd_column <- colnames(data[partition_date])
    pd_column <- paste(pd_column, collapse=',')
  } else {
    pd_column <- NULL
  }
  
  jni.transform <- function(setter, x) {
    switch(setter,
           'setInt' = as.integer(x),
           'setLong' = .jlong(x),
           'setFloat' = .jfloat(x),
           'setDate' = .jnew("java/sql/Date",.jlong(as.numeric(as.POSIXct(format(x,'%Y-%m-%d %Z'))))*1000),
           'setString' = as.character(x)
    )
  }
  
  dbBuildTableDefinition <-
    function (full_table, df, field_types = NULL, primary_index = NULL, partition_date = NULL, pi_column, pd_column...)
    {
      if (!is.data.frame(df))
        df <- as.data.frame(df)
      if (is.null(field_types)) {
        field_types <- lapply(df, tdDataType)
      }
      flds <- paste(paste('"',names(field_types),'"',sep=""), field_types)
      base = sprintf("CREATE MULTISET TABLE %s, no fallback, no before journal, no after journal (%s)", full_table,
                     paste(flds, collapse = ",\n"))
      if (!is.null(primary_index))
        base = sprintf("%s primary index(%s)", base, pi_column)
      if (!is.null(partition_date))
        base = sprintf("%s PARTITION BY RANGE_N(%s BETWEEN DATE '2005-01-01' AND DATE '2020-12-31' EACH INTERVAL '1' DAY, NO RANGE)", base, pd_column)
      return (base)
    }
  
  tdDataType <- function (obj)
  {
    rs.class <- class(obj)
    if (rs.class %in% c("integer", "int")) "bigint"
    else switch(rs.class,
                character = "varchar(1024)",
                logical = "byteint",
                Factor = "varchar(1024)",
                Date = "DATE format 'YYYY-MM-DD'",
                POSIXct = "timestamp(0)",
                numeric = "float",
                "varchar(1024)")
  }
  
  processWarnings <- function(obj)
  {
    w <- .jcall(obj, "Ljava/sql/SQLWarning;", "getWarnings")
    if(! is.null(w)) {
      cat('SQL Warnings:\n')
      while(! is.null(w)) {
        message <- .jcall(w,"Ljava/lang/String;", "getMessage")
        sqlState <- .jcall(w,"Ljava/lang/String;", "getSQLState")
        errorCode <- .jcall(w,"Ljava/lang/String;", "getErrorCode")
        cat('+')
        cat(paste(message,'\n',sep=''))
        cat(paste(sqlState,'\n', sep=''))
        cat(paste(errorCode,'\n', sep=''))
        w = .jcall(w,"Ljava/sql/SQLWarning;", "getNextWarning")
      }
    }
  }
  
  # check table if exist and whether user wants to replace or append
  if(replace == TRUE) {
    dbExistsRemove(conn, database, table)
    sql <- dbBuildTableDefinition(full_table, data, field_types, primary_index, partition_date, pi_column, pd_column )
    if (!quiet) {
      cat(sql)
      cat("\n")
    }
    dbSendUpdate(conn, sql)
  } else {
    if(!dbExistsTable(conn, database, table)) {
      sql <- dbBuildTableDefinition(full_table, data, field_types, primary_index, partition_date, pi_column, pd_column)
      if (!quiet) {
        cat(sql)
        cat("\n")
      }
      dbSendUpdate(conn, sql)
    }
  }
  
  # Just in case they were left behind!
  dbExistsRemove(conn, database, paste(table, "_ERR_1", sep=""))
  dbExistsRemove(conn, database, paste(table, "_ERR_2", sep=""))
  
  col.names <- colnames(data)
  
  ps <- .jcall(conn_fast@jc, "Ljava/sql/PreparedStatement;", "prepareStatement", 
               paste("insert into ",full_table," values (",paste(rep("?",length(col.names)), collapse=","),")", sep = ""))
  
  if (warnings) processWarnings(conn_fast@jc)
  
  if (!quiet) {
    pmd <- .jcall(ps,"Ljava/sql/ParameterMetaData;", "getParameterMetaData")
    pmc <- .jcall(pmd,"I", "getParameterCount")
    print(paste(pmc,"parameters", sep=" "))
    for(i in 1:pmc) {
      pt <- .jcall(pmd, "I", "getParameterType", as.integer(i))
      ptn <- .jcall(pmd, "Ljava/lang/String;", "getParameterTypeName", as.integer(i))
      inb <- .jcall(pmd, "I", "isNullable", as.integer(i))
      print(paste(i,pt,ptn,inb,sep=", "))
    }
  }
  
  classes <- unlist(lapply(data,class))
  java.setters <- sapply(classes, function(i) {
    switch(i,
           'integer' = 'setLong',
           'numeric' = 'setFloat',
           'factor' = 'setString',
           'character' = 'setString',
           'Date' = 'setDate')
  })
  
  javatype = .jnew("java/sql/Types")
  java.typeint = sapply(classes, function(i) {
    switch(i,
           'integer' = .jfield(javatype, "I", "BIGINT"),
           'numeric' = .jfield(javatype, "I", "FLOAT"),
           'factor' = .jfield(javatype, "I", "VARCHAR"),
           'character' = .jfield(javatype, "I", "VARCHAR"),
           'Date' = .jfield(javatype, "I", "DATE"))
  })
  
  .jcall(conn_fast@jc, "V", "setAutoCommit",FALSE)
  
  sstime <- Sys.time()
  for (i in 1:nrow(data)) {
    r = data[i,]
    for (j in 1:ncol(data)) {
      value = unlist(r[,j])
      if (is.null(value) | is.na(value) | is.nan(value)) {
        .jcall(ps,"V","setNull",as.integer(j), java.typeint[j])
      }
      else {
        .jcall(ps,"V",java.setters[j],as.integer(j), jni.transform(java.setters[j], value))
      }
    }
    .jcall(ps,"V","addBatch")
    if (i %% batchsize == 0) { 
      .jcall(ps,"[I","executeBatch")
      if (warnings) processWarnings(ps)
      
      if (!quiet) {
        print(paste(i," rows inserted, ", format(Sys.time() - sstime, digits = 4) ," per ", batchsize, " rows", sep=""))
      }
      sstime <- Sys.time()
    }
  }
  
  .jcall(ps,"[I","executeBatch")
  if (warnings) processWarnings(ps)
  
  dbCommit(conn_fast)
  if (warnings) processWarnings(conn_fast@jc)
  
  .jcall(ps,"V","close")
  .jcall(conn_fast@jc, "V", "setAutoCommit",TRUE)
  
  if (!quiet) {
    cat("Fastload cleaning...tidying up temporary tables.\n")
  }
  
  if (dbExistsTable(conn, database, paste(table, "_ERR_1", sep=""))) {
    e1 <- dbGetQuery(conn,paste('select * from ',database,'.',table, "_ERR_1", sep=""))
    if (nrow(e1) > 0) {
      warning(paste('Error table ',database,'.',table, "_ERR_1 not empty - check your data!", sep=""))
    } else {
      dbExistsRemove(conn, database, paste(table, "_ERR_1", sep=""))
    }  
  }
  
  if (dbExistsTable(conn, database, paste(table, "_ERR_1", sep=""))) {
    e2 <- dbGetQuery(conn,paste('select * from ',database,'.',table, "_ERR_2", sep=""))
    if (nrow(e2) > 0) {
      warning(paste('Error table ',database,'.',table, "_ERR_1 not empty - check your data!", sep=""))
    } else {
      dbExistsRemove(conn, database, paste(table, "_ERR_2", sep=""))
    }
  }
  
  if (!quiet) {
    cat("Fastload done!\n")
  }
}


#' Fast export a table using a FASTEXPORT connection.  Fast export can only export a complete table.
#' 
#' @param conn A normal JDBC connection to the teradata system
#' @param conn_fast A fast export JDBC connection to the teradata system
#' @param database The database (PET space / VDM ) that contains the table to export
#' @param table The table name of the table to export
#' @param quiet Set to TRUE to suppress progress output message - default = FALSE
#' @param warnings Set to TRUE to display SQLWarning objects if they are created - default = FALSE
#' @return Dataframe containing the data
#' @examples
#' \dontrun{
#' library(ebaytd)
#' c <- teradataConnect()
#' cf <- teradataConnect(fastload = TRUE)
#' df <- data.frame(l_index = c(1,2), l_float = c(11.1, 22.2), l_date = as.Date(c('2008-01-18','2008-01-17')), l_chr = c('aaaaaa','bbbbbbbbb') )
#' teradataFastloadBatch(data = df, conn = c, conn_fast = cf, database = 'p_mg_t', table = 'test', replace = TRUE, primary_index = c(1),
#'                   field_types = list(l_index = 'INTEGER', l_float = 'FLOAT', l_date = 'DATE', l_chr = 'VARCHAR(12)'))
#' dbDisconnect(c)
#' dbDisconnect(cf)
#' c <- teradataConnect()
#' cf <- teradataConnect(fastexport = TRUE)
#' df2 <- teradataFastExport(conn = c, conn_fast = cf,database = 'p_mg_t',table = 'test')
#' dbDisconnect(c)
#' dbDisconnect(cf)
teradataFastExport <- function(conn, conn_fast, database, table, quiet = FALSE, warnings = FALSE) {
  if(is.null(conn)) stop('JDBC connection required for fastload.')
  if(is.null(conn_fast)) stop('Fast JDBC connection required for fastload.')
  
  full_table <- paste(database, table, sep='.')
  
  if(! dbExistsTable(conn, database, table)) stop(paste('The table ', full_table,' does not exist.', sep=''))
  
  nrows <- dbGetQuery(conn, paste('select count(*) from ', full_table, sep=''))
  
  if(!quiet) print(paste('Preparing to export ', nrows,' rows from ', full_table, sep=''))
  
  
  processWarnings <- function(obj)
  {
    w <- .jcall(obj, "Ljava/sql/SQLWarning;", "getWarnings")
    if(! is.null(w)) {
      cat('SQL Warnings:\n')
      while(! is.null(w)) {
        message <- .jcall(w,"Ljava/lang/String;", "getMessage")
        sqlState <- .jcall(w,"Ljava/lang/String;", "getSQLState")
        errorCode <- .jcall(w,"Ljava/lang/String;", "getErrorCode")
        cat('+')
        cat(paste(message,'\n',sep=''))
        cat(paste(sqlState,'\n', sep=''))
        cat(paste(errorCode,'\n', sep=''))
        w = .jcall(w,"Ljava/sql/SQLWarning;", "getNextWarning")
      }
    }
  }
  
  
  ps <- .jcall(conn_fast@jc, "Ljava/sql/PreparedStatement;", "prepareStatement", 
               "select l_index, l_float, l_date, l_chr from p_mg_t.test")
  if (warnings) processWarnings(ps)
  
  rs <- .jcall(ps, "Ljava/sql/ResultSet;", "executeQuery")
  rsmd <- .jcall(rs,"Ljava/sql/ResultSetMetaData;", "getMetaData")
  ncols <- .jcall(rsmd,"I","getColumnCount")
  field_types <- mapply(function(x) .jcall(rsmd,"S","getColumnTypeName",x), 1:.jcall(rsmd,"I","getColumnCount"))
  field_names <- mapply(function(x) .jcall(rsmd,"S","getColumnName",x), 1:.jcall(rsmd,"I","getColumnCount"))
  
  if (!quiet) {
    print(paste('Table has ', ncols, ' columns', sep=''))
    print(paste(field_names, field_types, sep=':'))
  }
  
  if (any (field_types %in% c('INTEGER', 'FLOAT', 'DATE', 'VARCHAR') == FALSE)) {
    f <- field_types %in% c('INTEGER', 'FLOAT', 'DATE', 'VARCHAR') == FALSE
    stop (paste('Unsupported field types ',paste(field_types[f], collapse = ', '),' in table.', sep=''))
  }
  
  df <- list()
  
  td.transform <- function(field_type, x) {
    switch(field_type,
           'INTEGER' = as.integer(x),
           'FLOAT' = as.numeric(x),
           'DATE' = as.Date(x),
           'VARCHAR' = as.character(x)
    )
  }
  
  for (j in 1:ncols) {
    df[[j]] <- td.transform(field_types[j], rep(NA, nrows))
  }
  names(df) <- field_names
  
  i <- 0
  while (.jcall(rs,"Z","next")) {
    i <- i + 1
    for (j in 1:ncols) {
      switch(field_types[j],
             'INTEGER' = {
               df[[j]][i] <- .jcall(rs, "I", "getInt",j)         
             },
             'FLOAT' = {
               df[[j]][i] <- .jcall(rs, "F", "getFloat",j)
             },
             'DATE' = {
               o <- .jcall(rs, "Ljava/sql/Date;", "getDate",j)
               s <- .jcall(o,"S","toString")
               df[[j]][i] <- as.Date(s)
             },
             'VARCHAR' = {
               df[[j]][i] <- .jcall(rs, "S", "getString",j)
             })
    }
  }
  
  df <- data.frame(df)
  
  if(!quiet) print(paste('Fast export complete.  Size of data.frame = ', format(object.size(df), units = 'auto'), paste=''))
  
  return(df)
  
}


