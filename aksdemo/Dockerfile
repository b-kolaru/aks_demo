FROM openjdk:11
ADD ${{ github.workspace }}/target/target/aksdemo-0.0.1-SNAPSHOT.jar aksdemo.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar" , "aksdemo.jar"]
