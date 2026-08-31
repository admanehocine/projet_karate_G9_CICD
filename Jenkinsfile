pipeline {
    agent any

    stages {
        stage('global stage') {
            agent {
                docker {
                    image 'maven:ibmjava'
                    args '-u root --entrypoint='
                }
            }
            stages {
                stage('install deps') {
                    steps { sh 'mvn clean compile' }
                }
                stage('run user test') {
                    steps {
                        sh 'mvn test -Dmaven.test.failure.ignore=true'
                    }
                    post {
                        always {
                            stash name: 'allure-results',
                                  includes: 'allure-results/**',
                                  allowEmpty: true
                        }
                    }
                }
            }
        }
    }
    post {
        always {
            script {
                try { unstash 'allure-results' }
                catch (e) { echo "Pas de résultats Allure" }
            }
            archiveArtifacts artifacts: 'allure-results/**', allowEmptyArchive: true
            allure includeProperties: false, jdk: '', results: [[path: 'allure-results']]
        }
    }
}
