pipeline {
    agent any
    stages {
        stage('Subir imagen') {
            steps {
                script {
                    withDockerRegistry([credentialsId: 'DOCKER_HUB', url: '']) {
                        def dockerImage = docker.build("mzaygar034/php-examen:${env.BUILD_ID}")
                        dockerImage.push()
                    }
                    sh "docker rmi mzaygar034/php-examen:${env.BUILD_ID}"
                }
            }
        }
        stage('SSH') {
            steps {
                script {
                    sshagent(credentials: ['CLAVE_SSH']) {
                        sh "ssh -o StrictHostKeyChecking=no mario@maquinanodriza.mzgmaquina.es wget https://github.com/Mario-Zayas/php_examen.git -O docker-compose.yaml"
                        sh "ssh -o StrictHostKeyChecking=no mario@maquinanodriza.mzgmaquina.es docker-compose up -d --force-recreate"
                    }
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
