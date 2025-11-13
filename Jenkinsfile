pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        IMAGE_NAME = "jenkins-flask"
        DOCKERHUB_USER = "kiranreddy120895"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/madhu-kiran12/jenkins-flask-pipeline.git'
            }
        }

        stage('Build') {
            steps {
                sh '''
                   python3 -m venv venv
                   . venv/bin/activate
                   pip install --upgrade pip
                   pip install -r app/requirements.txt
                   '''
                   }     
                 } 


        stage('Test') {
            steps {
                sh 'pytest app/test_app.py'
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    docker.build("${DOCKERHUB_USER}/${IMAGE_NAME}:${BUILD_NUMBER}")
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-creds') {
                        docker.image("${DOCKERHUB_USER}/${IMAGE_NAME}:${BUILD_NUMBER}").push()
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                docker stop flask-app || true
                docker rm flask-app || true
                docker run -d --name flask-app -p 5000:5000 ${DOCKERHUB_USER}/${IMAGE_NAME}:${BUILD_NUMBER}
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Deployment successful!'
        }
        failure {
            echo '❌ Pipeline failed!'
        }
    }
}

