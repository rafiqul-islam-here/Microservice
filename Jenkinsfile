pipeline {
    agent any

    stages {
        stage('Create Jobs') {
            steps {
                jobDsl targets: 'jobs/*.groovy'
            }
        }
    }
}
