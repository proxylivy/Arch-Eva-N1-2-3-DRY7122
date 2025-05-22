pipeline {
    agent any            // Usa el nodo Jenkins por defecto

    stages {
        stage('Deploy Dozzle') {
            steps {
                sh '''
                  # Detén y elimina contenedor previo (si existía)
                  docker rm -f dozzle || true

                  # Arranca Dozzle
                  docker run -d --name dozzle -p 3003:8080 amir20/dozzle:latest
                '''
            }
        }
    }
}
