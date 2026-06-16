# Grade-3 Reading — Content Build Tracker

Live, shareable tracker for every passage & question to build across the 10 reading expeditions
(675 artifacts), synced via Supabase.

## Setup (one time)
1. In Supabase (project `dbfqnbpushfzgvpdacvd`) → **SQL editor**, run `schema.sql` then `seed.sql`.
2. Open the site; paste the project's **anon public key** (Settings → API). It's row-level-security-safe to expose.

Status updates write back to the `content_items` table and broadcast live to everyone with the link.
