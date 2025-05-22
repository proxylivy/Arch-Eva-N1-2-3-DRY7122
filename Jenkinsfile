pipeline {
    agent any
    stages {
        stage('Clonar repo') {
            steps {
                checkout scm
            }
        }
        stage('Construir Imagen Docker') {
            steps {
                script {
                    sh "docker build -t sample-app:latest ."
                }
            }
        }
        stage('Desplegar contenedor') {
            steps {
                script {
                    sh '''
                    docker rm -f sample-app || true
                    docker run -d -p 9999:9999 --name sample-app sample-app:latest
                    '''
                }
            }
        }
    }
}
