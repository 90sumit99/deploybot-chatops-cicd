pipeline {
  agent any
  options { disableConcurrentBuilds(); timestamps(); timeout(time: 15, unit: 'MINUTES') }
  parameters { choice(name: 'ACTION', choices: ['CI','DEPLOY','ROLLBACK'], description: 'Operation'); string(name: 'VERSION', defaultValue: 'v1', description: 'Version'); booleanParam(name: 'SIMULATE_FAILURE', defaultValue: false, description: 'Fail health check') }
  stages {
    stage('Validate') { steps { sh '''case "$VERSION" in v[0-9]* ) ;; *) echo "Invalid version"; exit 1;; esac
echo "$VERSION" | grep -Eq '^v[0-9]+(\\.[0-9]+){0,2}$' '''; script { currentBuild.displayName = "#${env.BUILD_NUMBER} ${params.ACTION} ${params.VERSION}" } } }
    stage('Checkout') { steps { checkout scm } }
    stage('Test') { when { expression { params.ACTION in ['CI','DEPLOY'] } } steps { sh 'docker build --target test -t deploybot-app:test app/' } }
    stage('Build') { when { expression { params.ACTION in ['CI','DEPLOY'] } } steps { sh 'docker build --target runtime --build-arg APP_VERSION="$VERSION" -t "deploybot-app:$VERSION" app/' } }
    stage('Deploy') { when { expression { params.ACTION == 'DEPLOY' } } steps { sh './scripts/deploy.sh "$VERSION" "$SIMULATE_FAILURE"' } }
    stage('Rollback') { when { expression { params.ACTION == 'ROLLBACK' } } steps { sh './scripts/rollback.sh' } }
    stage('Verify') { when { expression { params.ACTION in ['DEPLOY','ROLLBACK'] } } steps { sh './scripts/healthcheck.sh "$(cat /var/jenkins_home/deploy-state/current)"' } }
  }
  post { success { script { currentBuild.description = "${params.ACTION} ${params.VERSION}: success" } } failure { script { currentBuild.description = "${params.ACTION} ${params.VERSION}: failed" } } always { echo 'DeployBot pipeline finished' } }
}
