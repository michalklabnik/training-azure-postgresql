# Cvičení 10 – Azure Storage a pg_cron

Vyzkoušíš si rozšíření `azure_storage` a volitelně `pg_cron`, abys mohl data importovat/exportovat a spouštět úlohy podle časového plánu.

Náročnost: ●●○ (20–30 minut)

1. V Server parameters zapni Extension `azure_storage`.
2. Vytvoř si Storage Account.
3. Vyzkoušej si (https://learn.microsoft.com/azure/postgresql/flexible-server/concepts-storage-extension):
    - Načíst data ze Storage Accountu a vložit je do tabulky.
    - Uložit data z tabulky do Storage Accountu.
4. Volitelně: Vyzkoušej si nastavit rozšíření `pg_cron` (https://github.com/citusdata/pg_cron):
    - Připravit Cron job, který bude pravidelně exportovat tabulku do Storage Accountu.
