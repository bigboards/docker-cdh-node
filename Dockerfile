# Pull base image.
#FROM bigboards/cdh-base-__arch__
FROM bigboards/cdh-base-x86_64

MAINTAINER bigboards
USER root 

RUN apt-get update && apt-get install -y hadoop-yarn-nodemanager hadoop-hdfs-datanode hadoop-mapreduce 

ADD docker_files/datanode-run.sh /apps/datanode-run.sh
ADD docker_files/nodemanager-run.sh /apps/nodemanager-run.sh
RUN chmod a+x /apps/*.sh

# internal ports
EXPOSE 8040 8041

# external ports
EXPOSE 8042 50010 50020 50075 1004 1006 

CMD ["/bin/bash"]
