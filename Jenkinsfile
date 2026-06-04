pipeline {
    agent any

    stages {

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t rafiqhere/jenkinsfrontend:frontendlatest .'
            }
        }

        stage('Docker Login & Push') {
            steps {
                withDockerRegistry(credentialsId: 'docker-cred') {
                    sh 'docker push rafiqhere/jenkinsfrontend:frontendlatest'
                }
            }
        }

    }
}