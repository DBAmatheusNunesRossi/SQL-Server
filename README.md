# 🗄️ SQL Server — Gaveta de Scripts do DBA

Bem-vindo à **minha gaveta de scripts SQL Server** — um espaço organizado para armazenar, consultar e aprimorar scripts práticos usados no dia a dia da administração de bancos de dados Microsoft SQL Server.  
Pense neste repositório como uma **caixa de ferramentas** ou **gaveta de soluções rápidas**, separadas por tema, prontas para te ajudar a resolver problemas e otimizar o ambiente de forma segura e eficiente.

---

## 📚 Sumário de Tópicos

1. [🧩 Administrando Banco de Dados](#-administrando-banco-de-dados)  
2. [💾 Backup e Restore](#-backup-e-restore)  
3. [🩺 Recuperando Banco Corrompido](#-recuperando-banco-corrompido)  
4. [📊 Tabelas e Índices](#-tabelas-e-índices)  
5. [🔐 Segurança de Usuários](#-segurança-de-usuários)  
6. [⚡ In-Memory OLTP](#-in-memory-oltp)  
7. [🚀 Query Tuning](#-query-tuning)  
8. [🤖 Automatizando Tarefas](#-automatizando-tarefas)  
9. [📈 Monitorando o SQL Server](#-monitorando-o-sql-server)  
10. [🔄 Controle de Concorrência](#-controle-de-concorrência)  
11. [🧱 Alta Disponibilidade e Replicação](#-alta-disponibilidade-e-replicação)  

---

## 🧩 Administrando Banco de Dados
Scripts para **criação, manutenção e configuração** de bancos de dados, incluindo gerenciamento de arquivos MDF/LDF, crescimento automático, e boas práticas de configuração de instância.  
> Exemplo: criação de banco, alteração de compatibilidade, mudança de recovery model, etc.

---

## 💾 Backup e Restore
Scripts para **estratégias de backup e restore**, cobrindo Full, Differential, Log e Copy-Only.  
> Inclui exemplos de automação e verificação de integridade dos backups.

---

## 🩺 Recuperando Banco Corrompido
Passos e scripts para diagnosticar e recuperar bancos de dados danificados.  
> DBCC CHECKDB, modo EMERGENCY, RESTORE com CONTINUE_AFTER_ERROR e estratégias seguras de recuperação.

---

## 📊 Tabelas e Índices
Scripts para **criação, análise e manutenção de índices**, além de estatísticas e fragmentação.  
> Inclui índices Clustered, Nonclustered, Columnstore e Covering, bem como dicas de performance.

---

## 🔐 Segurança de Usuários
Scripts para **gerenciamento de logins, usuários, permissões e roles**.  
> GRANT, DENY, REVOKE, controle de acesso e boas práticas de segurança em nível de instância e banco.

---

## ⚡ In-Memory OLTP
Exemplos de criação e uso de **tabelas e procedimentos otimizados para memória**, ideais para cenários de alta performance.  
> Scripts de migração, checkpoint e análise de desempenho.

---

## 🚀 Query Tuning
Coleção de scripts para **análise e otimização de consultas**.  
> Planos de execução, índices sugeridos, estatísticas, I/O e CPU usage, com foco em diagnósticos e tuning fino.

---

## 🤖 Automatizando Tarefas
Scripts para **SQL Agent Jobs**, **DBMail**, **agendamento de manutenção** e automações do dia a dia do DBA.  
> Inclui envio de alertas automáticos, verificação de backups e limpeza de logs.

---

## 📈 Monitorando o SQL Server
Scripts para **monitoramento de performance e recursos**, como CPU, memória, discos, locks e waits.  
> Inclui consultas de DMV (Dynamic Management Views) e relatórios de diagnóstico.

---

## 🔄 Controle de Concorrência
Scripts que exploram **níveis de isolamento, bloqueios e deadlocks**, com exemplos de transações e troubleshooting.  
> Ferramentas para visualizar sessões ativas, locks em tempo real e estratégias de mitigação.

---

## 🧱 Alta Disponibilidade e Replicação
Scripts para configurar e manter **soluções de alta disponibilidade** como:
- Always On Availability Groups  
- Log Shipping  
- Database Mirroring  
- Replicação (Snapshot, Transactional e Merge)

> Inclui exemplos de failover, monitoramento e troubleshooting.

---

## 🧰 Estrutura do Repositório

Cada pasta contém scripts `.sql` organizados e comentados, prontos para uso e personalização conforme o ambiente.

---

## 💡 Filosofia do Projeto

> “Um DBA eficiente é aquele que tem suas ferramentas prontas antes da emergência.”

Este repositório serve como **repositório pessoal de conhecimento** e como **base de consulta rápida**, seja para estudo, prática ou situações reais de administração de banco de dados.

---

## 🧾 Licença

Este projeto é distribuído sob a licença MIT.  
Sinta-se à vontade para clonar, adaptar e contribuir.

---

## 🤝 Contribuições

Sugestões e melhorias são bem-vindas!  
Abra uma **issue** ou envie um **pull request** com novos scripts, ajustes ou otimizações.

---

## 🧠 Autor

**Matheus — DBA | SQL Server | PostgreSQL | MongoDB**  
> “Cuidando dos dados como se fossem diamantes.”




