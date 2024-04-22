/* import shared library */
@Library('shared-library')_
pipeline {
    environment {
        IMAGE_NAME = "staticwebsite"
        IMAGE_TAG = "latest"
        DOCKERHUB_ID = "sadiabentouirad"
        STAGING = "sadia-staging"
        PRODUCTION = "sadia-prod"
    
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

      stage('Test image') {
           agent any
           steps {
              script {
                sh '''
                    curl http://172.17.0.1:80 | grep -q  "Dimension"
                '''
              }
           }
      }
      stage('Clean Container') {
          agent any
          steps {
             script {
               sh '''
                 docker stop $IMAGE_NAME
                 docker rm $IMAGE_NAME
               '''
             }
          }
     }

     stage ('Login and Push Image on docker hub') {
          agent any
        environment {
           DOCKERHUB_PASSWORD  = credentials('dockerhub_id')
        }            
          steps {
             script {
               sh '''
                   echo $DOCKERHUB_PASSWORD_PSW | docker login -u $DOCKERHUB_ID --password-stdin
                   docker push $DOCKERHUB_ID/$IMAGE_NAME:$IMAGE_TAG
               '''
             }
          }
      }    
     

    stage('Push image in staging and deploy it') {
       when {
              expression { GIT_BRANCH == 'origin/main' }
            }
      agent any
      environment {
          HEROKU_API_KEY = credentials('heroku_api_key')
      }  
      steps {
          script {
            sh '''
              npm i -g heroku@7.68.0
              heroku container:login
              heroku create $STAGING || echo "project already exist"
              heroku container:push -a $STAGING web
              heroku container:release -a $STAGING web
            '''
          }
        }
     } 
     stage('Push image in production and deploy it') {
       when {
              expression { GIT_BRANCH == 'origin/main' }
            }
      agent any
      environment {
          HEROKU_API_KEY = credentials('heroku_api_key')
      }  
      steps {
          script {
            sh '''
              
              npm i -g heroku@7.68.0
              heroku container:login
              heroku create $PRODUCTION || echo "project already exist"
              heroku container:push -a $PRODUCTION web
              heroku container:release -a $PRODUCTION web
            '''
          }
        }
     }
  }
  post {
    always {
      script {
        slackNotifier currentBuild.result
      }
    }  
  }
}

