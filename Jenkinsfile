pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/rafiqhere/Microservice.git'
            }
        }

        stage('Generate Jobs') {
            steps {
                jobDsl targets: 'jobs/*.groovy'
            }
        }
    }
}
