# Stage 1: Build
FROM openjdk:8-jdk-alpine
RUN addgroup -S notes && adduser -S notes -G notes

# Instalação do Maven
ENV MAVEN_VERSION 3.5.4
ENV MAVEN_HOME /usr/lib/mvn
ENV PATH $MAVEN_HOME/bin:$PATH
RUN wget -q http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    mv apache-maven-$MAVEN_VERSION /usr/lib/mvn

# Instalação de Git
RUN apk --update add git

# Configuração do ambiente de trabalho
RUN mkdir /opt/note && \
    chown -R notes:notes /opt/note
USER notes:notes
WORKDIR /opt/note

# Clone do repositório e construção do projeto
RUN git clone https://github.com/uprogramador/spring-boot-mysql-rest-api-tutorial.git /opt/note && \
    mvn package -Dmaven.test.skip=true

# Cópia do arquivo JAR e configuração
ARG JAR_FILE=*.jar
RUN cp ./target/easy-notes-1.0.0.jar /opt/note/easy-note.jar
COPY application.properties application.properties

# Comando de entrada
ENTRYPOINT ["java", "-jar", "/opt/note/easy-note.jar"]
