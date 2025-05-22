pipeline {
    agent {
        docker {
            image 'docker:latest'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    stages {
        stage('Clonar Repo') {
            steps {
                checkout scm
            }
        }
        stage('Construir Imagen Docker') {
            steps {
                sh 'docker build -t sample-app:latest .'
            }
        }
        stage('Desplegar contenedor') {
            steps {
                sh '''
                    docker rm -f sample-app || true
                    docker run -d -p 9999:9999 --name sample-app sample-app:latest
                '''
            }
        }
    }
}