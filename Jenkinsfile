node {
    def buildImage = null
    def dockerArgs = null
    def slackChannel = null
    def checkoutTagName = null
    def APP_NAME = 'latam-cms'
    def DOCKERFILE_NAME = 'Dockerfile'
    def gitlabBranch = 'master'
    def gitlabAfter = 'master'
    def gitlabActionType = 'TAG_PUSH_'
    def gitlabSourceRepoHttpUrl = 'https://2a92f2776c319577df3c7d042f16c4f67509c8f4:x-oauth-basic@github.com/gustavonq/headless-cms.git'
    
    try {


        if (env.DOCKER_ARGS) {
            println ("${DOCKER_ARGS}")
            dockerArgs = "${DOCKER_ARGS}".replace('\'', '').split(',')
        }
        
        stage('Checkout') {
            if ("${gitlabActionType}" == "TAG_PUSH"){
                checkout([$class: 'GitSCM',
                          branches: [[name: "${gitlabBranch}"]]]
                )
                checkoutTagName = "${gitlabBranch}".replace("refs/tags/", "") 
                println ("TAG NAME: " + checkoutTagName)
            }else{
                checkout([$class: 'GitSCM',
                    branches: [[name: "${gitlabAfter}"]],
                    userRemoteConfigs: [[url: "${gitlabSourceRepoHttpUrl}"]]]
                )
            }
        }
    
        stage ("Image Build"){ 
            if (dockerArgs){
                def args = ""
                
                for (entry in dockerArgs){
                    def keyValue = "${entry.value}".split(':') 
                    args = "${args} --build-arg \"" + "${entry.value}".replace(':', '=') + "\""
                }
    
                buildImage = docker.build("${APP_NAME}", " ${args} -f ${DOCKERFILE_NAME} .")
            }else{
                buildImage = docker.build("${APP_NAME}", " -f ${DOCKERFILE_NAME} .")
            }
        }

    } catch (e) {
        // If there was an exception thrown, the build failed
        currentBuild.result = "FAILED"
        throw e
    } finally {

    }
    
}
