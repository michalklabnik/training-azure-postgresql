# Cvičení 2 – Připojení k databázi

Naučíš se připojit k veřejné databázi pomocí různých klientů a vyzkoušet si autentizaci přes PostgreSQL i Microsoft Entra.

Náročnost: ●○○ (15–20 minut)

1. K veřejné databázi se připoj pomocí:
    - DBeaver
    - `psql` (využij Azure shell) (https://www.postgresql.org/docs/current/app-psql.html)
2. Připoj se jak PostgreSQL, tak Microsoft Entra autentikací.
    - Při Microsoft Entra autentikaci vyzkoušej přihlášení uživatelem a skupinou. Jak se liší?
3. Připoj se s plnou verifikací certifikátu `sslmode=verify-full` (https://learn.microsoft.com/azure/postgresql/flexible-server/how-to-connect-tls-ssl).
4. Vyzkoušej si libovolné SQL dotazy.
