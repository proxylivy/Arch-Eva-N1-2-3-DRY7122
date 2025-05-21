pipeline {
    agent any

    environment {
        // Cambia a la IP real de tu host si no es 192.168.18.24
        HOST_IP = "192.168.18.13"
        PORT    = "3003"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm   // clona la rama main
            }
        }

        stage('Deploy Dozzle') {
            steps {
                echo '🚀 Levantando/actualizando Dozzle…'
                sh '''
                  # Siempre traemos la última imagen
                  docker compose pull dozzle
                  # Apagamos contenedor previo (si existe) y levantamos de nuevo
                  docker compose down
                  docker compose up -d
                '''
            }
        }

        stage('Test') {
            steps {
                echo '🔎 Verificando que Dozzle responda…'
                // Petite espera para que el contenedor arranque
                sh '''
                  for i in {1..10}; do
                    curl -fsS "http://$HOST_IP:$PORT" >/dev/null && exit 0
                    sleep 2
                  done
                  echo "Dozzle no responde en $HOST_IP:$PORT" >&2
                  exit 1
                '''
            }
        }
    }

    post {
        success { echo '✅ Deploy OK: Dozzle en producción local' }
        failure { echo '❌ Deploy fallido' }
    }
}
