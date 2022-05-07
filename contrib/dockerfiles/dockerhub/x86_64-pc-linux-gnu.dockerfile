FROM defichain-x86_64-pc-linux-gnu:dockerhub-latest as dh-build

FROM debian:10-slim
ENV PATH=/app/bin:$PATH
WORKDIR /app

COPY --from=dh-build /app/. ./

RUN useradd --create-home defi && \
    mkdir -p /data && \
    chown defi:defi /data && \
    ln -s /data /home/defi/.defi

VOLUME ["/data"]

USER defi:defi
CMD [ "/app/bin/defid" ]

EXPOSE 8855 8854 18855 18554 19555 19554
