 # Mini Projet Jenkins

  ![Mini project](https://github.com/Sadiaben/project2/blob/main/mini_projet_jenkins1.png "Mini project")
  
Prénom : Sadia

Nom : Ben touirad

Formation : 18ème Bootcamp DevOps d'Eazytraining

Période : mars-avril-mai

date : 22 avril 2024
 
**Objectives**

L'objectif de ce travail est de mettre en place un pipeline CI/CD pour une application de site web statique en utilisant Jenkins, Docker, GitHub, Heroku 

1. CODE 
Voici le code de l'application Static web site

        https://github.com/diranetafen/static-website-example.git
  
2. BUILD IMAGE
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
 3. Pour configurer un webhook GitHub afin de recevoir des notifications des événements de votre dépôt, vous pouvez suivre les étapes ci-dessous :
  
    Pour configurer l'intégration entre GitHub et Jenkins, vous pouvez utiliser Ngrok pour créer un tunnel sécurisé vers votre serveur Jenkins local. Ngrok fournit une adresse publique sécurisée à 
    laquelle GitHub peut envoyer des requêtes Webhook, permettant ainsi à Jenkins de réagir aux événements sur GitHub, tels que les pushes de code ou les créations de pull requests." 
  
    Exécutez la commande suivante dans votre terminal :
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



  
 4.  Configuration des identifiants dans Jenkins pour Heroku API Key et Slack Token

   Pour configurer les identifiants nécessaires à Jenkins pour l'API Key Heroku et le Token Slack, suivez ces étapes :

        Accès à Jenkins : Accédez à l'interface Jenkins.
        Accès aux paramètres administratifs :
        - Cliquez sur "Administrer Jenkins".
        Accès à la gestion de la sécurité :
        - Sélectionnez "Security".
        Gestion des identifiants :
        - Choisissez "credentials" dans le menu.
        Cliquez sur "add credentials " pour ajouter de nouveaux identifiants.
        -  Ajout des identifiants :
        Sélectionnez le type d'identifiant approprié, par exemple, "Secret texte".
        Remplissez le champ Secret avec votre API Key Heroku ou votre Token Slack.
        Remplissez le champ ID avec le id de credientials par exemple heroku_api_key.
        Cliquez sur "Ajouter".

        
 5. Création d'un fichier Jenkinsfile

   
   Pour organiser les pipelines dans Jenkins, vous pouvez créer un fichier Jenkinsfile. Voici comment structurer le Jenkinsfile :
   
   Partie CI Pipeline
   
   Cette partie contiendra les étapes suivantes :

      Build de l'image : Construction de l'image à partir du code source. // Dockerfile 
      Tests : Exécution des tests  //  curl http://172.17.0.1:80 | grep -q  "Dimension"
      Release : Publication de l'image construite dans un référentiel dockerhub. 

  
   ![dockerhub](https://github.com/Sadiaben/project2/blob/main/dockerhub.png "dockerhub")

   
  Partie CD Pipeline

  Cette partie contiendra les étapes suivantes :

      Staging : Déploiement sur un environnement de staging:   utilisation heroku.
      Production : Déploiement sur l'environnement de production:   utilisation heroku.
   
   ![jenkins](https://github.com/Sadiaben/project2/blob/main/jenkins.png "jenkins")

   ![Heroku](https://github.com/Sadiaben/project2/blob/main/heroku.png "Heroku")
