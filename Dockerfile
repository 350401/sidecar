FROM openjdk:8-jdk-alpine

ENV SERVER_PORT='8080'
ENV CONTEXT_PATH=''
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar", "-Dserver.port=${SERVER_PORT}","/app.jar" , "--server.servlet.context-path=/${CONTEXT_PATH}"]