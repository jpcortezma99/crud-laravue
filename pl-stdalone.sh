#!/bin/bash

project_name=PROYECTO-VERASCRIPT
version="1.2"
branch="develop"                                    #${bamboo.planRepository.branchName}
veracode_id=02a927bf7c7ec475ddae7e31e09f136a        #${bamboo.veracode_id}
veracode_key=4c3616d757dc04a8a75aa20453d60c030991eea0ab68bc05f8233aeae6bb8b38e70715cc711910d8927996f4d8a1e0f2844350e4bee50c50c2cee79447fb549e       #${bamboo.veracode_key}
filepath=$(find ./ -type f -iname "*.?ar")          #$(find ${bamboo.build.working.directory}/target -type f -iname "*.?ar")
 
# Patrones de branch
regex_policyscan="^master|release_.*|build-ci$"
regex_sandbox="^develop.*$"

# definiciones estaticas
pipeline_url=https://downloads.veracode.com/securityscan/pipeline-scan-LATEST.zip
wrapper_url=https://repo1.maven.org/maven2/com/veracode/vosp/api/wrappers/vosp-api-wrappers-java/20.8.7.1/vosp-api-wrappers-java-20.8.7.1.jar
pipeline_path=/tmp/pipeline-scan.jar
wrapper_path=/tmp/wrapper.jar
cpath=$(pwd)
tmpfile=$(mktemp)
apiUrl=https://pruebasdepana.atlassian.net/rest/api/2

veracode_id=02a927bf7c7ec475ddae7e31e09f136a
veracode_key=4c3616d757dc04a8a75aa20453d60c030991eea0ab68bc05f8233aeae6bb8b38e70715cc711910d8927996f4d8a1e0f2844350e4bee50c50c2cee79447fb549e
wrapper_url=https://repo1.maven.org/maven2/com/veracode/vosp/api/wrappers/vosp-api-wrappers-java/20.8.7.1/vosp-api-wrappers-java-20.8.7.1.jar

jira_key=AS
issuetype=10003 #en tu caso 13701
apiUserJira=jcortez@makros.cl
apiTokenJira=NMIB35MM4nyWmjxvK4SL0278






#filepath=$(find ./ -type f -iname "*.?ar")  
#pipeline_path=/tmp/pipeline-scan.jar


if [[ ! -f "$wrapper_path" ]]; then
    curl $wrapper_url >> $wrapper_path
fi


#POLICY SCAN

allApps=$(java -jar $wrapper_path -vid $veracode_id -vkey $veracode_key -action getapplist > appsandids.xml)
appid=$(grep -i $project_name appsandids.xml | sed -n 's/.*app_id=//p'  | awk '{ print $1 }' |  sed -e 's/^.//' -e 's/.$//')
getBuildInfo=$(java -jar $wrapper_path -vid $veracode_id -vkey $veracode_key -action getbuildinfo -appid $appid > appsandids.xml)
buildid=$(grep -i $appid appsandids.xml | sed -n 's/.*build_id=//p' | awk '{ print $1 }' | sed -e 's/^.//' -e 's/.$//')
rm pdf_report.pdf
java -jar $wrapper_path -vid $veracode_id -vkey $veracode_key -action summaryreport -buildid $buildid -format pdf -outputfilepath pdf_report.pdf

#echo '{"fields": {"project":{"key": "'$jira_key'"},"summary": "REPORTE VERACODE POLICY SCAN PDF","description": "CONSULTE PDF ADJUNTO","issuetype": {"id": "13701"}}}' > json.txt
#issue_id=$(curl -u ${bamboo.bamboo.jira_username}:${bamboo.bamboo.jira_password} -X POST --data @json.txt -H 'Content-Type: application/json' $apiUrl/issue | jq '.id | tonumber')
jira_key=AS
issuetype=10003 #en tu caso 13701
echo '{"fields": {"project":{"key":"'$jira_key'"},"summary": "Reporte Veracode Policy Scan:'$project_name'-'$branch'-'$version'","description": "Se ha adjuntado reporte Veracode Sandbox","issuetype": {"id": "'$issuetype'"}}}' > json.txt
issue_id=$(curl -u ${apiUserJira}:${apiTokenJira} -X POST --data @json.txt -H 'Content-Type: application/json' $apiUrl/issue | jq '.id | tonumber')
curl --request POST \
        --url "$apiUrl/issue/$issue_id/attachments" \
        --user "$apiUserJira:$apiTokenJira" \
        --header "X-Atlassian-Token: no-check" \
        -F 'file=@pdf_report.pdf'

exit


#SANDBOX SCAN
#Todas las aplicaciones
allApps=$(java -jar $wrapper_path -vid $veracode_id -vkey $veracode_key -action getapplist > issues.xml)
#Encuentra la aplicacion que contenga el $project_name
appid=$(grep -i $project_name issues.xml | sed -n 's/.*app_id=//p'  | awk '{ print $1 }' |  sed -e 's/^.//' -e 's/.$//')
#Obten todos los sandboxes referentes a $appid y reemplazalos en el archivo issues.xml 
getBuildInfo=$(java -jar $wrapper_path -vid $veracode_id -vkey $veracode_key -action getsandboxlist -appid $appid > issues.xml)
#Obten el id segun el nombre del sandbox $project_name-$branch. // PROYECTO-VERASCRIPT-develop
#cat issues.xml #para comprobar que trae los sandbox
sandboxid=$(grep -i $project_name-$branch issues.xml | sed -n 's/.*sandbox_id=//p' | awk '{ print $1 }' | sed -e 's/^.//' -e 's/.$//')

java -jar $wrapper_path -vid $veracode_id -vkey $veracode_key -action getbuildinfo -appid $appid -sandboxid $sandboxid > issues.xml
buildid=$(grep -i $sandboxid  issues.xml | sed -n 's/.*build_id=//p' | awk '{ print $1 }' | sed -e 's/^.//' -e 's/.$//')
java -jar $wrapper_path -vid $veracode_id -vkey $veracode_key -action summaryreport -buildid $buildid -format pdf -outputfilepath pdf_report.pdf

echo '{"fields": {"project":{"key": "'$jira_key'"},"summary": "REPORTE VERACODE POLICY SCAN PDF","description": "CONSULTE PDF ADJUNTO","issuetype": {"id": "10003"}}}' > json.txt
issue_id=$(curl -u ${apiUserJira}:${apiTokenJira} -X POST --data @json.txt -H 'Content-Type: application/json' $apiUrl/issue | jq '.id | tonumber')
curl --request POST \
        --url "$apiUrl/issue/$issue_id/attachments" \
        --user "$apiUserJira:$apiTokenJira" \
        --header "X-Atlassian-Token: no-check" \
        -F 'file=@pdf_report.pdf'


