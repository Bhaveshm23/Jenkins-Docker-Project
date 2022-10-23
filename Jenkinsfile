node{
    stage('git-checkout'){
        git 'https://github.com/Bhaveshm23/Jenkins-Docker-Project'
    }
  
    stage('docker-build-image'){
       def dockerhub-username = ''
        sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
        // To push image to dockerhub, we need to tag it with id: id = username in dockerhub
        sh 'docker image tag $JOB_NAME:v1.$BUILD_ID ${dockerhub-username}/$JOB_NAME:v1.$BUILD_ID'
        sh 'docker image tag $JOB_NAME:v1.$BUILD_ID ${dockerhub-username}/$JOB_NAME:latest' // to use latest image
    }
    stage('push images to DockerHub'){
        def dockerhub-username = ''
        withCredentials([string(credentialsId: 'DockerPasswd', variable: 'DockerPasswd')]) {
            // login to DockerHub
          sh "docker login -u ${dockerhub-username} -p ${DockerPasswd}"
            
            //push the images, one having version & the one having latest tag
            sh "docker image push ${dockerhub-username}/$JOB_NAME:v1.$BUILD_ID"
            sh "docker image push ${dockerhub-username}/$JOB_NAME:latest"
            
            // removing the  images from Jenkins server to avoid memory issues
            sh "docker image rm ${dockerhub-username}/$JOB_NAME:v1.$BUILD_ID ${dockerhub-username}/$JOB_NAME:latest"
        }   
        
        stage('Docker container deployemnt'){
            // will deploy image in webserver
            
             def dockerhub-username = ''
            //variables defined to run image, remove image, and remove container
            def docker_run = 'docker run -itd --name scriptedcontainer -p 9000:80 ${dockerhub-username}/docker-webapp' 
            def docker_rm_container = 'docker rm -f scriptedcontainer'
            def docker_rmi = 'docker rmi -f ${dockerhub-username}/docker-webapp'
            
            //login to web_server -> another server hosted on AWS
            sshagent(['web_server']) {
                // pull the image from jenkins server to this server
                
               sh "ssh -o StrictHostKeyChecking=no ec2-user@35.170.201.200 ${docker_rm_container}"
               sh "ssh -o StrictHostKeyChecking=no ec2-user@35.170.201.200 ${docker_rmi}"
               sh "ssh -o StrictHostKeyChecking=no ec2-user@35.170.201.200 ${docker_run}"
               
                
            }
            
        }
    
    }
    
}
