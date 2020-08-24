# Get Linux
FROM centos:7

# Install Java
RUN yum update -y \
&& yum install java-1.8.0-openjdk -y \
&& yum clean all \
&& rm -rf /var/cache/yum

# Set JAVA_HOME environment var
ENV JAVA_HOME="/usr/lib/jvm/jre-openjdk"

# Install Python
RUN yum install python3 -y \
&& pip3 install --upgrade pip setuptools wheel \
&& yum clean all \
&& ln -s pip3 /usr/bin/pip \
&& ln -sf /usr/bin/python3 /usr/bin/python \
&& rm -rf /var/cache/yum

ADD requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

ENV PARAMS=""

ENV TZ=PRC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ADD xxl-job-executor-sample-springboot-*.jar /app.jar

ENTRYPOINT ["sh","-c","java -jar $JAVA_OPTS /app.jar $PARAMS"]