
pipeline {
    environment {
        IMAGE_NAME = "staticwebsite"
        DOCKERHUB_ID = "sadiabentouirad"
    
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
           stage('Run container based on builded image') {
              agent any
              steps {
                script {
                  sh '''
                      echo "Cleaning existing container if exist"
                      docker ps -a | grep -i $IMAGE_NAME && docker rm -f $IMAGE_NAME
                      docker run --name $IMAGE_NAME -d -p $APP_EXPOSED_PORT:$APP_CONTAINER_PORT -e PORT=$APP_CONTAINER_PORT ${DOCKERHUB_ID}/$IMAGE_NAME:$IMAGE_TAG
                      sleep 5
                  '''
                 }
              }
           }
}
