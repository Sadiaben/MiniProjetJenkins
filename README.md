# MiniProjetJenkins

  ![Mini project](https://github.com/Sadiaben/project2/blob/main/mini_projet_jenkins1.png "Mini project")
1. CODE 
Voici le code de l'application Static web site 
   https://github.com/diranetafen/static-website-example.git
   créer un nginx.conf 
3. BUILD IMAGE
   Créer un fichier Dockerfile: 
     ```
    #DockerFile Satatic web site
     FROM nginx:1.21.1
    LABEL maintainer="Sadia ben touirad"
    RUN apt-get update && \
        apt-get upgrade -y && \
        apt-get install -y curl && \
        apt-get install -y git
    RUN rm -Rf /usr/share/nginx/html/* &&\
        git clone https://github.com/diranetafen/static-website-example.git /usr/share/nginx/html
    COPY nginx.conf /etc/nginx/conf.d/default.conf
    CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
     ```
    4. Pour configurer un webhook GitHub afin de recevoir des notifications des événements de votre dépôt, vous pouvez suivre les étapes ci-dessous :
        Utilisation de Ngrok pour une adresse publique :Utilisez Ngrok pour obtenir une adresse publique sécurisée à laquelle GitHub peut envoyer des requêtes. Exécutez la commande suivante dans votre terminal :
      ```
        ngrok http http://localhost:8080
      ```
   Vous obtiendrez une adresse Ngrok, par exemple : https://437e-45-80-10-80.ngrok-free.app.
   Configuration dans GitHub :
   
        Accédez aux paramètres (settings) de votre projet sur GitHub.
        Sélectionnez l'onglet "Webhooks".
        Cliquez sur "Add webhook".
        Dans "Payload URL", entrez l'URL fournie par Ngrok avec le suffixe /github-webhook/, par exemple : https://437e-45-80-10-80.ngrok-free.app/github-webhook/.
        Sélectionnez "Content type" comme application/json.
        Enregistrez vos modifications.
           
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
   


