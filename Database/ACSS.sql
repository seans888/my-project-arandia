-- MySQL Script generated by MySQL Workbench
-- 11/21/14 21:33:47
-- Model: New Model    Version: 1.0
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Cashier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cashier` (
  `Cashier_id` INT NOT NULL,
  `OR_num` VARCHAR(45) NOT NULL,
  `Amount_due` DECIMAL NULL,
  `Balance` DECIMAL NULL,
  `Payment_Type` VARCHAR(45) NULL,
  `Date_paid` DATE NULL,
  `Date_due` DATE NULL,
  PRIMARY KEY (`Cashier_id`, `OR_num`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Class` (
  `Class_id` INT NOT NULL,
  `Grd_Yr_level` VARCHAR(45) NULL,
  `Section` VARCHAR(45) NULL,
  PRIMARY KEY (`Class_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Student` (
  `Stud_id` INT NOT NULL,
  `Stud_fname` VARCHAR(45) NULL,
  `Stud_Mname` VARCHAR(45) NULL,
  `Stud_Lname` VARCHAR(45) NULL,
  `Stud_Email` VARCHAR(45) NULL,
  `Stud_Pass` VARCHAR(45) NULL,
  `Stud_addr` VARCHAR(45) NULL,
  `Studentcol` VARCHAR(45) NULL,
  `Cashier_Cashier_id` INT NOT NULL,
  `Cashier_OR_num` VARCHAR(45) NOT NULL,
  `Class_Class_id` INT NOT NULL,
  PRIMARY KEY (`Stud_id`, `Cashier_Cashier_id`, `Cashier_OR_num`, `Class_Class_id`),
  INDEX `fk_Student_Cashier1_idx` (`Cashier_Cashier_id` ASC, `Cashier_OR_num` ASC),
  INDEX `fk_Student_Class1_idx` (`Class_Class_id` ASC),
  CONSTRAINT `fk_Student_Cashier1`
    FOREIGN KEY (`Cashier_Cashier_id` , `Cashier_OR_num`)
    REFERENCES `mydb`.`Cashier` (`Cashier_id` , `OR_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Student_Class1`
    FOREIGN KEY (`Class_Class_id`)
    REFERENCES `mydb`.`Class` (`Class_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Subject`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Subject` (
  `Subj_code` INT NOT NULL,
  `Subj_desc` VARCHAR(45) NULL,
  `First_grading` DECIMAL NULL,
  `Second_grading` DECIMAL NULL,
  `Third_grading` DECIMAL NULL,
  `Fourth_grading` DECIMAL NULL,
  `Subjectcol` VARCHAR(45) NULL,
  `Student_Stud_id` INT NOT NULL,
  PRIMARY KEY (`Subj_code`, `Student_Stud_id`),
  INDEX `fk_Subject_Student1_idx` (`Student_Stud_id` ASC),
  CONSTRAINT `fk_Subject_Student1`
    FOREIGN KEY (`Student_Stud_id`)
    REFERENCES `mydb`.`Student` (`Stud_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Schedule` (
  `Sched_Code` CHAR(10) NOT NULL,
  `Sched_Day` VARCHAR(45) NULL,
  `Sched_Time` VARCHAR(45) NULL,
  `Subject_Subj_code` INT NOT NULL,
  `Class_Class_id` INT NOT NULL,
  PRIMARY KEY (`Sched_Code`, `Subject_Subj_code`, `Class_Class_id`),
  INDEX `fk_Schedule_Subject_idx` (`Subject_Subj_code` ASC),
  INDEX `fk_Schedule_Class1_idx` (`Class_Class_id` ASC),
  CONSTRAINT `fk_Schedule_Subject`
    FOREIGN KEY (`Subject_Subj_code`)
    REFERENCES `mydb`.`Subject` (`Subj_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Schedule_Class1`
    FOREIGN KEY (`Class_Class_id`)
    REFERENCES `mydb`.`Class` (`Class_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Registrar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Registrar` (
  `Reg_id` INT NOT NULL,
  `Enrolled_date` DATE NULL,
  `Prev_grade` DECIMAL NULL,
  `Registrarcol` VARCHAR(45) NULL,
  `Schedule_Sched_Code` CHAR(10) NOT NULL,
  `Schedule_Subject_Subj_code` INT NOT NULL,
  `Student_Stud_id` INT NOT NULL,
  `Student_Cashier_Cashier_id` INT NOT NULL,
  `Student_Cashier_OR_num` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Reg_id`, `Schedule_Sched_Code`, `Schedule_Subject_Subj_code`, `Student_Stud_id`, `Student_Cashier_Cashier_id`, `Student_Cashier_OR_num`),
  INDEX `fk_Registrar_Schedule1_idx` (`Schedule_Sched_Code` ASC, `Schedule_Subject_Subj_code` ASC),
  INDEX `fk_Registrar_Student1_idx` (`Student_Stud_id` ASC, `Student_Cashier_Cashier_id` ASC, `Student_Cashier_OR_num` ASC),
  CONSTRAINT `fk_Registrar_Schedule1`
    FOREIGN KEY (`Schedule_Sched_Code` , `Schedule_Subject_Subj_code`)
    REFERENCES `mydb`.`Schedule` (`Sched_Code` , `Subject_Subj_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Registrar_Student1`
    FOREIGN KEY (`Student_Stud_id` , `Student_Cashier_Cashier_id` , `Student_Cashier_OR_num`)
    REFERENCES `mydb`.`Student` (`Stud_id` , `Cashier_Cashier_id` , `Cashier_OR_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Teacher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Teacher` (
  `Tchr_id` INT NOT NULL,
  `Tchr_Fname` VARCHAR(45) NULL,
  `Tchr_Lname` VARCHAR(45) NULL,
  `Tchr_Aday` VARCHAR(45) NULL,
  `Tchr_Atime` VARCHAR(45) NULL,
  `Tchr_email` VARCHAR(45) NULL,
  PRIMARY KEY (`Tchr_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Teacher_teacher_Subject`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Teacher_teacher_Subject` (
  `Teacher_Tchr_id` INT NOT NULL,
  `Subject_Subj_code` INT NOT NULL,
  PRIMARY KEY (`Teacher_Tchr_id`, `Subject_Subj_code`),
  INDEX `fk_Teacher_teacher_Subject_Subject1_idx` (`Subject_Subj_code` ASC),
  CONSTRAINT `fk_Teacher_teacher_Subject_Teacher1`
    FOREIGN KEY (`Teacher_Tchr_id`)
    REFERENCES `mydb`.`Teacher` (`Tchr_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Teacher_teacher_Subject_Subject1`
    FOREIGN KEY (`Subject_Subj_code`)
    REFERENCES `mydb`.`Subject` (`Subj_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
