node ("gcp") {
    def buildImage = null
    def dockerArgs = null
    def slackChannel = null
    def checkoutTagName = null
    
    try {


        if (env.DOCKER_ARGS) {
            println ("${DOCKER_ARGS}")
            dockerArgs = "${DOCKER_ARGS}".replace('\'', '').split(',')
        }
        
        stage('Checkout') {
            if ("${gitlabActionType}" == "TAG_PUSH"){
                checkout([$class: 'GitSCM',
                    branches: [[name: "${gitlabBranch}"]],
                    userRemoteConfigs: [[url: "${gitlabSourceRepoHttpUrl}", credentialsId: 'af913f96-7a89-4501-873d-1b3c63c5294b']]]
                )
                checkoutTagName = "${gitlabBranch}".replace("refs/tags/", "") 
                println ("TAG NAME: " + checkoutTagName)
            }else{
                checkout([$class: 'GitSCM',
                    branches: [[name: "${gitlabAfter}"]],
                    userRemoteConfigs: [[url: "${gitlabSourceRepoHttpUrl}", credentialsId: 'af913f96-7a89-4501-873d-1b3c63c5294b']]]
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
    
    cleanWs()
    
}
