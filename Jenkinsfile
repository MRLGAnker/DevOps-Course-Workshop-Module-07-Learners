pipeline {
    agent none
    stages{
        stage('Typescript'){
            agent {
                docker { image 'node:14-alpine' }
            }
            stages {
                stage('Typescript Checkout') {
                    steps {
                        checkout scm
                    }
                }
                stage('Typescript Build') {
                    steps {
                        dir("./DotnetTemplate.Web"){
                            sh "npm ci"
                            sh "npm run build"
                        }
                    }
                }
                stage('Typescript Lint') {
                    steps {
                        dir("./DotnetTemplate.Web"){
                            sh "npm run lint"
                        }
                    }
                }
                stage('Typescript Test') {
                    steps {
                        dir("./DotnetTemplate.Web"){
                            sh "npm test"
                        }
                    }
                }
            }
        }
        stage('dotNet'){
            agent {
                docker { image 'mcr.microsoft.com/dotnet/sdk:5.0' }
            }
            environment {
                DOTNET_CLI_HOME = "/tmp/DOTNET_CLI_HOME"
            }
            stages {
                stage('dotNet Checkout') {
                    steps {
                        checkout scm
                    }
                }
                stage('dotNet Build') {
                    steps {
                         sh "dotnet build"
                    }
                }
                stage('dotNet Test') {
                    steps {
                         sh "dotnet test"
                    }
                }
            }
        }
    }
    post{
        success{
            slackSend (color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }
        failure {
            slackSend (color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }
    }
}