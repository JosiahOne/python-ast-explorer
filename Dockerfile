FROM alpine

WORKDIR /opt/pyast
ADD . /opt/pyast

RUN apk update && apk add g++ make nodejs npm python3  py3-pip

RUN python3 -m pip install -r requirements.txt
WORKDIR /opt/pyast/front
RUN npm install
RUN npm run build
WORKDIR /opt/pyast

ENTRYPOINT ["gunicorn"]
CMD ["app:app", "-w", "4", "-b", "0.0.0.0:4361"]
