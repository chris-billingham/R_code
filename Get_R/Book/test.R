
# Import the log4r package.
library('log4r')

# Create a new logger object with create.logger().
logger <- create.logger()

# Set the logger's file output: currently only allows flat files.
logfile(logger) <- file.path('base.log')

# Set the current level of the logger.
level(logger) <- "DEBUG"

v1=1+2
v3
# Try logging messages at different priority levels.
debug(logger, 'A Debugging Message') # Won't print anything


