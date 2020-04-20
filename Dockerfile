FROM azul/zulu-openjdk:8
MAINTAINER Vanessa Williams <vanessa.williams@thoughtwire.com>

# Create directories for configs and the microservice itself
RUN mkdir -p /opt/tw-data/config && mkdir -p /opt/tw-data/services

# Add Maven dependencies (not shaded into the artifact; Docker-cached)
# ADD target/lib           /usr/share/authservice/lib
# Add the service itself
COPY ./target/building-management-service-*.jar /opt/tw-data/services/building-management-service.jar
COPY ./src/main/resources/log4j2-container.xml /opt/tw-data/config/logs/log4j2-building-service.xml
COPY ./src/main/resources/building-service.yml /opt/tw-data/config/building-service.yml

# Run the microservice
ENTRYPOINT [ "java" ]
CMD [ "-Xms512M", "-Xmx1024M", "-XX:+HeapDumpOnOutOfMemoryError", "-XX:HeapDumpPath=/var/log/thoughtwire/building_service_heapdump", "-jar", "/opt/tw-data/services/building-management-service.jar", "--spring.config.location=file:/opt/tw-data/config/building-service.yml"]
