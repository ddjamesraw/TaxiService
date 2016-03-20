SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


drop schema if EXISTS `taxiservice`;

CREATE SCHEMA IF NOT EXISTS `taxiservice` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;

use `taxiservice`;


CREATE TABLE IF NOT EXISTS `cartype`(
 `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
PRIMARY KEY (`id`))
ENGINE = InnoDB;

create table if not exists `carbrand`(
	`id` int not null auto_increment,
	`name` VARCHAR(45) not null,
    `cartype_id` int not null,
	primary key (`id`),
	INDEX `cartype_id_index` (`cartype_id` ASC),
	constraint `cartype_id_foreign`
	foreign key (`cartype_id`)
	references `taxiservice`.`cartype` (`id`)
	on delete no action
	on update no action)
Engine = InnoDB;

create table if not exists `carmodel`(
 `id` int not null auto_increment,
 `name` varchar(45) not null,
 `carbrand_id` int not null,
 primary key(`id`),
	INDEX `carbrand_id_index` (`carbrand_id` ASC),
  constraint `carbrand_id_foreign`
	foreign key (`carbrand_id`)
	references `taxiservice`.`carbrand`(`id`)
	on delete no action
	on update no action)
Engine = InnoDB;


create table if not exists `car_description`(
	`id` int not null auto_increment,
	`model_id` int not null,
	`callcost` int not null default 40000,
	`doors` INT NULL DEFAULT 2,
	`seats` INT NULL DEFAULT 2,
	`consumption` INT NOT NULL,
	`air_condition` TINYINT(1) NULL DEFAULT 0,
	`air_bags` TINYINT(1) NULL DEFAULT 0,
	`automatic` TINYINT(1) NULL DEFAULT 0,
	`description` TEXT NULL,
	PRIMARY KEY (`id`),
INDEX `model_id_index` (`model_id` ASC),
	CONSTRAINT `model_id`
    FOREIGN KEY (`model_id`)
    REFERENCES `taxiservice`.`carmodel` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

create table if not exists `user`(
	`id` int not null auto_increment,
	`name` VARCHAR(45) not null,
	`secondname` VARCHAR(45) not null,
	`lastname` VARCHAR(45) not null,
	`birthday` DATE not null,
	`phone` VARCHAR(45) not null,
	`email` VARCHAR(45) not null,
	`passportdata` VARCHAR(80) not null,
	`adress` VARCHAR(80) not null,
	`role` tinyint(2) not null default 0,
	`login` VARCHAR(45) not null unique,
	`password` VARCHAR(45) not null,
	primary key(`id`))
Engine = InnoDB;

create table if not exists `driver`(
	`id` int not null auto_increment,
	`car_description_id` int not null,
	`feedback_id` int not null,
	`license` int not null unique,
	`joindate` DATE not null,
	`isallowedtowork` bit not null default false,
	primary key (`id`),
	INDEX `car_description_id_index` (`car_description_id` ASC),

	constraint `user_id_foreign`
	foreign key (`id`)
	references `taxiservice`.`user` (`id`)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION,

	constraint `car_description_id_foreign`
	foreign key (`car_description_id`)
	references `taxiservice`.`car_description` (`id`)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION,

	constraint `feedback_id_foreign`
	foreign key (`feedback_id`)
	references `taxiservice`.`feedback` (`id`)
	on delete no action
	on update no action)
Engine = InnoDB;

create table if not exists `feedback`(
	`id` int not null auto_increment,
	`message` VARCHAR(256) null,
	`rating` tinyint(5) not null,
	primary key(`id`))
Engine=InnoDB;

create table if not exists `order`(
	`id` int not null auto_increment,
	`user_id` int not null,
	`driver_id` int not null,
	`startpoint` VARCHAR(100) not null,
	`destination` VARCHAR(100) not null,
	`taxcost` int not null default 10000,
	primary key(`id`),
	index `user_id_index` (`user_id` ASC),
	index `driver_id_index` (`driver_id` ASC),
	
	constraint `user_id_foreign_key`
	foreign key (`user_id`)
	references `taxiservice`.`user` (`id`)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION,

	constraint `driver_id_foreign`
	foreign key (`driver_id`)
	references `taxiservice`.`driver` (`id`)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION)
Engine = InnoDB; 

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

insert into `taxiservice`.`user` values(1,"vasya", "v", "b", "1998-05-25", "32352", "23123@213123", "HB2323", "MINSK", 0, "CCC", "CCC");
