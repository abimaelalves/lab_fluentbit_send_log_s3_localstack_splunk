# 🔍 Observabilidade com Fluent Bit, Splunk e LocalStack (S3)

Este laboratório demonstra como configurar um pipeline local de logs com **Fluent Bit**, onde os logs são enviados simultaneamente para:

- 📦 **S3 (via LocalStack)** — simulação do bucket AWS
- 🟢 **Splunk** — usando o HTTP Event Collector (HEC)

---

## ✅ Pré-requisitos

- Docker
- Docker Compose

---

## 🚀 Execução

1. Clone este repositório e acesse o diretório do projeto:

```bash
git clone https://github.com/abimaelalves/lab_fluentbit_send_log_s3_localstack_splunk.git
cd lab_fluentbit_send_log_s3_localstack_splunk
```

2. Dê permissão de execução aos scripts:

```bash
chmod +x *.sh
```

3. Inicie o ambiente completo:

```bash
./start_lab.sh
```

---

## 📦 Estrutura do Projeto

```
.
├── Dockerfile                  # Imagem customizada do Fluent Bit
├── init.sh                    # Script de boot que gera fluent-bit.conf dinamicamente
├── parsers.conf               # Parsers opcionais
├── docker-compose.yml         # Define Fluent Bit, Splunk e LocalStack
├── start_lab.sh               # Sobe os containers e prepara o ambiente
├── check_logs_s3.sh           # Valida arquivos enviados ao S3
├── check_logs_splunk.sh       # Testa a conectividade com Splunk
└── README.md                  # Este documento
```

---

## 🔐 Acesso ao Splunk

- URL: [http://localhost:8000](http://localhost:8000)
- Usuário: `admin`
- Senha: `changeme123`
- Token HEC: `token-fluentbit-test`
- Index: `main`

---

## 📄 Consultando Logs

### Splunk

Após acessar a interface, use a seguinte query:

```spl
index=main sourcetype=httpevent
```

> Substitua `httpevent` se tiver definido outro `event_sourcetype` no output do Fluent Bit.

---

### S3 (LocalStack)

Use o comando abaixo para visualizar os arquivos enviados:

```bash
aws --endpoint-url=http://localhost:4566 s3 ls s3://meubucket/clientes_impactados/ --recursive
```

---

## 🛠️ Ajustes e Customizações

- O `init.sh` define o `fluent-bit.conf` com logs do tipo `dummy`.
- É possível modificar o `INPUT` para ler arquivos reais, usar `tail`, `tcp`, etc.
- Os logs são enviados para dois destinos ao mesmo tempo: Splunk e S3 (LocalStack).

---

## 🧹 Encerramento

Para remover os containers e volumes:

```bash
docker-compose down -v
```

---