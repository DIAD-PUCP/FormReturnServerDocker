FROM ubuntu:latest

RUN groupadd --gid 1000 formreturn && useradd --uid 1000 --gid formreturn --shell /bin/bash --create-home formreturn

WORKDIR /home/formreturn

RUN mkdir .formreturn && chown -R formreturn:formreturn .formreturn

RUN apt-get update && apt-get -y install openjdk-8-jre-headless unzip xvfb --no-install-recommends

RUN sed -i -e '/^assistive_technologies=/s/^/#/' /etc/java-*-openjdk/accessibility.properties

ADD https://github.com/rquast/formreturn/releases/download/v1.7.5/formreturn_setup_1.7.5.jar .

RUN unzip formreturn_setup_1.7.5.jar && rm formreturn_setup_1.7.5.jar && chmod +x ./formreturn_server.sh

COPY xvfb_formreturn_server.sh .

RUN chmod +x ./xvfb_formreturn_server.sh

USER formreturn

CMD [ "./xvfb_formreturn_server.sh" ]