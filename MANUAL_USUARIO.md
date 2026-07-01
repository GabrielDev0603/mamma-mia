# Manual do Usuario - Mamma Mia Delivery Web

## 1. Identificacao do sistema

**Nome do sistema:** Mamma Mia Delivery Web

**Versao:** 1.0.0

**Finalidade:** permitir que clientes consultem o cardapio da Pizzaria Mamma Mia, montem um carrinho de pizzas e registrem um pedido de entrega. O sistema tambem possui uma area administrativa para acompanhar pedidos e gerenciar itens do cardapio.

**Publico-alvo:** clientes da pizzaria e equipe administrativa responsavel pelo atendimento.

## 2. Requisitos para uso

Para utilizar o sistema, recomenda-se:

- Navegador atualizado, como Google Chrome, Microsoft Edge ou Mozilla Firefox.
- Acesso a internet para carregar fontes, icones, consulta de CEP e cardapio.
- Para a equipe administrativa, usuario e senha cadastrados no Supabase Auth.

## 3. Acesso ao sistema

### 3.1 Acesso do cliente

O cliente acessa a pagina principal pelo arquivo ou endereco publicado do sistema:

```text
index.html
```

Na pagina inicial, o cliente pode visualizar o cardapio, adicionar pizzas ao carrinho e preencher os dados de entrega.

### 3.2 Acesso administrativo

A equipe da pizzaria acessa a pagina de login:

```text
login.html
```

Apos informar e-mail e senha validos, o usuario e direcionado para:

```text
admin.html
```

## 4. Uso pelo cliente

### 4.1 Visualizar o cardapio

Na pagina inicial, o cliente deve acessar a secao **Cardapio**. Os itens podem ser filtrados pelas categorias:

- Todas
- Classicas
- Especiais
- Doces

Cada pizza exibe nome, descricao, preco e imagem.

### 4.2 Ver detalhes de uma pizza

Ao clicar em um card de pizza, o sistema abre uma janela com:

- Imagem ampliada.
- Nome do sabor.
- Descricao.
- Preco.
- Botao para adicionar ao carrinho.

### 4.3 Adicionar itens ao carrinho

O cliente pode adicionar uma pizza pelo botao de adicionar no card ou pela janela de detalhes. O carrinho mostra:

- Quantidade de itens.
- Subtotal.
- Taxa de entrega.
- Total do pedido.

Tambem e possivel alterar a quantidade usando os botoes de mais e menos.

### 4.4 Limpar o carrinho

No card do carrinho, o cliente pode clicar em **Limpar** para remover todos os itens selecionados.

### 4.5 Preencher dados de entrega

Para finalizar o pedido, o cliente informa:

- Nome completo.
- Telefone ou WhatsApp.
- CEP.
- Rua ou avenida.
- Numero.
- Bairro.
- Cidade e UF.
- Complemento, se necessario.
- Observacoes do pedido.

Ao informar o CEP, o sistema tenta consultar automaticamente o endereco usando o ViaCEP.

### 4.6 Selecionar forma de pagamento

O sistema permite duas formas de pagamento:

- Dinheiro.
- Maquina de cartao.

Quando o pagamento for em dinheiro, o cliente pode informar se precisa de troco.

### 4.7 Confirmar pedido

Apos preencher os dados obrigatorios e conferir o carrinho, o cliente deve clicar em **Confirmar pedido**.

O sistema registra o pedido no navegador local e exibe uma mensagem de confirmacao. O pedido fica disponivel no painel administrativo quando acessado no mesmo navegador.

## 5. Uso pela equipe administrativa

### 5.1 Fazer login

Na pagina `login.html`, a equipe deve informar e-mail e senha cadastrados. Se os dados forem validos, o sistema abre o painel administrativo.

### 5.2 Acompanhar pedidos

Na aba **Pedidos**, o painel exibe os pedidos registrados no navegador. Cada pedido apresenta:

- Codigo do pedido.
- Nome do cliente.
- Horario.
- Telefone.
- Endereco de entrega.
- Forma de pagamento.
- Observacoes.
- Itens do pedido.
- Total.
- Status.

Os status disponiveis sao:

- Recebido.
- Preparando.
- Saiu para entrega.
- Entregue.
- Cancelado.

### 5.3 Atualizar status do pedido

A equipe pode avancar o status do pedido pelos botoes exibidos no card do pedido. Tambem e possivel cancelar pedidos que ainda nao foram entregues.

### 5.4 Gerenciar cardapio

Na aba **Cardapio**, a equipe pode:

- Visualizar os itens cadastrados.
- Pesquisar por nome.
- Filtrar por categoria.
- Filtrar por disponibilidade.
- Criar novo item.
- Editar item existente.
- Excluir item do cardapio.

### 5.5 Cadastrar novo item

Para cadastrar uma nova pizza, clique em **Novo item** e preencha:

- Nome da pizza.
- Categoria.
- Preco.
- Disponibilidade.
- URL da imagem.
- Descricao.

Depois, clique em **Salvar**.

### 5.6 Editar item do cardapio

Para alterar uma pizza, clique no icone de lapis na linha do item. O sistema abre o formulario preenchido com os dados atuais. Apos alterar as informacoes, clique em **Salvar**.

### 5.7 Excluir item do cardapio

Para remover uma pizza, clique no icone de lixeira. O sistema solicita confirmacao antes de excluir.

## 6. Dados armazenados

O sistema utiliza dois tipos de armazenamento:

### 6.1 Supabase

Usado para:

- Login administrativo.
- Cardapio.
- Cadastro e gerenciamento dos itens do cardapio.

### 6.2 Armazenamento local do navegador

Usado para:

- Carrinho do cliente.
- Pedidos feitos no navegador.

Observacao: pedidos salvos localmente ficam disponiveis apenas no mesmo navegador e computador em que foram criados.

## 7. Possiveis problemas e solucoes

### 7.1 O cardapio nao carrega

Possiveis causas:

- Falta de internet.
- Configuracao incorreta no arquivo `supabase-config.js`.
- Tabela `cardapio` nao configurada no Supabase.

Solucao:

- Verificar conexao com a internet.
- Conferir URL e chave publica do Supabase.
- Rodar o arquivo `supabase-schema.sql` no SQL Editor do Supabase.

### 7.2 O CEP nao preenche automaticamente

Possiveis causas:

- CEP invalido.
- Falha na consulta ao ViaCEP.
- Falta de internet.

Solucao:

- Conferir se o CEP possui 8 numeros.
- Preencher o endereco manualmente se a consulta falhar.

### 7.3 Pedido nao aparece em outro computador

Isso acontece porque os pedidos estao salvos localmente no navegador.

Solucao:

- Usar o mesmo navegador/computador durante a demonstracao.
- Para uma versao em producao, recomenda-se gravar pedidos no banco Supabase com as politicas de seguranca corretamente configuradas.

### 7.4 Login administrativo nao funciona

Possiveis causas:

- Usuario nao cadastrado no Supabase.
- Senha incorreta.
- Configuracao incorreta em `supabase-config.js`.

Solucao:

- Conferir usuario em Authentication > Users no Supabase.
- Redefinir senha, se necessario.
- Conferir as credenciais do projeto.

## 8. Boas praticas de uso

- Conferir os dados de entrega antes de confirmar o pedido.
- Manter o cardapio atualizado.
- Ocultar itens indisponiveis em vez de excluir, quando o item puder voltar ao cardapio.
- Atualizar o status do pedido conforme o preparo avanca.
- Testar o fluxo completo antes de apresentar ou publicar o sistema.

## 9. Encerramento

O Mamma Mia Delivery Web foi desenvolvido para tornar o processo de pedido mais simples, organizado e visual. O cliente consegue montar o pedido sem depender de atendimento telefonico, enquanto a equipe consegue acompanhar as informacoes principais pelo painel administrativo.
