# Cvičení 8 – Zálohování a obnova

_Týmová spolupráce_

Vyzkoušíš si obnovu databáze (fast restore i point-in-time restore), vyzkoušíte si také `pg_dump` a `pg_restore`.

Náročnost: ●●○ (20–30 minut)

## Část 1

1. Vyzkoušej si v Backup and restore obnovit databázi přes Fast restore.

## Část 2

1. Vytvoř si databázi `excellent_company`, schéma `awesome_hr` a tabulku `cool_guys` (sloupce alespoň `id`, `full_name`, `created_at`).
2. Vlož do tabulky několik řádků.
3. Zaznamenej si aktuální čas a vyčkej pár minut.
4. Změň několik řádků v tabulce.
5. Vyzkoušej si Restore do času před změnou.
6. Porovnej obsah tabulek v obou databázích.

## Část 3

1. Vyzkoušej si přes `pg_dump` zálohovat (https://www.postgresql.org/docs/current/app-pgdump.html):
    - Celou databázi `excellent_company`.
    - Samotnou tabulku `cool_guys`.
2. Dumpy předej kolegovi.
    - Navrhni, jakým způsobem si předáte dumpy.
    - Jakým způsobem bys předal dump, kdyby obsahoval citlivá data?
3. Vyzkoušej si přes `pg_restore` obnovit dump od kolegy (https://www.postgresql.org/docs/current/app-pgrestore.html):
    - Celou databázi `excellent_company`.
    - Samotnou tabulku `cool_guys`.
