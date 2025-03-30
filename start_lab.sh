#!/bin/bash
set -ex

echo "Apagar todo ambiente do docker-compose"
docker-compose down

echo "Gerar build novo com o comando docker-compose build"
docker-compose build
sleep 5

echo "Remover volume em cache localstack"
rm -rf localstack
sleep 3

echo "Iniciando docker-compose"
docker-compose up -d
sleep 5

echo "Criando bucket no LocalStack"
docker-compose exec localstack awslocal s3api create-bucket --bucket meubucket --region us-east-1

echo "Verificando se gerou o bucket"
docker-compose exec localstack awslocal s3api list-buckets

echo "Listando arquivos dentro do bucket"
sleep 2
docker-compose exec localstack awslocal s3api list-objects --bucket meubucket
sleep 2
docker-compose exec localstack awslocal s3api list-objects --bucket meubucket
sleep 2
docker-compose exec localstack awslocal s3api list-objects --bucket meubucket
sleep 2
docker-compose exec localstack awslocal s3api list-objects --bucket meubucket
sleep 2
docker-compose exec localstack awslocal s3api list-objects --bucket meubucket
sleep 2
docker-compose exec localstack awslocal s3api list-objects --bucket meubucket
sleep 2
docker-compose exec localstack awslocal s3api list-objects --bucket meubucket
sleep 2
docker-compose exec localstack awslocal s3api list-objects --bucket meubucket

