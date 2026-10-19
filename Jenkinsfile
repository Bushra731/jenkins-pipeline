pipeline {
    agent none

    environment {
        IMAGE_NAME = 'myapp'
    }

    stages {
        stage('Test') {
            agent { label 'linux-vm' }
            steps {
                checkout scm
                echo 'Testing on Linux VM (VMware)...'
                sh 'python3 f2.py'
            }
        }
        stage('Build') {
            agent { label 'linux-vm' }
            steps {
                checkout scm
                echo 'Building Docker image on Linux VM (VMware)...'
                sh 'python3 f1.py'
                sh 'docker build -t $IMAGE_NAME:$BUILD_NUMBER -t $IMAGE_NAME:latest .'
                sh 'docker images | grep $IMAGE_NAME'
                stash name: 'app', includes: '*.py, Dockerfile'
            }
        }
        stage('Deploy') {
            agent { label 'built-in' }
            steps {
                echo 'Deploying to AWS EC2...'
                unstash 'app'
                sh '''
                    docker build -t $IMAGE_NAME:$BUILD_NUMBER -t $IMAGE_NAME:latest .
                    rm -rf /opt/myapp/*
                    cp *.py /opt/myapp/
                    docker run --rm $IMAGE_NAME:latest
                '''
                echo 'Deployment to AWS EC2 completed'
            }
        }
    }
}
