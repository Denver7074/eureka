FROM gradle:8.4-jdk21 AS build
WORKDIR /app
COPY build.gradle settings.gradle ./
COPY src ./src
RUN gradle build --no-daemon

FROM eclipse-temurin:21.0.2_1-jre-alpine
WORKDIR /app
COPY --from=build /app/build/libs/delivery-0.0.1-SNAPSHOT.jar delivery.jar
EXPOSE 8761
ENTRYPOINT ["java", "-jar", "delivery.jar"]