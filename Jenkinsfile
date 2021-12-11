package br.eti.elio

@Library('CommonLib@main') _

def uuid = "${UUID.randomUUID().toString()}"
def jenkinsJobLabel = "${env.JOB_NAME}-${env.BUILD_NUMBER}"
def label = "jenkins-pipeline-${uuid}"

currentBuild.result = 'SUCCESS'

println "Label: ${label}"

pipeline {
    agent {
        docker { 
            image 'sonarsource/sonar-scanner-cli'
            label 'sonar-scanner-cli'
        }
        docker { 
            image 'node:17-alpine3.14'
            label 'node-17-alpine3.14'
        }
    }
    options {
        timeout(time: 60, unit: 'MINUTES')
        buildDiscarder(logRotator(numToKeepStr: '30'))
    }
    stages {
        stage('Pre Build') {
            steps {
                script {
                    sayHello 'Elio Severo Junior'
                    log.info 'Starting'
                    gitConfig(true)
                    log.info 'Done!'
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    ansiColor('xterm') {
                        log.info 'Starting'
                        sh 'npm install'
                        log.info 'Done!'
                    }
                }
            }
        }
        stage('Tests') {
            steps {
                script {
                    ansiColor('xterm') {
                        log.info 'Starting'
                        sh 'npm test'
                        log.info 'Done!'
                    }
                }
            }
        }
    }
    post {
        always {
            script {
                archiveArtifacts allowEmptyArchive: true, artifacts: "**/test-results/**/*.*", fingerprint: true
                junit allowEmptyResults: true, testResults: "**/test-results/junit.xml"
            }
        }
        success {
            script {
                currentBuild.result = 'SUCCESS'
            }
        }
        failure {
            script {
                currentBuild.result = 'FAILURE'
            }
        }
    }
}
