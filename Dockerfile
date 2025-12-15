FROM wpilib/roborio-cross-ubuntu:2025-24.04
RUN apt-get update && apt-get install -y gcc-multilib && rm -rf /var/lib/apt/lists/* 
ADD build-roborio.sh .
COPY luajit ./luajit
RUN cd luajit && sh ../build-roborio.sh && \
    cd .. && rm -rf luajit && rm -f build-roborio.sh \
    rm /opt/luabot/linuxathena/bin/luajit && \
    mv /opt/luabot/linuxathena/bin/luajit-2.1.ROLLING \
        /opt/luabot/linuxathena/bin/luajit
