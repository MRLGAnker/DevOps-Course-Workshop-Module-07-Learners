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
                        dir("./DotnetTemplate.Web")
                        sh "npm ci"
                        sh "npm run build"
                    }
                }
                stage('Typescript Lint') {
                    steps {
                        dir("./DotnetTemplate.Web")
                        sh "npm run lint"
                    }
                }
                stage('Typescript Test') {
                    steps {
                        dir("./DotnetTemplate.Web")
                        sh "npm test"
                    }
                }
            }
        }
    }
}