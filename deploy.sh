#!/bin/sh

unzip -o adf-essentials-client-ear.zip

touch dependencies.pom

find ./modules -name "*.jar"|while read fullname; do
  jarname=`basename $fullname .jar`
  echo "jar name : $jarname"

  ./mvnw -s ./settingsWithLocalMirror.xml deploy:deploy-file -Dfile=$fullname -DgroupId=oracle.essentials -DartifactId=$jarname -Dversion=12.2.1.3.0 -Dpackaging=oracle.essentials -DgeneratePom=true -DrepositoryId=enterprise-repo -Durl=http://localhost:8081/artifactory/virtual-maven-repositories
  echo "<dependency><groupId>oracle.essentials</groupId><artifactId>$jarname</artifactId><version>\${dependencies.version.adf.essentials}</version></dependency>" >> dependencies.pom

done
