def set_branch_name() {
    return env.GIT_BRANCH.replace("/", "_")
}

def verify_image(filename) {
    wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'XTerm']) {
        sh '''
        #!/usr/env/bin bash
        docker run --rm \
        -e BRANCH_NAME \
        -e IMAGE_TAG_VERSION \
        -e TARGET_ENV \
        -v `pwd`:/home/tools/data \
        mojdigitalstudio/hmpps-packer-builder \
        bash -c 'USER=`whoami` packer validate ''' + filename + "'"
    }
}

def build_image(filename) {
    wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'XTerm']) {
        sh '''
        #!/usr/env/bin bash
        docker run --rm \
        -e BRANCH_NAME \
        -e IMAGE_TAG_VERSION \
        -e TARGET_ENV \
        -v `pwd`:/home/tools/data \
        mojdigitalstudio/hmpps-packer-builder \
        bash -c 'packer build ''' + filename + "'"
        
    }
}

def get_git_latest_master_tag() {
    git_branch = sh (
                    script: """docker run --rm \
                                    -v `pwd`:/home/tools/data \
                                    mojdigitalstudio/hmpps-packer-builder \
                                    bash -c 'git describe --tags --exact-match'""",
                    returnStdout: true
                 ).trim()    
    return git_branch
}

def set_tag_version() {
    branchName = set_branch_name()
    if (branchName == "master") {
        git_tag = get_git_latest_master_tag()
    }
    else {
        git_tag = '0.0.0'
    }
    return git_tag
}

pipeline {
    agent { label "jenkins_slave"}

    options {
        ansiColor('xterm')
    }

    triggers {
        cron(env.BRANCH_NAME=='master'? 'H 4 * * 7': '')
    }

    environment {
        AWS_REGION        = "eu-west-2"
        BRANCH_NAME       = set_branch_name()
        IMAGE_TAG_VERSION = set_tag_version()
    }

    stages {
        stage ('Notify build started') {
            steps {
                slackSend(message: "Build Started - ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL.replace(':8080','')}|Open>)")
            }
        }

        stage('Echo Branch name and Tag') {
            steps {
                sh('echo $BRANCH_NAME')
                sh('echo $IMAGE_TAG_VERSION')
            }
        }

        stage('Verify PSN Proxy AMI') {
            parallel {
                stage('Verify CentOS PSN Proxy') { steps { script {verify_image('psn_proxy.json')}}}
            }
        }

        stage('Build PSN Proxy AMI') {
            parallel {
                stage('Build CentOS PSN Proxy AMI') { steps { script {build_image('psn_proxy.json')}}}
            }
        }
    }

    post {
        success {
            slackSend(message: "Build completed - ${env.JOB_NAME} ${env.BUILD_NUMBER}", color: 'good')
        }
        failure {
            slackSend(message: "Build failed - ${env.JOB_NAME} ${env.BUILD_NUMBER}", color: 'danger')
        }
    }
}

