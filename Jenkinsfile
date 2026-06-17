pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/rafiqul-islam-here/Microservice.git'
            }
        }

        stage('Generate Jobs') {
            steps {
                jobDsl targets: 'jobs/*.groovy'
            }
        }
    }
}
