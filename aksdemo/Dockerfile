FROM openjdk:11
EXPOSE 8080
RUN mkdir target
ARG JAR_FILE=./target/*.jar
COPY ${JAR_FILE}  ./aksdemo/target/aksdemo.jar
ENTRYPOINT ["java","-jar","/target/aksdemo.jar"]
