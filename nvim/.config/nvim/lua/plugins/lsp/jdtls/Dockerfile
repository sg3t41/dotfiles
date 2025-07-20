FROM eclipse-temurin:17-jre

# 必要なパッケージ
RUN apt-get update && \
    apt-get install -y wget unzip supervisor

WORKDIR /opt

# ===============================
# jdtlsのセットアップ
# ===============================
# JDTLSのバージョン
ENV JDTLS_VERSION 1.38.0
# JDTLSのビルドタイムスタンプ (URLに含まれる)
ENV JDTLS_TIMESTAMP 202407181522

# JDTLSをダウンロードして展開
RUN wget https://download.eclipse.org/jdtls/milestones/${JDTLS_VERSION}/jdt-language-server-${JDTLS_VERSION}-${JDTLS_TIMESTAMP}.tar.gz -O /tmp/jdtls.tar.gz && \
    mkdir /opt/jdtls && \
    tar -xzf /tmp/jdtls.tar.gz -C /opt/jdtls && \
    rm /tmp/jdtls.tar.gz

# ===============================
# spring-boot-language-server を JDTLS のプラグインとして追加
# ===============================
# Spring Boot LSのバージョン
ENV SBLS_VERSION 1.42.0
# Spring Boot LSをダウンロードしてJDTLSのpluginsディレクトリに配置
RUN wget https://repo.maven.apache.org/maven2/org/springframework/boot/spring-boot-language-server/${SBLS_VERSION}/spring-boot-language-server-${SBLS_VERSION}.jar \
    -O /opt/jdtls/plugins/spring-boot-language-server.jar

# ===============================
# サーバー起動スクリプト
# ===============================
COPY start_server.sh /opt/
RUN chmod +x /opt/start_server.sh

# ===============================
# supervisord設定
# ===============================
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/log/supervisor

# ポート開放
EXPOSE 2087

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]