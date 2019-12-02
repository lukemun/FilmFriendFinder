-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema fff
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema fff
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fff` DEFAULT CHARACTER SET utf8 ;
USE `fff` ;

-- -----------------------------------------------------
-- Table `fff`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fff`.`User` ;

CREATE TABLE IF NOT EXISTS `fff`.`User` (
  `userID` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(128) NOT NULL,
  `resume` MEDIUMBLOB NULL,
  PRIMARY KEY (`userID`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fff`.`Project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fff`.`Project` ;

CREATE TABLE IF NOT EXISTS `fff`.`Project` (
  `projectID` INT NOT NULL AUTO_INCREMENT,
  `ownerID` INT NOT NULL,
  `title` VARCHAR(128) NOT NULL,
  `summary` LONGTEXT NOT NULL,
  `numRatings` INT NULL,
  `sumRatings` INT NULL,
  `avgRating` INT NULL,
  `created` DATE NOT NULL,
  PRIMARY KEY (`projectID`),
  INDEX `fk_Project_User1_idx` (`ownerID` ASC) ,
  CONSTRAINT `fk_Project_User1`
    FOREIGN KEY (`ownerID`)
    REFERENCES `fff`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fff`.`Position`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fff`.`Position` ;

CREATE TABLE IF NOT EXISTS `fff`.`Position` (
  `positionID` INT NOT NULL AUTO_INCREMENT,
  `position` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`positionID`))
ENGINE = InnoDB;

--
-- Dumping data for table `Position`
--

INSERT INTO `Position` (`positionID`, `position`) VALUES
(1, 'Producer'),
(2, 'Director'),
(3, 'Screenwriter'),
(5, 'Production Designer'),
(6, 'Art Director'),
(7, 'Costume Designer'),
(8, 'Cinematographer'),
(9, 'Editor'),
(11, 'Actor'),
(12, 'Actress'),
(13, 'Music Supervisor'),
(14, 'Other');

-- -----------------------------------------------------
-- Table `fff`.`UserToPosition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fff`.`UserToPosition` ;

CREATE TABLE IF NOT EXISTS `fff`.`UserToPosition` (
  `utpID` INT NOT NULL AUTO_INCREMENT,
  `userID` INT NOT NULL,
  `positionID` INT NOT NULL,
  PRIMARY KEY (`utpID`),
  INDEX `fk_UserToPosition_Position1_idx` (`positionID` ASC) ,
  INDEX `fk_UserToPosition_User1_idx` (`userID` ASC) ,
  CONSTRAINT `fk_UserToPosition_Position1`
    FOREIGN KEY (`positionID`)
    REFERENCES `fff`.`Position` (`positionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UserToPosition_User1`
    FOREIGN KEY (`userID`)
    REFERENCES `fff`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fff`.`ProjectToPosition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fff`.`ProjectToPosition` ;

CREATE TABLE IF NOT EXISTS `fff`.`ProjectToPosition` (
  `ptpID` INT NOT NULL,
  `projectID` INT NOT NULL,
  `positionID` INT NOT NULL,
  PRIMARY KEY (`ptpID`),
  INDEX `fk_ProjectToPosition_Position_idx` (`positionID` ASC) ,
  INDEX `fk_ProjectToPosition_Project1_idx` (`projectID` ASC) ,
  CONSTRAINT `fk_ProjectToPosition_Position`
    FOREIGN KEY (`positionID`)
    REFERENCES `fff`.`Position` (`positionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProjectToPosition_Project1`
    FOREIGN KEY (`projectID`)
    REFERENCES `fff`.`Project` (`projectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fff`.`Genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fff`.`Genre` ;

CREATE TABLE IF NOT EXISTS `fff`.`Genre` (
  `genreID` INT NOT NULL AUTO_INCREMENT,
  `genre` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`genreID`))
ENGINE = InnoDB;

--
-- Dumping data for table `Genre`
--

INSERT INTO `Genre` (`genreID`, `genre`) VALUES
(1, 'Action Adventure'),
(2, 'Animation'),
(3, 'Childrens'),
(4, 'Classic'),
(5, 'Comedy'),
(6, 'Documentary'),
(7, 'Drama'),
(8, 'Foreign'),
(9, 'Games'),
(10, 'Horror'),
(11, 'Karaoke'),
(12, 'Music'),
(13, 'Musical'),
(14, 'Romance'),
(15, 'Sci-Fi'),
(16, 'Special Interest'),
(17, 'Suspense Thriller'),
(18, 'Television Programming'),
(19, 'Western'),
(20, 'Other');


-- -----------------------------------------------------
-- Table `fff`.`UserToGenre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fff`.`UserToGenre` ;

CREATE TABLE IF NOT EXISTS `fff`.`UserToGenre` (
  `utgID` INT NOT NULL AUTO_INCREMENT,
  `userID` INT NOT NULL,
  `genreID` INT NOT NULL,
  PRIMARY KEY (`utgID`),
  INDEX `fk_UserToGenre_User1_idx` (`userID` ASC) ,
  INDEX `fk_UserToGenre_Genre1_idx` (`genreID` ASC) ,
  CONSTRAINT `fk_UserToGenre_User1`
    FOREIGN KEY (`userID`)
    REFERENCES `fff`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UserToGenre_Genre1`
    FOREIGN KEY (`genreID`)
    REFERENCES `fff`.`Genre` (`genreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fff`.`ProjectToGenre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fff`.`ProjectToGenre` ;

CREATE TABLE IF NOT EXISTS `fff`.`ProjectToGenre` (
  `ptgID` INT NOT NULL AUTO_INCREMENT,
  `projectID` INT NOT NULL,
  `genreID` INT NOT NULL,
  PRIMARY KEY (`ptgID`),
  INDEX `fk_ProjectToGenre_Project1_idx` (`projectID` ASC) ,
  INDEX `fk_ProjectToGenre_Genre1_idx` (`genreID` ASC) ,
  CONSTRAINT `fk_ProjectToGenre_Project1`
    FOREIGN KEY (`projectID`)
    REFERENCES `fff`.`Project` (`projectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProjectToGenre_Genre1`
    FOREIGN KEY (`genreID`)
    REFERENCES `fff`.`Genre` (`genreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fff`.`ProjectUsers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fff`.`ProjectUsers` ;

CREATE TABLE IF NOT EXISTS `fff`.`ProjectUsers` (
  `puID` INT NOT NULL AUTO_INCREMENT,
  `userID` INT NOT NULL,
  `projectID` INT NOT NULL,
  `positionID` INT NOT NULL,
  PRIMARY KEY (`puID`),
  INDEX `fk_ProjectUsers_User1_idx` (`userID` ASC) ,
  INDEX `fk_ProjectUsers_Project1_idx` (`projectID` ASC) ,
  INDEX `fk_ProjectUsers_Position1_idx` (`positionID` ASC) ,
  CONSTRAINT `fk_ProjectUsers_User1`
    FOREIGN KEY (`userID`)
    REFERENCES `fff`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProjectUsers_Project1`
    FOREIGN KEY (`projectID`)
    REFERENCES `fff`.`Project` (`projectID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProjectUsers_Position1`
    FOREIGN KEY (`positionID`)
    REFERENCES `fff`.`Position` (`positionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
