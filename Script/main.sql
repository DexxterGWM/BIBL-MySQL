SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP SCHEMA IF EXISTS `Biblioteca` ;

CREATE SCHEMA IF NOT EXISTS `Biblioteca` DEFAULT CHARACTER SET utf8 ;
USE `Biblioteca` ;

DROP TABLE IF EXISTS `Biblioteca`.`Livro` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`Livro` (
  `ISBN` INT NOT NULL,
  `Nome` VARCHAR(80) NOT NULL,
  `Autor` VARCHAR(50) NOT NULL,
  `Paginas` INT NULL,
  PRIMARY KEY (`ISBN`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `Biblioteca`.`Colaborador` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`Colaborador` (
  `CPF` INT NOT NULL,
  `Nome` VARCHAR(75) NOT NULL,
  `Email` VARCHAR(75) NOT NULL,
  `Cargo` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`CPF`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `Biblioteca`.`Emprestimo` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`Emprestimo` (
  `IDEmprestimo` INT NOT NULL,
  `DataEmprestimo` DATETIME NOT NULL,
  `DataDevolucao` DATETIME NOT NULL,
  `Livro_ISBN` INT NOT NULL,
  `Colaborador_CPF` INT NOT NULL,
  PRIMARY KEY (`IDEmprestimo`),
  CONSTRAINT `fk_Emprestimo_Livro10`
    FOREIGN KEY (`Livro_ISBN`)
    REFERENCES `Biblioteca`.`Livro` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Emprestimo_Colaborador10`
    FOREIGN KEY (`Colaborador_CPF`)
    REFERENCES `Biblioteca`.`Colaborador` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Emprestimo_Livro1_idx` ON `Biblioteca`.`Emprestimo` (`Livro_ISBN` ASC);
CREATE INDEX `fk_Emprestimo_Colaborador1_idx` ON `Biblioteca`.`Emprestimo` (`Colaborador_CPF` ASC);

DROP TABLE IF EXISTS `Biblioteca`.`Aluno` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`Aluno` (
  `RA` INT NOT NULL,
  `Nome` VARCHAR(65) NOT NULL,
  `Email` VARCHAR(65) NOT NULL,
  `Telefone` INT NOT NULL,
  `Emprestimo_IDEmprestimo` INT NOT NULL,
  PRIMARY KEY (`RA`, `Emprestimo_IDEmprestimo`),
  CONSTRAINT `fk_Aluno_Emprestimo1`
    FOREIGN KEY (`Emprestimo_IDEmprestimo`)
    REFERENCES `Biblioteca`.`Emprestimo` (`IDEmprestimo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Aluno_Emprestimo1_idx` ON `Biblioteca`.`Aluno` (`Emprestimo_IDEmprestimo` ASC);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
