-- Grade-3 Reading — content build tracker
-- Run once in Supabase SQL editor (project dbfqnbpushfzgvpdacvd).
create table if not exists content_items (
  id           text primary key,
  seq          int,
  unit         text not null,
  band         text,
  lesson       text,
  phase        text,              -- build | i-do | we-do | you-do | check | gate
  content_type text,              -- article | mcq | msq | hot-text | sequence | match | ebsr | saq
  substandard  text,
  difficulty   text,              -- Lexile
  spec         text,              -- instructions / about / stem
  status       text not null default 'todo',  -- todo | wip | built | na
  updated_at   timestamptz not null default now()
);

alter table content_items enable row level security;

-- Public tracker: anyone can read + flip status (no inserts/deletes from the client).
drop policy if exists "public read"   on content_items;
drop policy if exists "public update" on content_items;
create policy "public read"   on content_items for select using (true);
create policy "public update" on content_items for update using (true) with check (true);

-- keep updated_at fresh
create or replace function touch_updated_at() returns trigger as $$
begin new.updated_at = now(); return new; end; $$ language plpgsql;
drop trigger if exists trg_touch on content_items;
create trigger trg_touch before update on content_items
  for each row execute function touch_updated_at();
