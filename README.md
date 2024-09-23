# Pré-Requisitos

* Docker
* Docker-compose
# Rodando Aplicação

## Clonando o repositorio
* Se for usar ssh
`git clone git@github.com:gabsmachado/app_from_tests.git`
* Se for usar HTTPS
`git clone https://github.com/gabsmachado/app_from_tests.git`

## Executando a Aplicação
* Dentro da pasta do projeto execute:
`docker-compse up`
* No terminal entre dentro do cointaner web:
 `docker exec -it app_from_tests-web-1 bash`
* Após acessar o container execute os comandos em sequencia:
* `bundle exec rake db:create`
* `bundle exec rake db:migrate`
* `budle exec rake db:seed`
* Com esses passos voce ja deve ver a apliação disponivel no seu navegador em `http://localhost:3000/`
