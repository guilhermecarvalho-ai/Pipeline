# Pipeline de Matrículas (Supabase + Vercel)

## 1. Supabase
1. Crie um projeto em supabase.com.
2. SQL Editor → cole o conteúdo de `schema.sql` → Run.
3. Authentication → Users → **Add user** para cada colaborador (e-mail + senha).
4. Authentication → Sign In / Providers → desligue **Allow new users to sign up** (senão qualquer pessoa cria conta e acessa os dados).
5. Project Settings → API → copie **Project URL** e a chave **anon public**.

## 2. Configurar o site
No `index.html`, troque no topo do script:
```js
const SUPABASE_URL = "https://SEU-PROJETO.supabase.co";
const SUPABASE_ANON_KEY = "SUA_CHAVE_ANON";
```
A chave anon é pública por desenho; a proteção vem das políticas RLS do `schema.sql`. Nunca use a chave `service_role` no site.

## 3. Vercel
- Opção A: suba esta pasta num repositório GitHub → vercel.com → Add New Project → importe → Deploy (sem build, é site estático).
- Opção B: `npm i -g vercel` e, dentro da pasta, `vercel --prod`.
