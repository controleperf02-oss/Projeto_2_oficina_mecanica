-- MySQL Workbench Synchronization
-- Generated: 2026-02-15 16:42
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: win10

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER TABLE `oficina_mecanica`.`clientes` 
COMMENT = 'Armazena dados cadastrais dos proprietários dos veículos. Chave primária usada para histórico de consumo.' ;

ALTER TABLE `oficina_mecanica`.`fornecedores` 
COMMENT = 'Empresas parceiras que fornecem peças. Essencial para rastreabilidade de garantia e reposição de estoque.' ;

ALTER TABLE `oficina_mecanica`.`itens_os` 
COMMENT = 'Relacionamento N:M entre OS e Serviços. Registra quais manutenções (mão de obra) foram feitas em cada OS.' ;

ALTER TABLE `oficina_mecanica`.`itens_pecas_os` 
COMMENT = 'Relacionamento N:M entre OS e Peças. Registra o consumo de material físico e o valor praticado na data.' ;

ALTER TABLE `oficina_mecanica`.`mecanicos` 
COMMENT = 'Tabela de funcionários técnicos. Inclui especialidade e comissão para cálculos de folha de pagamento.' ;

ALTER TABLE `oficina_mecanica`.`metodos_pagamento` 
COMMENT = 'Configuração de formas de recebimento. Define as regras de fluxo de caixa (PIX, Cartão, etc).' ;

ALTER TABLE `oficina_mecanica`.`ordens_servico` 
COMMENT = 'Tabela central de operações. Consolida o status da manutenção, o financeiro e o responsável técnico.' ;

ALTER TABLE `oficina_mecanica`.`pecas` 
COMMENT = 'Gestão de inventário físico. Controla saldo em estoque e custo de venda dos produtos aplicados.' ;

ALTER TABLE `oficina_mecanica`.`servicos_catalogo` 
COMMENT = 'Tabela de referência (Look-up) com a listagem de mão de obra e preços base de mercado.' ;

ALTER TABLE `oficina_mecanica`.`veiculos` 
COMMENT = 'Cadastro de frota atendida. Relaciona cada veículo a um único dono (1:N) através da FK_id_cliente.' ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;