FROM python:3

RUN pip install flask
COPY . /root/
WORKDIR /root
CMD [ "flask", "run", "--host=0.0.0.0" ]
# CMD [ "flask", "run", "--host=0.0.0.0", "--host=::0"  ]
