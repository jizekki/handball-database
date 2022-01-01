-- ============================================================
-- Schema fshb
-- ============================================================
drop schema if exists fshb ;
create schema if not exists fshb default character set utf8 ;
use fshb ;


-- ============================================================
-- Table JOUEURS
-- ============================================================
drop table if exists JOUEURS;
create table if not exists JOUEURS
(
  NUMERO_DE_LICENCE                     int                     not null auto_increment,
  NOM_JOUEUR                            varchar(40)             not null,
  PRENOM_JOUEUR                         varchar(40)             not null,
  DATE_NAISSANCE                        date                    not null,
  EMAIL_JOUEUR                          varchar(50)             not null,
  TELEPHONE_JOUEUR                      varchar(10)             not null,
  constraint pk_joueurs primary key (NUMERO_DE_LICENCE) -- constraint for the primary key
);


-- ============================================================
--   Table : RESPONSABLES                                            
-- ============================================================
drop table if exists RESPONSABLES;
create table if not exists RESPONSABLES
(
    NUMERO_RESPONSABLE                   int(10)                not null auto_increment,
    NOM_RESPONSABLE                      varchar(20)            not null,
    PRENOM_RESPONSABLE                   varchar(20)            not null,
    POSTE                                varchar(40)                    ,
    EMAIL_RESPONSABLE                    varchar(50)            not null,
    TELEPHONE_RESPONSABLE                varchar(10)                not null,
    NUMERO_CLUB                          int(10)                not null, 
    constraint pk_responsables primary key (NUMERO_RESPONSABLE) -- constraint for the primary key
);


-- ============================================================
--   Table : ENTRAINEURS
-- ============================================================
drop table if exists ENTRAINEURS;
create table if not exists ENTRAINEURS
(
    NUMERO_ENTRAINEUR                   int(10)                 not null auto_increment,
    NOM_ENTRAINEUR                      varchar(20)             not null,
    PRENOM_ENTRAINEUR                   varchar(20)             not null,
    EMAIL_ENTRAINEUR                    varchar(50)             not null,
    TELEPHONE_ENTRAINEUR                varchar(10)                 not null,
    constraint pk_entraineurs primary key (NUMERO_ENTRAINEUR) -- constraint for the primary key
);


-- ============================================================
--   Table : CLUBS                                       
-- ============================================================
drop table if exists CLUBS;
create table if not exists CLUBS
(
    NUMERO_CLUB                         int(10)                 not null auto_increment,
    NOM_CLUB                            varchar(20)             not null,
    constraint pk_clubs primary key (NUMERO_CLUB) -- contrainte pour la clé primaire
);


-- ============================================================
--   Table : EQUIPES                           
-- ============================================================
drop table if exists EQUIPES;
create table if not exists EQUIPES
(
    NUMERO_EQUIPE                      int(10)                 not null auto_increment,
    NOM_EQUIPE                         varchar(30)             not null,
    CATEGORIE                          varchar(20)             not null,
    ORDRE_DANS_CATEGORIE               int(2)                          ,
    NUMERO_CLUB                        int(10)                 not null,
    
    
    constraint pk_equipes primary key (NUMERO_EQUIPE) -- contrainte pour la clé primaire
);


-- ============================================================
--   Table : SAISONS                           
-- ============================================================
drop table if exists SAISONS;
create table if not exists SAISONS
(
    NUMERO_SAISON                       int(20)                   not null auto_increment, 
    DATE_DE_DEBUT                       date                      not null,
    constraint pk_saisons primary key (NUMERO_SAISON) -- contrainte pour la clé primaire
);


-- ============================================================
-- Table RENCONTRES
-- ============================================================
drop table if exists RENCONTRES ;
create table if not exists RENCONTRES 
(
  NUMERO_DE_RENCONTRE                   int                     not null auto_increment,
  DATE_DE_RENCONTRE                     date                    not null,
  SCORE_EQUIPE_ACCUEILLANTE             int                     not null,
  SCORE_EQUIPE_RECUE                    int                     not null,
  NUMERO_EQUIPE_ACCUEILLANTE            int(10)                 not null,
  NUMERO_EQUIPE_RECUE                   int(10)                 not null,
  constraint pk_rencontres primary key (NUMERO_DE_RENCONTRE) -- contrainte pour la clé primaire
);


-- ============================================================
--   Table : DATES_ENTREE
-- ============================================================
drop table if exists DATES_ENTREE;
create table if not exists DATES_ENTREE
(
    DATE_ENTREE                         date                    not null,

    constraint pk_dates_entree primary key (DATE_ENTREE)                      
);


-- ============================================================
--   Table : PARTICIPER                           
-- ============================================================
drop table if exists PARTICIPER;
create table if not exists PARTICIPER
(
    NUMERO_DE_RENCONTRE                 int                     not null,
    NUMERO_DE_LICENCE                   int                     not null,
    NOMBRE_POINTS_MARQUES               int(3)                  not null,
    NOMBRE_FAUTES_COMMISES              int(5)                  not null, 
    constraint pk_participer primary key (NUMERO_DE_RENCONTRE, NUMERO_DE_LICENCE)
);


-- ============================================================
--   Table : SAISONS_JOUEES                    
-- ============================================================
drop table if exists SAISONS_JOUEES;
create table if not exists SAISONS_JOUEES
(
    NUMERO_SAISON                       int(20)                 not null,          
    NUMERO_DE_LICENCE                   int                     not null,
    constraint pk_saisons_jouees primary key (NUMERO_SAISON, NUMERO_DE_LICENCE)
);       


-- ============================================================
-- Table COMMENCER_A_JOUER
-- ============================================================
drop table if exists COMMENCER_A_JOUER ;
create table if not exists COMMENCER_A_JOUER 
(
  NUMERO_DE_LICENCE                     int                     not null,
  DATE_ENTREE                           date                    not null,
  NUMERO_EQUIPE                         int                     not null,
  constraint pk_commencer_a_jouer primary key (NUMERO_DE_LICENCE, DATE_ENTREE, NUMERO_EQUIPE) -- contrainte pour la clé primaire
);


-- ============================================================
--   Table : COMMENCER_A_ENTRAINER
-- ============================================================
drop table if exists COMMENCER_A_ENTRAINER;
create table if not exists COMMENCER_A_ENTRAINER
(
    NUMERO_ENTRAINEUR                   int(10)                    not null,
    DATE_ENTREE                          date                      not null,
    NUMERO_EQUIPE                             int(10)	           not null,
    constraint pk_commencer_a_entrainer primary key (NUMERO_ENTRAINEUR, DATE_ENTREE, NUMERO_EQUIPE) -- constraint for the primary key
);



-- ============================================================
--   Ajout des contraintes                         
-- ============================================================

alter table RESPONSABLES 
    add constraint fk_club foreign key (NUMERO_CLUB) -- constraint for the foreign key
        references CLUBS (NUMERO_CLUB)
        on delete cascade; 

alter table EQUIPES 
    add constraint fk_equipe foreign key (NUMERO_CLUB) -- constraint for the foreign key
        references CLUBS (NUMERO_CLUB)
        on delete cascade;
        
alter table RENCONTRES 
    add constraint fk_rencontre1 foreign key (NUMERO_EQUIPE_ACCUEILLANTE) -- constraint for the foreign key
        references EQUIPES (NUMERO_EQUIPE)
        on delete CASCADE,

    add constraint fk_rencontre2 foreign key (NUMERO_EQUIPE_RECUE) -- constraint for the foreign key
        references EQUIPES (NUMERO_EQUIPE)
        on delete cascade;


alter table SAISONS_JOUEES
    add constraint fk_saisons_jouee1 foreign key (NUMERO_DE_LICENCE) -- constraint for the foreign key
        references JOUEURS (NUMERO_DE_LICENCE)
        on delete cascade,

    add constraint fk_saisons_jouee2 foreign key  (NUMERO_SAISON) -- constraint for the foreign key
        references SAISONS (NUMERO_SAISON)
        on delete cascade;


alter table COMMENCER_A_JOUER
    add constraint fk_commencer_a_jouer1 foreign key (NUMERO_DE_LICENCE) -- constraint for the foreign key
        references JOUEURS (NUMERO_DE_LICENCE)
        on delete cascade,

    add constraint fk_commencer_a_jouer2 foreign key  (DATE_ENTREE) -- constraint for the foreign key
        references DATES_ENTREE (DATE_ENTREE)
        on delete cascade,

    add constraint fk_commencer_a_jouer3 foreign key  (NUMERO_EQUIPE) -- constraint for the foreign key
        references EQUIPES (NUMERO_EQUIPE)
        on delete cascade;

alter table COMMENCER_A_ENTRAINER
    add constraint fk_commencer_a_entrainer foreign key (NUMERO_ENTRAINEUR)  -- constraint for the foreign key
        references ENTRAINEURS (NUMERO_ENTRAINEUR)
        on delete cascade,

    add constraint fk_commencer_a_entrainer2 foreign key (DATE_ENTREE) -- constraint for the foreign key
        references DATES_ENTREE (DATE_ENTREE)
        on delete cascade,

    add constraint  fk_commencer_a_entrainer3  foreign key (NUMERO_EQUIPE) -- constraint for the foreign key
        references  EQUIPES (NUMERO_EQUIPE)
        on delete cascade;

alter table PARTICIPER
    add constraint fk_participer1 foreign key (NUMERO_DE_LICENCE) -- constraint for the foreign key
        references JOUEURS (NUMERO_DE_LICENCE)
        on delete cascade,

    add constraint fk_participer2 foreign key  (NUMERO_DE_RENCONTRE) -- constraint for the foreign key
        references RENCONTRES (NUMERO_DE_RENCONTRE)
        on delete cascade;