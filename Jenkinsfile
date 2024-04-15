
pipeline {
    environment {
        IMAGE_NAME = "staticwebsite"
        APP_CONTAINER_PORT = "5000"
        APP_EXPOSED_PORT = "80"
        IMAGE_TAG = "latest"
        STAGING = "staging-app-web"
        PRODUCTION = "production-app-web"
        DOCKERHUB_ID = "sadiabentouirad"
        DOCKERHUB_PASSWORD = credentials('dockerhub_id')
    }
    agent none
    stages {
       stage('Build image') {
           agent any
           steps {
              script {
                sh 'docker build -t ${DOCKERHUB_ID}/$IMAGE_NAME:$IMAGE_TAG .'
              }
           }
       }
}
