FROM python:3.9-slim

ENV PYTHONBUFFERED True

COPY requirement.txt ./

RUN pip install -r requirement.txt

ENV APP_HOME /manojApp

WORKDIR $APP_HOME

COPY . ./

CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 python_app1:app