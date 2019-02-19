FROM python:3-onbuild
COPY project1 .
WORKDIR ./project1
COPY requirements.txt ./
RUN apt-get update
RUN apt-get install -y python python-pip python-dev build-essential
RUN pip install --no-cache-dir -r requirements.txt
RUN python3 manage.py makemigrations
RUN python3 manage.py migrate
EXPOSE 8000
CMD ["/start.sh"]a
CMD exec gunicorn project1.wsgi:application --bind 0.0.0.0:8000 --workers 3

