# MiniProjetJenkins

  ![Mini project](https://github.com/Sadiaben/project2/blob/main/mini_projet_jenkins1.png "Mini project")
1. CODE 
Voici le code de l'application Static web site 
   https://github.com/diranetafen/static-website-example.git
2. BUILD IMAGE
   Créer un fichier Dockerfile: 
     ```
    #DockerFile Satatic web site
      FROM nginx
      LAbel maintainer= "Sadia ben touirad"
      RUN apt-get update &&\
          apt-get upgarde -y &&\
          apt-get install git -y
      RUN rm -rf /usr/share/nginx/html/* &&\
          git clone https://github.com/diranetafen/static-website-example.git /usr/share/nginx/html
      CMD nginx -g 'daemon off;'
     ```
   créer un fichier Jenkinsfile 
   
   ```
   pipeline {
    environment {
        IMAGE_NAME = "staticwebsite"
        APP_CONTAINER_PORT = "5000"
        APP_EXPOSED_PORT = "80"
        IMAGE_TAG = "latest"
        DOCKERHUB_ID = "choco1992"
        DOCKERHUB_PASSWORD = credentials('dockerhub_password')
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
   


