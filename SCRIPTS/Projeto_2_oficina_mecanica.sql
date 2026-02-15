
-- =============================================================================
-- PROJETO: BANCO DE DADOS OFICINA MECÂNICA
-- (Com Estoque, Mecânicos e Fornecedores)
-- DESENVOLVEDOR: Paulo Roberto
-- =============================================================================

-- 1. CRIAÇÃO E PREPARAÇÃO DO SCHEMA
DROP DATABASE IF EXISTS oficina_mecanica;
CREATE DATABASE IF NOT EXISTS oficina_mecanica;
USE oficina_mecanica;


-- 2. TABELAS DE CADASTRO (NÍVEL 1)
-- Clientes: O início de tudo
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100)
) AUTO_INCREMENT = 1;


-- Mecânicos: Responsáveis pela execução e comissão
CREATE TABLE Mecanicos (
    id_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(50),
    comissao_percentual DECIMAL(5,2) DEFAULT 5.00
) AUTO_INCREMENT = 1;


-- Fornecedores: Origem das peças
CREATE TABLE Fornecedores (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(100) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    contato VARCHAR(50)
) AUTO_INCREMENT = 1;


-- Catálogo de Serviços: Preços base de mão de obra
CREATE TABLE Servicos_Catalogo (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    nome_servico VARCHAR(50) NOT NULL,
    valor_base DECIMAL(10,2) NOT NULL
) AUTO_INCREMENT = 1;


-- Métodos de Pagamento
CREATE TABLE Metodos_Pagamento (
    id_metodo INT AUTO_INCREMENT PRIMARY KEY,
    descricao ENUM('Boleto', 'Cartão', 'PIX', 'Dinheiro') NOT NULL
) AUTO_INCREMENT = 1;


-- 3. TABELAS RELACIONAIS E DE ESTOQUE
-- Veículos: Ligados diretamente ao dono (Cliente)
CREATE TABLE Veiculos (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(10) UNIQUE NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    ano INT,
    fk_id_cliente INT,
    FOREIGN KEY (fk_id_cliente) REFERENCES Clientes(id_cliente)
) AUTO_INCREMENT = 1;


-- Peças: Controle de estoque e custo
CREATE TABLE Pecas (
    id_peca INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL,
    valor_venda DECIMAL(10,2) NOT NULL,
    estoque_atual INT DEFAULT 0,
    fk_id_fornecedor INT,
    FOREIGN KEY (fk_id_fornecedor) REFERENCES Fornecedores(id_fornecedor)
) AUTO_INCREMENT = 1;


-- 4. FLUXO DE OPERAÇÃO: ORDENS DE SERVIÇO 
-- Ordem de Serviço: O documento central do negócio
CREATE TABLE Ordens_Servico (
    id_os INT AUTO_INCREMENT PRIMARY KEY,
    data_emissao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status_os ENUM('Aberta', 'Em Execução', 'Concluída', 'Cancelada') DEFAULT 'Aberta',
    valor_total DECIMAL(10,2) DEFAULT 0.00,
    status_pagamento ENUM('Pago', 'Pendente') DEFAULT 'Pendente',
    fk_id_veiculo INT,
    fk_id_metodo INT,
    fk_id_mecanico INT,
    FOREIGN KEY (fk_id_veiculo) REFERENCES Veiculos(id_veiculo),
    FOREIGN KEY (fk_id_metodo) REFERENCES Metodos_Pagamento(id_metodo),
    FOREIGN KEY (fk_id_mecanico) REFERENCES Mecanicos(id_mecanico)
) AUTO_INCREMENT = 1;


-- 5. DETALHAMENTO DA OS (N:M)
-- Itens_OS: Serviços realizados na OS (Mão de obra)
CREATE TABLE Itens_OS (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    fk_id_os INT,
    fk_id_servico INT,
    quantidade INT DEFAULT 1,
    valor_unitario DECIMAL(10,2),
    FOREIGN KEY (fk_id_os) REFERENCES Ordens_Servico(id_os),
    FOREIGN KEY (fk_id_servico) REFERENCES Servicos_Catalogo(id_servico)
) AUTO_INCREMENT = 1;


-- Itens_Pecas_OS: Peças utilizadas na OS (Produtos)
CREATE TABLE Itens_Pecas_OS (
    id_item_peca INT AUTO_INCREMENT PRIMARY KEY,
    fk_id_os INT,
    fk_id_peca INT,
    quantidade INT NOT NULL,
    valor_unitario_aplicado DECIMAL(10,2),
    FOREIGN KEY (fk_id_os) REFERENCES Ordens_Servico(id_os),
    FOREIGN KEY (fk_id_peca) REFERENCES Pecas(id_peca)
) AUTO_INCREMENT = 1;

-- =============================================================================
-- POVOAMENTO ESTRATÉGICO (10 REGISTROS POR TABELA)
-- =============================================================================

-- 1. Métodos de Pagamento 
INSERT INTO Metodos_Pagamento (id_metodo, descricao) VALUES 
(1, 'Dinheiro'), (2, 'Cartão'), (3, 'PIX'), (4, 'Boleto'),
(5, 'Cartão'), (6, 'PIX'), (7, 'Dinheiro'), (8, 'Boleto'), (9, 'PIX'), (10, 'Cartão');

-- 2. Clientes
INSERT INTO Clientes (nome, cpf, telefone) VALUES 
('Ricardo Silva', '111.111.111-11', '11 98888-0001'), ('Ana Oliveira', '222.222.222-22', '11 98888-0002'),
('Carlos Souza', '333.333.333-33', '11 98888-0003'), ('Marcos Pontes', '444.444.444-44', '11 98888-0004'),
('Julia Costa', '555.555.555-55', '11 98888-0005'), ('Roberto Dias', '666.666.666-66', '11 98888-0006'),
('Sandra Lima', '777.777.777-77', '11 98888-0007'), ('Paulo Vieira', '888.888.888-88', '11 98888-0008'),
('Carla Mendes', '999.999.999-99', '11 98888-0009'), ('Fabio Junior', '000.000.000-00', '11 98888-0010');
INSERT INTO Clientes (nome, cpf, telefone) VALUES 
('Marcos Rocha', '123.456.789-01', '11 97777-1011'), ('Beatriz Matos', '234.567.890-12', '11 97777-1012'),
('Fernando Dias', '345.678.901-23', '11 97777-1013'), ('Luciana Lins', '456.789.012-34', '11 97777-1014'),
('Gustavo Henrique', '567.890.123-45', '11 97777-1015'), ('Patricia Amorim', '678.901.234-56', '11 97777-1016'),
('Tiago Nunes', '789.012.345-67', '11 97777-1017'), ('Elaine Souza', '890.123.456-78', '11 97777-1018'),
('Renato Garcia', '901.234.567-89', '11 97777-1019'), ('Sonia Abrão', '012.345.678-90', '11 97777-1020');

-- 3. Mecânicos
INSERT INTO Mecanicos (nome, especialidade) VALUES 
('Mestre Juca', 'Motores'), ('Zeca Eletro', 'Elétrica'), ('Tiao Suspensao', 'Suspensão'),
('Beto Alinhador', 'Alinhamento'), ('Dr. Ar', 'Ar-condicionado'), ('Leo Freios', 'Sist. Frenagem'),
('Geraldo Retifica', 'Usinagem'), ('Nando Injecao', 'Injeção Eletrônica'), ('Hugo Cambio', 'Transmissão'),
('Rafa Funileiro', 'Estética');

-- 4. Fornecedores
INSERT INTO Fornecedores (razao_social, cnpj) VALUES 
('Distribuidora AutoPeças', '10.001/0001-01'), ('Mundo dos Filtros', '10.002/0001-02'),
('Stop Freios S.A.', '10.003/0001-03'), ('Elétrica Central', '10.004/0001-04'),
('Pneus Online', '10.005/0001-05'), ('Retífica São Paulo', '10.006/0001-06'),
('Ar Condicionado OK', '10.007/0001-07'), ('Baterias Moura S.A.', '10.008/0001-08'),
('Óleos e Fluidos LTDA', '10.009/0001-09'), ('Transmissão Forte', '10.010/0001-10');

-- 5. Catálogo de Serviços
INSERT INTO Servicos_Catalogo (nome_servico, valor_base) VALUES 
('Troca de óleo', 250.00), ('Alinhamento', 150.00), ('Retífica', 7000.00), 
('Revisão preventiva', 500.00), ('Freios', 850.00), ('Suspensão', 1200.00), 
('Injeção', 450.00), ('Ar-condicionado', 300.00), ('Embreagem', 1800.00), ('Sistema elétrico', 600.00);

-- 6. Veículos 
INSERT INTO Veiculos (placa, modelo, marca, fk_id_cliente) VALUES 
('ABC-1234', 'Civic', 'Honda', 1), ('XYZ-9876', 'Hilux', 'Toyota', 2),
('DEF-5678', 'Uno', 'Fiat', 3), ('GHI-9012', 'Onix', 'Chevrolet', 4),
('JKL-3456', 'Corolla', 'Toyota', 5), ('MNO-7890', 'Gol', 'VW', 6),
('PQR-1122', 'HB20', 'Hyundai', 7), ('STU-3344', 'Renegade', 'Jeep', 8),
('VWX-5566', 'Compass', 'Jeep', 9), ('YZA-7788', 'Mustang', 'Ford', 10);
INSERT INTO Veiculos (placa, modelo, marca, fk_id_cliente) VALUES 
('AAA-0001', 'Civic', 'Honda', 11), ('BBB-0002', 'Fit', 'Honda', 12), 
('CCC-0003', 'Corolla', 'Toyota', 13), ('DDD-0004', 'Etios', 'Toyota', 14),
('EEE-0005', 'Hilux', 'Toyota', 15), 
('FFF-0006', 'Compass', 'Jeep', 16), ('GGG-0007', 'Renegade', 'Jeep', 17),
('HHH-0008', 'Golf', 'VW', 18), ('III-0009', 'Jetta', 'VW', 19),
('JJJ-0010', 'Polo', 'VW', 20);

-- 7. Peças 
INSERT INTO Pecas (descricao, valor_venda, estoque_atual, fk_id_fornecedor) VALUES 
('Kit Pistão Premium', 1500.00, 20, 6), ('Óleo Sintético 5W30', 60.00, 100, 9),
('Pastilha de Freio', 220.00, 15, 3), ('Amortecedor Dianteiro', 450.00, 8, 5),
('Filtro de Ar', 45.00, 30, 2), ('Bateria 60Ah', 480.00, 10, 8),
('Vela de Ignição', 35.00, 40, 4), ('Correia Dentada', 180.00, 12, 1),
('Gás R134a', 120.00, 5, 7), ('Kit Embreagem', 950.00, 3, 10);

-- 8. Ordens de Serviço 
INSERT INTO Ordens_Servico (id_os, status_os, valor_total, status_pagamento, fk_id_veiculo, fk_id_metodo, fk_id_mecanico) VALUES 
(1, 'Concluída', 13000.00, 'Pago', 1, 2, 1),   
(2, 'Concluída', 8000.00, 'Pendente', 2, 4, 7), 
(3, 'Aberta', 1250.00, 'Pendente', 3, 1, 2),
(4, 'Em Execução', 2500.00, 'Pendente', 4, 3, 3),
(5, 'Concluída', 500.00, 'Pago', 5, 2, 4),
(6, 'Concluída', 1800.00, 'Pago', 6, 3, 9),
(7, 'Aberta', 900.00, 'Pendente', 7, 1, 8),
(8, 'Em Execução', 3000.00, 'Pendente', 8, 2, 6),
(9, 'Concluída', 450.00, 'Pago', 9, 3, 5),
(10, 'Concluída', 1200.00, 'Pago', 10, 2, 10);
INSERT INTO Ordens_Servico (id_os, status_os, valor_total, status_pagamento, fk_id_veiculo, fk_id_metodo, fk_id_mecanico) VALUES 
(11, 'Concluída', 4500.00, 'Pendente', 11, 4, 1), 
(12, 'Concluída', 3200.00, 'Pendente', 12, 4, 2), 
(13, 'Concluída', 2800.00, 'Pendente', 13, 4, 3), 
(14, 'Concluída', 5100.00, 'Pendente', 14, 4, 4), 
(15, 'Concluída', 3900.00, 'Pendente', 15, 4, 5), 
(16, 'Concluída', 1500.00, 'Pendente', 16, 2, 6), 
(17, 'Concluída', 1200.00, 'Pendente', 17, 2, 7), 
(18, 'Concluída', 900.00, 'Pendente', 18, 2, 8), 
(19, 'Concluída', 850.00, 'Pendente', 19, 2, 9),  
(20, 'Concluída', 1100.00, 'Pendente', 20, 2, 10);

-- 9. Itens_OS - Serviços 
INSERT INTO Itens_OS (fk_id_os, fk_id_servico, valor_unitario) VALUES 
(1, 2, 150.00), (1, 1, 250.00), (1, 3, 9600.00), 
(2, 2, 150.00), (2, 3, 7850.00),              
(3, 10, 600.00), (4, 6, 1200.00), (5, 4, 500.00),
(6, 9, 1800.00), (10, 6, 1200.00);
INSERT INTO Itens_OS (fk_id_os, fk_id_servico, valor_unitario) VALUES 
(11, 3, 4500.00), 
(12, 3, 3200.00), 
(13, 6, 1200.00), (13, 9, 1600.00), 
(14, 6, 2100.00), (14, 5, 3000.00), 
(15, 3, 3900.00), 
(16, 5, 1500.00), (17, 1, 1200.00), (18, 2, 900.00), (19, 3, 850.00), (20, 10, 1100.00);

-- 10. Itens_Pecas_OS - Peças
INSERT INTO Itens_Pecas_OS (fk_id_os, fk_id_peca, quantidade, valor_unitario_aplicado) VALUES 
(1, 1, 2, 1500.00), 
(3, 6, 1, 480.00), (4, 4, 2, 450.00), (7, 3, 2, 220.00),
(8, 1, 1, 1500.00), (8, 2, 5, 60.00), (9, 9, 1, 120.00),
(3, 7, 4, 35.00), (4, 8, 1, 180.00), (7, 5, 1, 45.00);
INSERT INTO Itens_Pecas_OS (fk_id_os, fk_id_peca, quantidade, valor_unitario_aplicado) VALUES 
(11, 1, 4, 1500.00), 
(12, 10, 2, 950.00), 
(15, 8, 3, 180.00),  
(13, 4, 4, 450.00),  
(14, 3, 6, 220.00); 


-- =============================================================================
-- 5 Queries de Negócio (Operacional)
-- =============================================================================

-- Quanto cada cliente deve pagar no total?
-- Cláusulas: SELECT, JOIN, GROUP BY, ORDER BY.
SELECT 
    os.id_os AS 'Nº OS',
    c.nome AS 'Cliente',
    v.modelo AS 'Veículo',
    os.valor_total AS 'Total Bruto',
    (os.valor_total * 0.9) AS 'Total com Desconto PIX (10%)'
FROM Ordens_Servico os
JOIN Veiculos v ON os.fk_id_veiculo = v.id_veiculo
JOIN Clientes c ON v.fk_id_cliente = c.id_cliente
ORDER BY os.valor_total DESC;


-- Quais serviços faturaram mais de R$ 2.500,00 por veículo?
-- Cláusulas: SELECT, JOIN, WHERE, ORDER BY.
SELECT 
    c.nome AS 'Cliente',
    v.modelo AS 'Veículo',
    os.id_os AS 'Nº da OS',
    os.valor_total AS 'Faturamento'
FROM Ordens_Servico os
JOIN Veiculos v ON os.fk_id_veiculo = v.id_veiculo
JOIN Clientes c ON v.fk_id_cliente = c.id_cliente
WHERE os.valor_total > 2500.00
ORDER BY os.valor_total DESC; 


-- Qual o faturamento total acumulado por cada tipo de serviço (Troca de óleo, Retífica, etc.) e quantas vezes cada um foi realizado?
-- Cláusulas: SELECT, SUM, COUNT, JOIN, GROUP BY, ORDER BY.
SELECT 
    sc.nome_servico AS 'Tipo de Serviço',
    COUNT(i.id_item) AS 'Total de Realizações',
    SUM(i.valor_unitario) AS 'Receita Gerada'
FROM Servicos_Catalogo sc
JOIN Itens_OS i ON sc.id_servico = i.fk_id_servico
GROUP BY sc.nome_servico
ORDER BY `Receita Gerada` DESC;


-- Qual o montante total "preso" em pagamentos pendentes por Cliente?
-- Cláusulas usadas: SELECT, SUM (Agregado), JOIN, WHERE, GROUP BY, ORDER BY.
SELECT 
    c.nome AS 'Cliente',
    c.telefone AS 'Contato',
    COUNT(os.id_os) AS 'Qtd OS Pendentes',
    SUM(os.valor_total) AS 'Total a Receber' 
FROM Clientes c
JOIN Veiculos v ON c.id_cliente = v.fk_id_cliente
JOIN Ordens_Servico os ON v.id_veiculo = os.fk_id_veiculo
WHERE os.status_pagamento = 'Pendente'
GROUP BY c.nome, c.telefone
ORDER BY `Total a Receber` DESC; 


-- Quais peças foram gastas nas OS que tiveram retífica?
-- Cláusulas: SELECT, JOIN, WHERE.
SELECT 
    os.id_os,
    p.descricao AS 'Peça',
    ip.quantidade
FROM Itens_Pecas_OS ip
JOIN Pecas p ON ip.fk_id_peca = p.id_peca
JOIN Ordens_Servico os ON ip.fk_id_os = os.id_os
JOIN Itens_OS io ON os.id_os = io.fk_id_os
JOIN Servicos_Catalogo sc ON io.fk_id_servico = sc.id_servico
WHERE sc.nome_servico = 'Retífica';


-- =============================================================================
-- 5 Queries Complexas (Tomada de Decisão / BI)
-- =============================================================================

-- Quem é o funcionário mais produtivo para bonificação?
-- Cláusulas: SELECT, GROUP BY, JOIN, Cálculo de Comissão.
SELECT 
    m.nome AS 'Mecânico',
    SUM(os.valor_total) AS 'Faturamento Total',
    COUNT(os.id_os) AS 'Qtd OS',
    SUM(os.valor_total * (m.comissao_percentual / 100)) AS 'Comissão a Pagar'
FROM Mecanicos m
JOIN Ordens_Servico os ON m.id_mecanico = os.fk_id_mecanico
GROUP BY m.nome
ORDER BY `Faturamento Total` DESC;


-- Quais serviços devo investir em marketing?
-- Cláusulas: GROUP BY, HAVING, JOIN.
SELECT 
    s.nome_servico,
    COUNT(i.id_item) AS 'Vezes Realizado',
    SUM(i.valor_unitario) AS 'Receita Total'
FROM Itens_OS i
JOIN Servicos_Catalogo s ON i.fk_id_servico = s.id_servico
GROUP BY s.nome_servico
HAVING `Receita Total` > 5000.00
ORDER BY `Receita Total` DESC;


-- O que preciso comprar urgente dos fornecedores?
-- Cláusulas: SELECT, JOIN, WHERE, ORDER BY.
SELECT 
    p.descricao AS 'Peça',
    p.estoque_atual AS 'Qtd Atual',
    f.razao_social AS 'Fornecedor',
    f.contato
FROM Pecas p
JOIN Fornecedores f ON p.fk_id_fornecedor = f.id_fornecedor
WHERE p.estoque_atual < 10 
ORDER BY p.estoque_atual ASC;


-- Qual marca de carro deixa mais lucro na oficina?
-- Cláusulas: AVG, GROUP BY, JOIN.
SELECT 
    v.marca,
    COUNT(os.id_os) AS 'Total Visitas',
    AVG(os.valor_total) AS 'Ticket Médio'
FROM Veiculos v
JOIN Ordens_Servico os ON v.id_veiculo = os.fk_id_veiculo
GROUP BY v.marca
ORDER BY `Ticket Médio` DESC;


-- O método 'Boleto' está gerando muita pendência?
-- Cláusulas: SELECT, GROUP BY, JOIN.
SELECT 
    mp.descricao AS 'Meio de Pagamento',
    os.status_pagamento,
    COUNT(*) AS 'Total de Casos',
    SUM(os.valor_total) AS 'Volume Financeiro'
FROM Ordens_Servico os
JOIN Metodos_Pagamento mp ON os.fk_id_metodo = mp.id_metodo
GROUP BY mp.descricao, os.status_pagamento
ORDER BY mp.descricao;














