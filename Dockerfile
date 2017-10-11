FROM alpine:latest

RUN apk add --update python py-pip
RUN pip install --upgrade pip

COPY requirements.txt /
RUN pip install -r /requirements.txt 

COPY server.py /

EXPOSE 3000

CMD python /server.py
