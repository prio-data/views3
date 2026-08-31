
# viewser backend

This is the code which needs to be installed to instantiate the viewser backend. 

The backend is currently installed on vimur (with the database hosted on gjoll) and hermes (database also on hermes). In both cases, there is a 'views_data' user which owns the backend. To do anything with the backend, you need to do sudo su views_data and then cd to log in as views_data and move to its home directory first.

# Starting the system

This is done by running docker compose up -d in the views3 directory containing the docker_compose.yaml file. Omitting the -d flag will give debugging information if the system fails to start cleanly.

# Stopping the system

This is done by running docker compose down in the views3 directory containing the docker_compose.yaml file.

# System structure

The backend consists of four containers:

(i) storefront - runs an nginx instance, redirects queries to one of the other containers as appropriate

(ii) redis - used to record which querysets are currently being worked on, and by celery to keep track of which jobs are currently in progress

(iii) queryset_manager - maintains a database of all querysets

(iv) views_data_service - this does all the work. A query compiler fetches raw data from the database and preforms aggregation/disaggregation), and a transformer processes all requests to transform data. All jobs are run by the celery async queuing library.

# Cache

All raw data, intermediate stages of transformed data and final data are stored in a cache directory in the views3 directory. The cache is automatically cleared if there are any updates to the database, so that out-of-date cached data is destroyed. Of course, the cache can be manually cleared by deleting all the files in this directory.

# Logs

The query compiler and transformer maintain separate logs in the logs directory in the views3 directory, which is a good way of finding the cause of problems

# Troubleshooting

Generally the backend has proved very reliable and stable. If problems do occur, e.g. a queryset seems to hang, try the following:

(i) bring the system down and then back up

(ii) take the system down, manually clear the cache, then bring it back up again

(iii) log into the redis container, find the problem queryset's name in the redis database and delete the key

If none of these solves the problem, consult the logs in the log directory.
