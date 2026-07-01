-- Mamma Mia Delivery Web - Supabase schema
-- Rode este arquivo no SQL Editor do Supabase.
-- A correcao do erro "column pedidos.created_at does not exist" esta logo abaixo.

create extension if not exists pgcrypto;

create table if not exists public.cardapio (
  id uuid primary key default gen_random_uuid(),
  nome text not null,
  categoria text not null default 'classicas',
  preco numeric(10,2) not null default 0,
  disponivel boolean not null default true,
  imagem_url text,
  descricao text,
  created_at timestamptz not null default now()
);

create table if not exists public.pedidos (
  id uuid primary key default gen_random_uuid(),
  nome_cliente text not null,
  telefone text not null,
  endereco text not null,
  complemento text,
  cep text,
  observacoes text,
  forma_pagamento text,
  subtotal numeric(10,2) not null default 0,
  taxa_entrega numeric(10,2) not null default 0,
  total numeric(10,2) not null default 0,
  status text not null default 'recebido',
  created_at timestamptz not null default now()
);

create table if not exists public.itens_pedido (
  id uuid primary key default gen_random_uuid(),
  pedido_id uuid references public.pedidos(id) on delete cascade,
  pizza_id uuid references public.cardapio(id) on delete set null,
  nome_pizza text not null,
  quantidade integer not null default 1,
  preco_unitario numeric(10,2) not null default 0,
  created_at timestamptz not null default now()
);

-- Correcoes para tabelas que ja existem sem todas as colunas.
alter table public.cardapio add column if not exists created_at timestamptz not null default now();
alter table public.cardapio add column if not exists imagem_url text;
alter table public.cardapio add column if not exists descricao text;
alter table public.cardapio add column if not exists disponivel boolean not null default true;

alter table public.pedidos add column if not exists complemento text;
alter table public.pedidos add column if not exists cep text;
alter table public.pedidos add column if not exists observacoes text;
alter table public.pedidos add column if not exists forma_pagamento text;
alter table public.pedidos add column if not exists subtotal numeric(10,2) not null default 0;
alter table public.pedidos add column if not exists taxa_entrega numeric(10,2) not null default 0;
alter table public.pedidos add column if not exists total numeric(10,2) not null default 0;
alter table public.pedidos add column if not exists status text not null default 'recebido';
alter table public.pedidos add column if not exists created_at timestamptz not null default now();

alter table public.itens_pedido add column if not exists created_at timestamptz not null default now();

-- Indices para deixar o painel administrativo mais rapido.
create index if not exists idx_cardapio_categoria on public.cardapio(categoria);
create index if not exists idx_cardapio_disponivel on public.cardapio(disponivel);
create index if not exists idx_pedidos_created_at on public.pedidos(created_at desc);
create index if not exists idx_pedidos_status on public.pedidos(status);
create index if not exists idx_itens_pedido_pedido_id on public.itens_pedido(pedido_id);

-- Regras simples de validade.
do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'pedidos_status_check'
  ) then
    alter table public.pedidos
      add constraint pedidos_status_check
      check (status in ('recebido', 'preparando', 'saiu', 'entregue', 'cancelado'));
  end if;
end $$;

alter table public.pedidos drop constraint if exists pedidos_forma_pagamento_check;
alter table public.pedidos
  add constraint pedidos_forma_pagamento_check
  check (
    forma_pagamento is null
    or forma_pagamento in ('pix', 'dinheiro', 'debito', 'credito', 'vale_refeicao', 'online')
  );

-- RLS: publico pode ver cardapio disponivel e inserir pedidos.
-- Usuario autenticado pode gerenciar cardapio e pedidos pelo admin.
alter table public.cardapio enable row level security;
alter table public.pedidos enable row level security;
alter table public.itens_pedido enable row level security;

drop policy if exists "Publico ve cardapio disponivel" on public.cardapio;
create policy "Publico ve cardapio disponivel"
on public.cardapio for select
to anon, authenticated
using (disponivel = true or auth.role() = 'authenticated');

drop policy if exists "Admin gerencia cardapio" on public.cardapio;
create policy "Admin gerencia cardapio"
on public.cardapio for all
to authenticated
using (true)
with check (true);

drop policy if exists "Publico cria pedidos" on public.pedidos;
create policy "Publico cria pedidos"
on public.pedidos for insert
to anon, authenticated
with check (true);

drop policy if exists "Admin ve pedidos" on public.pedidos;
create policy "Admin ve pedidos"
on public.pedidos for select
to authenticated
using (true);

drop policy if exists "Admin atualiza pedidos" on public.pedidos;
create policy "Admin atualiza pedidos"
on public.pedidos for update
to authenticated
using (true)
with check (true);

drop policy if exists "Publico cria itens do pedido" on public.itens_pedido;
create policy "Publico cria itens do pedido"
on public.itens_pedido for insert
to anon, authenticated
with check (true);

drop policy if exists "Admin ve itens do pedido" on public.itens_pedido;
create policy "Admin ve itens do pedido"
on public.itens_pedido for select
to authenticated
using (true);

-- Dados iniciais opcionais para testar o cardapio.
insert into public.cardapio (nome, categoria, preco, disponivel, descricao)
values
  ('Margherita', 'classicas', 39.90, true, 'Molho de tomate, mussarela, tomate e manjericao.'),
  ('Calabresa', 'classicas', 42.90, true, 'Calabresa fatiada, cebola, mussarela e oregano.'),
  ('Quatro Queijos', 'especiais', 49.90, true, 'Mussarela, parmesao, gorgonzola e catupiry.'),
  ('Chocolate', 'doces', 44.90, true, 'Chocolate cremoso, granulado e massa artesanal.')
on conflict do nothing;
