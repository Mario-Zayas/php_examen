pipeline {
    agent none
    stages {
        stage('Testing') { 
            agent { 
                docker { 
                    image 'python:3'
                    args '-u root:root'
                }
            }
            stages {
                stage('Clone') {
                    steps {
                        git branch:'main', url:'https://github.com/Mario-Zayas/php_examen.git'
                    }
                }
            }
        }
        stage('Build and push') {
            agent any
            steps {
                script {
                    withDockerRegistry([credentialsId: 'DOCKER_HUB', url: '']) {
                        def dockerImage = docker.build("mzaygar034/php-examen:${env.BUILD_ID}")
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Remove image') {
            agent any
            steps {
                script {
                    sh "docker rmi mzaygar034/php-examen:${env.BUILD_ID}"
                }
            }
        }
        stage('SSH') {
            agent any
            steps{
                sshagent(credentials : ['CLAVE_SSH']) {
                    sh 'ssh -o StrictHostKeyChecking=no mario@maquinanodriza.mzgmaquina.es wget https://raw.githubusercontent.com/Mario-Zayas/php_examen/main/docker-compose.yaml -O docker-compose.yaml'
                    sh 'ssh -o StrictHostKeyChecking=no mario@maquinanodriza.mzgmaquina.es docker compose up -d --force-recreate'
                }
            }
        }
    }
    post {
        always {
            mail to: 'mzaygar034@gmail.com',
            subject: "Status of pipeline: ${currentBuild.fullDisplayName}",
            body: "${env.BUILD_URL} has result ${currentBuild.result}"
        }
    }
}
