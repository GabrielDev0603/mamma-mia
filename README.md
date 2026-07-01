# Mamma Mia Delivery Web

Sistema web de pedidos online para a Pizzaria Mamma Mia, desenvolvido para reduzir pedidos por telefone, organizar o fluxo da cozinha e registrar os pedidos em banco de dados.

## Objetivo

Permitir que clientes escolham pizzas pelo site, informem dados de entrega, selecionem a forma de pagamento e enviem o pedido diretamente para o Supabase. A equipe da pizzaria acompanha os pedidos no painel administrativo e gerencia o cardapio publicado.

## Funcionalidades

- Cardapio online separado por categorias.
- Carrinho com subtotal, taxa de entrega e total.
- Formulario de pedido com nome, telefone, endereco, complemento e observacoes.
- Consulta automatica de endereco via API ViaCEP.
- Selecao de forma de pagamento: Pix, dinheiro, debito, credito, vale-refeicao e pagamento online.
- Campo de troco quando o pagamento for em dinheiro.
- Registro de pedidos e itens no Supabase.
- Login administrativo com Supabase Auth.
- Painel administrativo com acompanhamento de pedidos.
- Atualizacao de status do pedido: recebido, preparando, saiu para entrega, entregue ou cancelado.
- Gerenciamento de itens do cardapio: cadastro, edicao, disponibilidade, preco, descricao e imagem.

## Tecnologias

- HTML5, CSS3 e JavaScript puro.
- Supabase Auth.
- Supabase Database, usando PostgreSQL gerenciado na nuvem.
- ViaCEP para preenchimento automatico de endereco.
- Lucide Icons.
- Google Fonts.
- Deploy sugerido: Vercel com GitHub.

## Estrutura

```text
.
├── index.html           # Site publico e fluxo de pedido
├── admin.html           # Painel operacional da pizzaria
├── login.html           # Login da equipe
├── supabase-config.js   # Configuracao do Supabase
├── supabase-schema.sql  # SQL das tabelas, policies e correcoes
└── README.md
```

## Configuracao

1. Crie o projeto no Supabase.
2. Configure as tabelas `cardapio`, `pedidos` e `itens_pedido`.
3. Crie o usuario administrativo em Authentication > Users.
4. Atualize `supabase-config.js` com a URL e a chave publica anon/publishable do projeto.
5. Publique o projeto na Vercel ou abra localmente os arquivos HTML para validacao.

O arquivo `supabase-schema.sql` pode ser executado no SQL Editor do Supabase. Ele cria as tabelas, adiciona colunas faltantes como `pedidos.created_at`, configura indices e inclui policies basicas para o site publico e para o admin autenticado.

## Tabelas Usadas

### `cardapio`

Campos usados pelo sistema:

- `id`
- `nome`
- `categoria`
- `preco`
- `disponivel`
- `imagem_url`
- `descricao`
- `created_at`

### `pedidos`

Campos usados pelo sistema:

- `id`
- `nome_cliente`
- `telefone`
- `endereco`
- `complemento`
- `cep`
- `observacoes`
- `forma_pagamento`
- `subtotal`
- `taxa_entrega`
- `total`
- `status`
- `created_at`

### `itens_pedido`

Campos usados pelo sistema:

- `id`
- `pedido_id`
- `pizza_id`
- `nome_pizza`
- `quantidade`
- `preco_unitario`

## Implantacao

O plano de implantacao segue a estrategia Big Bang descrita no kit da unidade curricular, pois o sistema substitui um processo manual de pedidos por telefone e anotacoes em papel.

Checklist recomendado antes da virada:

- Banco Supabase criado e testado.
- Tabelas e permissoes configuradas.
- Usuario administrativo criado.
- Site publicado e acessivel.
- Formulario de pedido testado.
- Painel administrativo testado.
- Backup ou exportacao inicial do banco realizada.
- URL final validada nos navegadores Chrome, Edge e Firefox.

## Escopo Atual

Incluido:

- Pedido online.
- Cadastro de endereco.
- Consulta ViaCEP.
- Registro no banco.
- Painel administrativo de pedidos.
- Gerenciamento de cardapio.
- Selecao de forma de pagamento.

Fora do escopo atual:

- Processamento real de pagamento online.
- Rastreamento em tempo real da entrega.
- Notificacoes automaticas por WhatsApp ou e-mail.
- Cupons e promocoes.
- Avaliacao dos pedidos.

## Rollback

Em caso de falha critica apos deploy:

1. Reverter o deploy na Vercel para a versao anterior.
2. Conferir se o Supabase continua gravando corretamente.
3. Se necessario, pausar pedidos online e voltar temporariamente ao atendimento manual.
4. Registrar a ocorrencia no diario de operacao assistida.

## Status

Versao atual: `v1.0.0`

Projeto pronto para homologacao, testes de implantacao e demonstracao da unidade curricular Implantacao de Sistemas.
