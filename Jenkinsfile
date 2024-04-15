
pipeline {
    environment {
        IMAGE_NAME = "staticwebsite"
        IMAGE_TAG = "latest"
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
                      echo "Clean Environment"
                      docker rm -f $IMAGE_NAME || echo "container does not exist"
                      docker run --name $IMAGE_NAME -d -p 80:5000 -e PORT=5000 ${DOCKERHUB_ID}/$IMAGE_NAME:$IMAGE_TAG
                      sleep 5
                  '''
                 }
              }
           }
}
