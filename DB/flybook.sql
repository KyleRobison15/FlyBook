-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema FlyBook
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `FlyBook` ;

-- -----------------------------------------------------
-- Schema FlyBook
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `FlyBook` DEFAULT CHARACTER SET utf8 ;
USE `FlyBook` ;

-- -----------------------------------------------------
-- Table `fly`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fly` ;

CREATE TABLE IF NOT EXISTS `fly` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(255) NULL,
  `password` VARCHAR(255) NULL,
  `first_name` VARCHAR(255) NULL,
  `last_name` VARCHAR(255) NULL,
  `email` VARCHAR(255) NULL,
  `active` TINYINT NULL,
  `role` VARCHAR(45) NULL,
  `create_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_fly`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_fly` ;

CREATE TABLE IF NOT EXISTS `user_fly` (
  `user_id` INT NOT NULL,
  `fly_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `fly_id`),
  INDEX `fk_user_has_fly_fly1_idx` (`fly_id` ASC),
  INDEX `fk_user_has_fly_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_fly_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_fly_fly1`
    FOREIGN KEY (`fly_id`)
    REFERENCES `fly` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS flybook@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'flybook'@'localhost' IDENTIFIED BY 'flybook';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'flybook'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `fly`
-- -----------------------------------------------------
START TRANSACTION;
USE `FlyBook`;
INSERT INTO `fly` (`id`, `name`) VALUES (1, 'Pat\'s Rubber Legs');
INSERT INTO `fly` (`id`, `name`) VALUES (2, 'Zebra Midge');
INSERT INTO `fly` (`id`, `name`) VALUES (DEFAULT, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `FlyBook`;
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `active`, `role`, `create_date`) VALUES (1, 'KyleRobison', NULL, 'Kyle', 'Robison', 'kylerobison15@gmail.com', 1, 'admin', '2021-09-07');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `active`, `role`, `create_date`) VALUES (2, 'TestUser1', NULL, 'Joe', 'Smith', 'joesmith@example.com', 1, 'standard', '2021-09-07');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `active`, `role`, `create_date`) VALUES (3, 'TestUser2', NULL, 'Jane', 'Smith', 'janesmith@example.com', 1, 'standard', '2021-09-07');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_fly`
-- -----------------------------------------------------
START TRANSACTION;
USE `FlyBook`;
INSERT INTO `user_fly` (`user_id`, `fly_id`) VALUES (1, 1);
INSERT INTO `user_fly` (`user_id`, `fly_id`) VALUES (1, 2);
INSERT INTO `user_fly` (`user_id`, `fly_id`) VALUES (2, 1);
INSERT INTO `user_fly` (`user_id`, `fly_id`) VALUES (2, 2);
INSERT INTO `user_fly` (`user_id`, `fly_id`) VALUES (3, 1);
INSERT INTO `user_fly` (`user_id`, `fly_id`) VALUES (3, 2);

COMMIT;

