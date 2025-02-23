# Cvičení 12 – Stress testing databáze

Pomocí nástroje `pgbench` vytvoříš zátěž na databázi a budeš sledovat metriky, aby sis ověřil výkon a limity.

Náročnost: ●●● (30–40 minut)

1. Vytvoř testovací schéma s `pgbench` (https://www.postgresql.org/docs/current/pgbench.html):
   ```shell
   pgbench -h <server_name>.postgres.database.azure.com -U <user> -i -d postgres
   ```
2. Spusť zátěž, nejdříve krátký interval pro ověření funkčnosti, poté pár minut. Ověř si v dokumentaci tyto příkazy:
   ```shell
   pgbench -h <server_name>.postgres.database.azure.com -U <user> --client=10 --time=20 -d postgres
   ```
   ```shell
   pgbench -h <server_name>.postgres.database.azure.com -U <user> --aggregate-interval=10 --time=20 --client=10 --log --rate=1000 --latency-limit=10 --failures-detailed --max-tries=10 postgres
   ```
3. Sleduj využití CPU, IO a dalších metrik v Metrics a Query Store.
4. Pokud v grafech nejsou vidět změny, zvyš počet klientů a čas testu.
5. Pokud je server příliš silný, vytvoř si nový s SKU Burstable a zopakuj test.
6. Volitelně: Nastav si Alerting, například na využití CPU.
