def services = [
    "frontend",
    "cartservice",
    "adservice",
    "checkoutservice",
    "currencyservice",
    "emailservice",
    "loadgenerator",
    "paymentservice",
    "productcatalogservice",
    "recommendationservice",
    "shippingservice"
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

        triggers {
            scm('H/2 * * * *')
        }
    }
}
