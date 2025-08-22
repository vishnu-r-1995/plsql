FROM gvenzl/oracle-free:23.5-slim

# Install SQL*Plus client only
USER root
RUN microdnf install -y oracle-instantclient-sqlplus && microdnf clean all
USER oracle

WORKDIR /scripts
ENTRYPOINT ["sqlplus"]