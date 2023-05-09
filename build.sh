/usr/libexec/java_home -V

export JAVA_HOME= `/usr/libexec/java_home -v 11.0.16.1`

echo "mvn clean install -DskipTests=true"
mvn clean install -DskipTests=true
echo "mvn -f release.xml prepare-package deb:package install"
mvn -f release.xml prepare-package deb:package install
