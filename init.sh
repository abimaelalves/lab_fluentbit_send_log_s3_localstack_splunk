#!/bin/bash
set -ex

echo "🔧 Executando init.sh - envio para S3 via LocalStack"

touch /extra.conf
echo "Criando arquivo de configuração do Fluent Bit"

cat /extra.conf

echo ""
echo ""
echo ""
echo ""

cat > /extra.conf <<EOF
[SERVICE]
    Flush        1
    Log_Level    info
    Parsers_File parsers.conf

[INPUT]
    Name         dummy
    Tag          test.logs
    Dummy        {"message": "Test log from Fluent Bit!"}

[OUTPUT]
    Name         stdout
    Match        *


[OUTPUT]
    Name         s3
    Match        test.*
    Bucket       meubucket
    Region       us-east-1
    Endpoint     http://localstack:4566
    tls          Off
    use_put_object On
    total_file_size 100M
    upload_timeout 10s
    Auto_Retry_Requests On
    S3_Key_Format     /clientes_impactados/%Y/%m/%d/%H/caronte-log-$UUID.json

[OUTPUT]
    Name              splunk
    Match             *
    Host              splunk
    Port              8088
    TLS               On
    tls.verify        Off
    Splunk_Token      token-fluentbit-test
    Splunk_Send_Raw   On
    event_host        fluentbit
    event_source      fluentbit
    event_sourcetype  httpevent
    event_index       main




EOF

echo "executando o comando do Fluent Bit com a configuração gerada"
sleep 5
/fluent-bit/bin/fluent-bit -c /extra.conf 

