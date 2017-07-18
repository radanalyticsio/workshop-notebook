FROM radanalyticsio/openshift-spark

USER root
RUN mkdir /data

ENV WORKER_UID=185

USER $WORKER_UID

ADD wikieod.parquet /data/wikieod.parquet
ADD msgs.parquet /data/msgs.parquet

USER root

RUN chown -R $WORKER_UID:root /data \
    && find /data -type d -exec chmod g+rwx,o+rx {} \; \
    && find /data -type f -exec chmod g+rw {} \;

USER $WORKER_UID

ENTRYPOINT ["/entrypoint"]

# Start the main process
CMD ["/opt/spark/bin/launch.sh"]