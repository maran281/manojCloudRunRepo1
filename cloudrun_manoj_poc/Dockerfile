#Use the official python image
FROM python:3.9-slim

#allow statment and og messages to immediately appear in the cloud run logs
ENV PYTHONBUFFERED True

#copy application dependency manifest to the container image
#copying this separately prevents re-running pip install on every code change.
COPY requirements.txt ./

#install production dependencies.
RUN pip install -r requirements.txt

#Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./

#run the webservice on container startup.
#use gunicornwebserver with one worker process and 8 threads
#for environment with multiple CPU cores, increase the number of workers
#to be equal to the core available
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 app:app
