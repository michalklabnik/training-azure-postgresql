# Cvičení 7 – Logování a analýza logů

_Týmová spolupráce_

V týmu si vyzkoušíš logování do Log Analytics Workspace a do Storage Accountu. Následně budeš hledat konkrétní logy (audit, statementy) a zkoumat `pg_stat_statements`.

Náročnost: ●●● (20–40 minut)

1. Vytvoř si Storage Account a Log Analytics Workspace.
2. V Diagnostics settings nastav logování všeho do Log Analytics Workspace i do Storage Accountu.
3. V Server parameters nastav `log_line_prefix` na "%m [%p] %u@%d " (https://www.postgresql.org/docs/11/runtime-config-logging.html#GUC-LOG-LINE-PREFIX).

## Část 1

1. V Server parameters zapni rozšíření `pgaudit`.
2. Nastav parametry `pgaudit`, alespoň `pgaudit.log`.
3. Nastav kolegovi přístup do své databáze.
4. Připoj se do kolegovy databáze a proveď několik dotazů.
5. Jakmile kolega skončí v tvé databázi, zkontroluj Storage Account a Log Analytics Workspace (KQL: `AzureDiagnostics`), zda obsahují
   logy (https://learn.microsoft.com/en-us/kusto/query/kql-quick-reference).
6. Dohledej v audit lozích kolegovu aktivitu.

## Část 2

1. V Server parameters zapni logování `log_statement` a nastav `log_min_duration_statement` na logování všeho.
    - Volitelně nastav další parametry `log_*`, např. `log_duration`, `log_hostname`.
2. Připoj se do databáze.
3. Vytvoř databázi, schéma a tabulku.
4. Vlož několik řádků a proveď několik dotazů.
5. Počkej pár minut.
6. Zkontroluj Storage Account a Log Analytics Workspace (KQL: `AzureDiagnostics`), zda obsahují logy (https://learn.microsoft.com/en-us/kusto/query/kql-quick-reference).
7. Dohledej v lozích svou aktivitu.

## Část 3

1. V Server parameters zapni rozšíření `pg_stat_statements`.
2. Nastav parametry `pg_stat_statements`, alespoň `pg_stat_statements.track`.
3. Připoj se do databáze.
4. Vytvoř databázi, schéma a tabulku.
5. Vlož několik řádků a proveď několik dotazů.
6. Prozkoumej dotazy v tabulce `pg_stat_statements` (https://www.postgresql.org/docs/current/pgstatstatements.html).
