FROM amazon/aws-for-fluent-bit:stable

# (Opcional) Atualizações de segurança
RUN yum --security update -y && yum clean all

# Copia o script de inicialização
COPY init.sh /fluent-bit/init.sh
RUN chmod +x /fluent-bit/init.sh

ENTRYPOINT ["/fluent-bit/init.sh"]
