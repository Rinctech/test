FROM maven:3.8.4-jdk-11 AS build
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml clean package

FROM openjdk:8-jre-alpine
COPY --from=build /usr/src/app/target/ingestion-service-0.0.1.jar /usr/app/ingestion-service-0.0.1.jar
EXPOSE 8000
ENTRYPOINT ["java","-jar","/usr/app/ingestion-service-0.0.1.jar"]