# Informação de implementação
* O projeto foi implementado com Ruby 2.2.0 e Rails 4.2.0.
* Testes foram implementados com a biblioteca rspec.
* A solução salva uma versão local do arquivo carregado via interface web em Rails.root/uploads, para fins de debug e auditoria.
* Uma implantação de produção necessitaria uma solução para remover arquivos antigos, após x dias.

# Instação e execução
```
https://github.com/holgerw/avaliacao_desenvolvedor.git
cd avaliacao_desenvolvedor
bundle install
bundle exec rails server
```
A aplicação pode ser acessada em http://localhost:3000

# Execução dos testes
```
cd avaliacao_desenvolvedor
bundle exec rspec
```