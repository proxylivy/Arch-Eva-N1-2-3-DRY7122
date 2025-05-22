pipeline {
    /* 1️⃣  Agente Docker con CLI y acceso al sock del host */
    agent {
        docker {
            image 'docker:24-cli'              // CLI moderno ya incluido
            args  '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    /* 2️⃣  Opciones globales */
    options {
        skipDefaultCheckout(true)             // evita el checkout “automático” (causa del error 128)
        timeout(time: 20, unit: 'MINUTES')    // evita loops infinitos si algo cuelga
    }

    /* 3️⃣  Variables reutilizables */
    environment {
        IMAGE_NAME      = 'sample-app'
        IMAGE_TAG       = 'latest'
        CONTAINER_NAME  = 'sample-app'
        APP_PORT        = '9999'
    }

    /* 4️⃣  Fases */
    stages {

        stage('Workspace limpio') {
            steps {
                deleteDir()                   // garantiza directorio vacío
            }
        }

        stage('Checkout') {
            steps {
                checkout scm                  // clona repo indicado en la config del job
            }
        }

        stage('Build Docker') {
            steps {
                sh '''
                    echo "🛠  Construyendo imagen ${IMAGE_NAME}:${IMAGE_TAG}..."
                    docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                '''
            }
        }

        stage('Deploy contenedor') {
            steps {
                sh '''
                    echo "🚀 Desplegando contenedor ${CONTAINER_NAME}..."
                    docker rm -f ${CONTAINER_NAME} || true
                    docker run -d --name ${CONTAINER_NAME} \
                               -p ${APP_PORT}:${APP_PORT} \
                               ${IMAGE_NAME}:${IMAGE_TAG}
                '''
            }
        }

        stage('Health-check') {
            steps {
                script {
                    sleep 5                   // pequeño respiro al contenedor
                    sh  "curl -sSf http://localhost:${APP_PORT} | head -n 5"
                }
            }
        }
    }

    /* 5️⃣  Limpieza / info extra */
    post {
        always {
            sh 'docker ps -a'
        }
        cleanup {
            sh 'docker system prune -f'
        }
    }
}
