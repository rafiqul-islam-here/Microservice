def services = [
    [
        name: 'frontend',
        branch: 'frontend',
        image: 'frontend',
        context: '.'
    ],
    [
        name: 'cartservice',
        branch: 'cartservice',
        image: 'cartservice',
        context: './src'
    ]
]

services.each { svc ->

    pipelineJob("${svc.name}-pipeline") {

        definition {
            cps {
                script("""
pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git branch: '${svc.branch}',
                    url: 'https://github.com/rafiqul-islam-here/Microservice.git'
            }
        }

        stage('Build') {
            steps {
                sh 'docker build -t rafiqhere/jenkins:${svc.image} ${svc.context}'
            }
        }

        stage('Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-cred',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    sh 'echo "$PASS" | docker login -u "$USER" --password-stdin'
                }
            }
        }

        stage('Push') {
            steps {
                sh 'docker push rafiqhere/jenkins:${svc.image}'
            }
        }

    }
}
                """.stripIndent())

                sandbox()
            }
        }
    }
}
