# Stage 1: Сборка проекта
FROM gradle:8.4-jdk21 AS build
WORKDIR /app
COPY build.gradle settings.gradle ./
COPY src ./src
RUN gradle build

# Stage 2: Запуск приложения
FROM openjdk:21-jdk-slim
WORKDIR /app
COPY --from=build /app/build/libs/delivery-0.0.1-SNAPSHOT.jar delivery.jar
EXPOSE 8761
ENTRYPOINT ["java", "-jar", "delivery.jar"]