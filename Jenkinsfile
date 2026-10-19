pipeline {
    agent any

    stages {
        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'python3 f2.py'
            }
        }
        stage('Build') {
            steps {
                echo 'Building application...'
                sh 'python3 f1.py'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying to AWS EC2...'
                sh 'python3 f3.py'
                sh '''
                    rm -rf /opt/myapp/*
                    cp *.py /opt/myapp/
                    ls -l /opt/myapp
                '''
                echo 'Deployment to AWS EC2 completed'
            }
        }
    }
}
