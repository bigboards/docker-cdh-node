# Pull base image.
FROM bigboards/cdh-base-x86_64

MAINTAINER bigboards
USER root 

RUN apt-get update \
    && apt-get install -y hadoop-yarn-nodemanager hadoop-hdfs-datanode hadoop-mapreduce \ 
                          build-essential gfortran python libssl-dev libffi-dev libblas-dev \ 
                          liblapack-dev libatlas-base-dev libpng-dev libjpeg8-dev \
                          libfreetype6-dev python-pip python-dev pkg-config \
    && pip install --upgrade pip Cython ConfigParser requests numpy scipy pandas scikit-learn matplotlib sqlalchemy seaborn ibis py4j sparkts \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives/*

ADD docker_files/datanode-run.sh /apps/datanode-run.sh
ADD docker_files/nodemanager-run.sh /apps/nodemanager-run.sh
RUN chmod a+x /apps/*.sh
RUN chown root:root /var/run/hadoop-hdfs && chmod g+rwx /var/run/hadoop-hdfs

# declare the volumes
RUN mkdir /etc/hadoop/conf.bb && \
    update-alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.bb 1 && \
    update-alternatives --set hadoop-conf /etc/hadoop/conf.bb
VOLUME /etc/hadoop/conf.bb

# internal ports
EXPOSE 8040 8041

# external ports
EXPOSE 8042 50010 50020 50075 1004 1006 

CMD ["/bin/bash"]
