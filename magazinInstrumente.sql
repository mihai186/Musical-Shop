create schema `magazin`;
use `magazin`;

drop table if exists `instrumente`;

create table `instrumente`(
	idInstrument bigint not null auto_increment,
    categorie varchar(45) default null,
    nume varchar(45) default null,
    descriere text default null,
    pret double default null,
    pathImagine text default null,
    primary key (`idInstrument`)
    );

create table `utilizatori`(
	idUser bigint not null auto_increment,
    esteAdmin tinyint default null,
    nume varchar(45) default null,
    prenume varchar(45) default null,
    email varchar(45) default null,
    parola varchar(45) default null,
    username varchar(45) default null,
    primary key(`idUser`)
    );
    
create table `produseCos`(
	idIntrare bigint not null auto_increment,
    idUser bigint default null,
    idInstrument bigint default null,
    cantitate int default null,
    primary key (idIntrare)
    );
    
ALTER TABLE `magazin`.`produsecos` 
ADD INDEX `fk1_produsecos_idx` (`idUser` ASC) VISIBLE;
;
ALTER TABLE `magazin`.`produsecos` 
ADD CONSTRAINT `fk1_produsecos`
  FOREIGN KEY (`idUser`)
  REFERENCES `magazin`.`utilizatori` (`idUser`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `magazin`.`produsecos` 
ADD INDEX `fk2_produsecos_idx` (`idInstrument` ASC) VISIBLE;
;
ALTER TABLE `magazin`.`produsecos` 
ADD CONSTRAINT `fk2_produsecos`
  FOREIGN KEY (`idInstrument`)
  REFERENCES `magazin`.`instrumente` (`idInstrument`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

insert into `utilizatori` values (1, 1, "Stan", "Mihai", "abc@gmail.com", "parola", "admin1"), (2, 0, "Pancu", "Silviu", "cba@gmail.com", "parola2", "pranku"), (3, 1, "Capiteanu", "Maria", "miu@gmai.com","Magnus", "Mimimus");
insert into `instrumente` values
	(1, "Chitara", "Chitara Fender ESC-105 Classical", "Fender ESC-105 este o chitara clasica 4/4, cu scala de 25.5 inch, corp din molid si okoume laminat si tastiera din lemn de nuc. Aceasta este ideala pentru chitaristi incepatori si nu numai. In pachet este inclusa si o husa de transport.", "599.00","https://www.zeedoshop.ro/95022-large_default/fender-esc-105-classical.jpg"),
    (2, "Pian", "Pian Funkey DP-88 II White", "DP-88 II a fost conceput in special pentru pianistii incepatori ce cauta functionalitatea unei claviaturi moderne, dar doresc aspectul unui pian digital complet. Cu cele 88 de clape de pian, 360 de tonuri, acompaniament automat cu 160 de ritmuri, 80 de melodii demo, functia de invatare, playerul MP3 integrat si boxele stereo puternice, stabileste noi standarde in gama sa de preturi si incanta toti muzicienii. Culoare: Alb.", "2199.00", "https://www.zeedoshop.ro/68616-large_default/funkey-dp-88-ii-white.jpg");
insert into `produsecos` values (1, 2, 1, 2), (2, 2, 2, 1);
select * from utilizatori;