def services = [
    "frontend",
    "cartservice",
    "adservice"
]

services.each { service ->
    pipelineJob("${service}-pipeline") {
        definition {
            cpsScm {
                scm {
                    git {
                        remote {
                            url("https://github.com/rafiqul-islam-here/Microservice.git")
                        }
                        branch(service)
                    }
                }
                scriptPath("Jenkinsfile")
            }
        }
    }
}
