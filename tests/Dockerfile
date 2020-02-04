FROM ubuntu:latest

LABEL author="Mike Vartanian" maintainer="mike.vartanian@nih.gov"

RUN apt-get update && \
    apt-get -q -y install python3 python3-pip

RUN pip3 -q install requests

COPY basic_test.py basic_test.py

RUN chmod +x basic_test.py

CMD /basic_test.py
