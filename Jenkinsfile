pipeline {
    agent any

    environment {
        // Определение переменных окружения
        JAVA_HOME = '/usr/lib/jvm/java-17-openjdk'
    }

    stages {
        stage('Checkout') {
            steps {
                // Клонируем репозиторий
                git 'https://github.com/your/repository.git'
            }
        }

        stage('Build') {
            steps {
                // Сборка проекта
                sh './gradlew clean build'
            }
        }

        stage('Test') {
            steps {
                // Запуск тестов
                sh './gradlew test'
            }
        }

        stage('Package') {
            steps {
                // Пакуем приложение (например, в .jar файл)
                sh './gradlew bootJar'
            }
        }

        stage('Deploy') {
            steps {
                // Деплой (например, в Docker)
                script {
                    docker.build("eureka")
                    docker.run("-d -p 8761:8761 eureka")
                }
            }
        }
    }

    post {
        always {
            // Действия, которые выполняются всегда (например, очистка ресурсов)
            cleanWs()
        }

        success {
            // Действия при успешном завершении (например, уведомления)
            echo 'Build and deployment successful'
        }

        failure {
            // Действия при ошибке (например, уведомления)
            echo 'Build or deployment failed'
        }
    }
}
