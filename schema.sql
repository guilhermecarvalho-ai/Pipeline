-- Rode no Supabase: SQL Editor > New query > Run

create table cursos (
  nome text primary key,
  meta int not null default 0,
  mensalidade numeric not null default 0
);
-- mensalidade 1500 é só um valor inicial: ajuste no painel
insert into cursos (nome, meta, mensalidade) values
  ('Direito Noturno', 19, 1500),
  ('Direito Matutino', 11, 1500),
  ('Ciência da Computação', 17, 1500);

create table config (
  id int primary key default 1 check (id = 1),
  meses int not null default 6
);
insert into config (id, meses) values (1, 6);

create table alunos (
  id uuid primary key default gen_random_uuid(),
  curso text not null references cursos(nome) on update cascade,
  colaborador text not null,
  aluno text not null,
  etapa text not null default 'Lead'
    check (etapa in ('Lead','Contato feito','Visita ou aula experimental','Proposta','Matriculado','Perdido')),
  data_retorno date,
  criado_por uuid default auth.uid(),
  created_at timestamptz not null default now()
);

alter table cursos enable row level security;
alter table config enable row level security;
alter table alunos enable row level security;

-- Qualquer usuário logado (equipe) lê e edita tudo. Anônimos não acessam nada.
create policy "equipe cursos" on cursos for all to authenticated using (true) with check (true);
create policy "equipe config" on config for all to authenticated using (true) with check (true);
create policy "equipe alunos" on alunos for all to authenticated using (true) with check (true);

-- Atualização em tempo real entre os colaboradores
alter publication supabase_realtime add table alunos, cursos, config;
