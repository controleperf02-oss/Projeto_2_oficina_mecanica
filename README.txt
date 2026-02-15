# 🛠️ Projeto: Sistema de Gestão de Oficina Mecânica (Lógico/SQL)

**Analista de Dados:** Paulo Roberto  
**Tecnologia:** MySQL Workbench  
**Metodologia:** Modelo Relacional Normalizado (3NF)  
**Contexto:** Bootcamp Klabin - Excel e Power BI Dashboards

---

## 1. Descrição do Projeto
Este projeto consiste na transposição de um modelo conceitual (EER) para um esquema lógico de banco de dados voltado ao contexto de uma **Oficina Mecânica**. O objetivo é gerenciar desde o cadastro de clientes e veículos até o controle complexo de ordens de serviço, execução de mão de obra e consumo de estoque.

---

## 2. Estrutura do Banco de Dados (DDL & DML)
O banco `oficina_mecanica` foi estruturado com **10 tabelas interconectadas**, garantindo a integridade referencial através de *Constraints* e *Foreign Keys*.

### 📋 Tabelas Implementadas:
*   Clientes, Veículos, Mecânicos, Fornecedores, Peças.
*   Serviços_Catalogo, Métodos_Pagamento, Ordens_Servico.
*   Itens_OS e Itens_Pecas_OS.

### 📊 Volume de Dados:
*   Povoamento estratégico com **20 clientes, 20 veículos e 20 Ordens de Serviço**.
*   Inclusão de cenários reais de faturamento alto (R$ 13k e R$ 8k) e inadimplência controlada.

---

## 3. Requisitos Técnicos Aplicados
O projeto demonstra domínio nas seguintes cláusulas SQL:
*   **Recuperação:** `SELECT Statement`.
*   **Filtragem:** `WHERE Statement`.
*   **Cálculos:** Atributos Derivados (Comissão, descontos, subtotais).
*   **Ordenação:** `ORDER BY`.
*   **Agrupamento:** `GROUP BY` & `HAVING`.
*   **Junções:** `JOINs` Complexos (Visão 360º do negócio).

---

## 4. Queries de Negócio (Data Insights)

### A) Camada Operacional (Rotina da Oficina)
*   **Faturamento Bruto por OS:** Cálculo de total por cliente e veículo.
*   **Filtro de Ticket Alto:** Identificação de serviços acima de R$ 2.500,00.
*   **Produtividade por Serviço:** Ranking de serviços mais realizados.
*   **Gestão de Recebíveis:** Levantamento de montantes pendentes por cliente.
*   **Rastreabilidade de Peças:** Itens consumidos em serviços de Retífica.

### B) 5 Queries de Negócio (Operacional)
1. **Total a pagar por cliente:** `SELECT`, `JOIN`, `GROUP BY`, `ORDER BY`.
2. **Serviços > R$ 2.500,00 por veículo:** `SELECT`, `JOIN`, `WHERE`, `ORDER BY`.
3. **Faturamento acumulado por tipo de serviço:** `SELECT`, `SUM`, `COUNT`, `JOIN`, `GROUP BY`, `ORDER BY`.
4. **Montante "preso" (Pagamentos pendentes):** `SELECT`, `SUM`, `JOIN`, `WHERE`, `GROUP BY`, `ORDER BY`.
5. **Peças gastas em Retífica:** `SELECT`, `JOIN`, `WHERE`.

### C) 5 Queries Complexas (Tomada de Decisão / BI)
1. **Funcionário mais produtivo (Bonificação):** `SELECT`, `GROUP BY`, `JOIN`, Cálculo de Comissão.
2. **Investimento em Marketing:** `GROUP BY`, `HAVING`, `JOIN`.
3. **Compra urgente de fornecedores:** `SELECT`, `JOIN`, `WHERE`, `ORDER BY`.
4. **Marca de carro mais lucrativa (Ticket Médio):** `AVG`, `GROUP BY`, `JOIN`.
5. **Análise de inadimplência (Método Boleto):** `SELECT`, `GROUP BY`, `JOIN`.

---

## 5. Integridade e Sincronismo
*   **Paridade Total:** Sincronia entre o Modelo Lógico (EER) e o Físico (Script SQL).
*   **Documentação Interna:** Uso de metadados via cláusula `COMMENT` em todas as tabelas.
*   **Segurança:** Implementação de `SET UNIQUE_CHECKS=0` e `FOREIGN_KEY_CHECKS=0` para estabilidade dos scripts.

---

## 6. Documentação Complementar
*   📄 **Script Principal (SQL):** DDL de criação e DML de povoamento/consultas.
*   📝 **Descrição do Projeto (TXT):** Documentação do racional de negócio.
*   📖 **Dicionário de Dados (Metadados):** Script com comentários detalhados.
*   🖼️ **Modelo Lógico (PDF):** Diagrama visual das entidades.
*   💾 **Arquivo de Projeto (MWB):** Arquivo fonte do MySQL Workbench.
