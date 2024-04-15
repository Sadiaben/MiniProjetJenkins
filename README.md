# MiniProjetJenkins

  ![Mini project](https://github.com/Sadiaben/project2/blob/main/mini_projet_jenkins1.png "Mini project")
1. CODE 
Voici le code de l'application Static web site 
   https://github.com/diranetafen/static-website-example.git
2. BUILD IMAGE
   Créer un fichier Dockerfile pour faire le build de l'image
     – Cloner le projet dans un répertoire /miniprojet-docker
  
      1 git clone https://github.com/diranetafen/student-list.git

   #DockerFile Satatic web site
FROM nginx
LAbel maintainer= "Sadia ben touirad"
RUN apt-get update &&\
    apt-get upgarde -y &&\
    apt-get install git -y
RUN rm -rf /usr/share/nginx/html/* &&\
    git clone https://github.com/diranetafen/static-website-example.git /usr/share/nginx/html
CMD nginx -g 'daemon off;'
   


