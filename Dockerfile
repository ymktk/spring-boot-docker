FROM  gradle:6.6.0-jdk11 AS builder
WORKDIR /app

COPY ./demo/src             ./src
COPY ./demo/build.gradle    ./
COPY ./demo/settings.gradle ./
#COPY ./demo/gradle          ./gradle
#COPY ./demo/gradlew         ./

RUN  gradle build
#RUN  ./gradlew build

################################################################################
From openjdk:11-jre-slim-buster AS release

COPY --from=builder /app/build/libs/demo-0.0.1-SNAPSHOT.jar /app.jar

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

EXPOSE 8085
