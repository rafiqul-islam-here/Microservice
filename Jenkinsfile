pipeline {
    agent any

    stages {

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t rafiqhere/jenkinsfrontend:latest .'
            }
        }

        stage('Docker Login & Push') {
            steps {
                withDockerRegistry(credentialsId: 'docker-cred') {
                    sh 'docker push rafiqhere/jenkinsfrontend:latest'
                }
            }
        }

    }
}