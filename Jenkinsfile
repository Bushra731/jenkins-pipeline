pipeline {
    agent any

    environment {
        IMAGE_NAME = 'myapp'
    }

    stages {
        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'python3 f2.py'
            }
        }
        stage('Build') {
            steps {
                echo 'Building Docker image...'
                sh 'python3 f1.py'
                sh 'docker build -t $IMAGE_NAME:$BUILD_NUMBER -t $IMAGE_NAME:latest .'
                sh 'docker images | grep $IMAGE_NAME'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying to AWS EC2...'
                sh 'python3 f3.py'
                sh '''
                    rm -rf /opt/myapp/*
                    cp *.py /opt/myapp/
                    docker run --rm $IMAGE_NAME:latest
                '''
                echo 'Deployment to AWS EC2 completed'
            }
        }
    }
}
