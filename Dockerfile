version: '2.1' 
services:
  spark-master:
    image: bde2020/spark-master:2.3.0-hadoop2.7
    hostname: spark-master
    container_name: sdlspark-master
    domainname: factorizationDN
    networks:
      - factorization
    environment:
      - CORE_CONF_fs_defaultFS=hdfs://namenode:8020
      - YARN_CONF_yarn_resourcemanager_hostname=resourcemanager
      - SPARK_CONF_spark_eventLog_enabled=true
      - SPARK_CONF_spark_eventLog_dir=hdfs://namenode:8020/spark-logs
      - SPARK_CONF_spark_history_fs_logDirectory=hdfs://namenode:8020/spark-logs
    env_file:
      - ./hadoop.env
    ports:
        - "8080:8080"
        - "7077:7077"

  spark-worker:
    image: bde2020/spark-worker:2.3.0-hadoop2.7
    hostname: spark-worker
    domainname: factorization
    networks: 
      - factorization
    environment:
      - CORE_CONF_fs_defaultFS=hdfs://namenode:8020
      - YARN_CONF_yarn_resourcemanager_hostname=resourcemanager
      - SPARK_CONF_spark_eventLog_enabled=true
      - SPARK_CONF_spark_eventLog_dir=hdfs://namenode:8020/spark-logs
      - SPARK_CONF_spark_history_fs_logDirectory=hdfs://namenode:8020/spark-logs
      - SPARK_MASTER_URL=spark://spark-master:7077
    env_file:
      - ./hadoop.env

networks:
  factorization:
