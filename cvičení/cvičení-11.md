# Cvičení 11 – Intelligent Performance

Vyzkoušíš si Query Store a Index Tuning, abys mohl sledovat problematické dotazy. Vytvoříš velkou tabulku a provedeš základní testy.

Náročnost: ●●○ (20–30 minut)

1. Připrav si Log Analytics Workspace.
2. Z Query Performance Insight popisu nastav Server parameters, aby Query Store byl povolen a nastaven.
3. V Index tuning zapni index tuning.
4. Počkej pár minut.
5. Připoj se do databáze.
6. Vytvoř databázi, schéma a tabulku:
   ```sql
   CREATE TABLE big_table AS
   SELECT generate_series(1, 10000000) AS id,
   md5(random()::text)         AS some_text;
   ```
7. Opakovaně pouštěj dotaz (např. v `psql` pomocí `\watch`):
   ```sql
   SELECT * FROM big_table WHERE id BETWEEN 9999990 AND 10000000;
   ```
8. Než se objeví data, pokračuj dalším cvičením.
9. V případě, že se data nezobrazí, proč je dotaz pomalý a jak bys ho zrychlil?
