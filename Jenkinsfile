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
                script {
                    withDockerRegistry(
                        credentialsId: 'docker-cred',
                        url: 'https://index.docker.io/v1/'
                    ) {
                        sh 'docker push rafiqhere/jenkinsfrontend:frontendlatest'
                    }
                }
            }
        }

    }
}