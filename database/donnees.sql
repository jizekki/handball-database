-- =========================================================
-- suppression des donnees
-- =========================================================


start transaction;

delete from RENCONTRES; 
delete from EQUIPES;
delete from PARTICIPER;
delete from CLUBS; 
delete from JOUEURS; 
delete from RESPONSABLES; 
delete from COMMENCER_A_JOUER;
delete from COMMENCER_A_ENTRAINER; 
delete from ENTRAINEURS;    
delete from DATES_ENTREE;                     
delete from SAISONS;             
delete from SAISONS_JOUEES;

ALTER TABLE JOUEURS AUTO_INCREMENT = 1;
ALTER TABLE CLUBS AUTO_INCREMENT = 1;
ALTER TABLE RESPONSABLES AUTO_INCREMENT = 1;
ALTER TABLE ENTRAINEURS AUTO_INCREMENT = 1;
ALTER TABLE EQUIPES AUTO_INCREMENT = 1;
ALTER TABLE RENCONTRES AUTO_INCREMENT = 1;
ALTER TABLE SAISONS AUTO_INCREMENT = 1;

commit; 



-- =========================================================
-- creation des donnees
-- =========================================================

start transaction;

insert into CLUBS (NOM_CLUB) values ('REAL MADRID');
insert into CLUBS (NOM_CLUB) values ('BARCELONA');

commit;


start transaction;

insert into RESPONSABLES (NOM_RESPONSABLE, PRENOM_RESPONSABLE, POSTE, EMAIL_RESPONSABLE, TELEPHONE_RESPONSABLE, NUMERO_CLUB) values ('SAUTET'     , 'CLAUDE'       ,    'DIRECTEUR'    ,    'CLAUDE.SAUTET@GMAIL.COM'        ,   '0637890020'  ,   1);
insert into RESPONSABLES (NOM_RESPONSABLE, PRENOM_RESPONSABLE, POSTE, EMAIL_RESPONSABLE, TELEPHONE_RESPONSABLE, NUMERO_CLUB) values ('LYNE'       , 'ADRIAN'       ,    'MANAGER'      ,    'ADRIAN.LYNE@GMAIL.COM'          ,   '0610890750'  ,   1);
insert into RESPONSABLES (NOM_RESPONSABLE, PRENOM_RESPONSABLE, POSTE, EMAIL_RESPONSABLE, TELEPHONE_RESPONSABLE, NUMERO_CLUB) values ('TRUFFAUT'   , 'FRANCOIS'     ,    'DIRECTEUR'    ,    'FRANCOIS.TRUFFAUT@GMAIL.COM'    ,   '0620142760'  ,   2);
insert into RESPONSABLES (NOM_RESPONSABLE, PRENOM_RESPONSABLE, POSTE, EMAIL_RESPONSABLE, TELEPHONE_RESPONSABLE, NUMERO_CLUB) values ('COCTEAU'    , 'JEAN'         ,    'MANAGER'      ,    'JEAN.COCTEAU@GMAIL.COM'         ,   '0630098457'  ,   2);

commit;

start transaction;

insert into ENTRAINEURS (NOM_ENTRAINEUR, PRENOM_ENTRAINEUR, EMAIL_ENTRAINEUR, TELEPHONE_ENTRAINEUR) values ('MONTAND'    ,   'YVES'      ,    'YVES.MONTAND@GMAIL.COM'       ,   '0606484500');
insert into ENTRAINEURS (NOM_ENTRAINEUR, PRENOM_ENTRAINEUR, EMAIL_ENTRAINEUR, TELEPHONE_ENTRAINEUR) values ('GARCIA'     ,   'NICOLE'    ,    'NICOLE.GARCIA@GMAIL.COM'      ,   '0619834200');
insert into ENTRAINEURS (NOM_ENTRAINEUR, PRENOM_ENTRAINEUR, EMAIL_ENTRAINEUR, TELEPHONE_ENTRAINEUR) values ('VILLERET'   ,   'JACQUES'   ,    'JACQUES.VILLERET@GMAIL.COM'   ,   '0620198740');
insert into ENTRAINEURS (NOM_ENTRAINEUR, PRENOM_ENTRAINEUR, EMAIL_ENTRAINEUR, TELEPHONE_ENTRAINEUR) values ('DUBOIS'     ,   'MARIE'     ,    'MARIE.DUBOIS@GMAIL.COM'       ,   '0630249860');

commit;


start transaction;

insert into EQUIPES (NOM_EQUIPE, CATEGORIE, ORDRE_DANS_CATEGORIE, NUMERO_CLUB) values ('REAL MADRID 2'   ,   'JUNIOR'      ,    1    ,   1);
insert into EQUIPES (NOM_EQUIPE, CATEGORIE, ORDRE_DANS_CATEGORIE, NUMERO_CLUB) values ('BARCELONA 1'     ,   'CADET'       ,    1    ,   2);
insert into EQUIPES (NOM_EQUIPE, CATEGORIE, ORDRE_DANS_CATEGORIE, NUMERO_CLUB) values ('BARCELONA 2'     ,   'JUNIOR'      ,    1    ,   2);
insert into EQUIPES (NOM_EQUIPE, CATEGORIE, ORDRE_DANS_CATEGORIE, NUMERO_CLUB) values ('REAL MADRID 1'   ,   'CADET'       ,    1    ,   1);

commit;


start transaction;

insert into JOUEURS (NOM_JOUEUR, PRENOM_JOUEUR, DATE_NAISSANCE, EMAIL_JOUEUR, TELEPHONE_JOUEUR) values ('SCHNEIDER'      ,       'ROMY'       ,    '1990-01-01'    ,    'SCHNEIDER.ROMY@GMAIL.COM'       ,   '0644597643');
insert into JOUEURS (NOM_JOUEUR, PRENOM_JOUEUR, DATE_NAISSANCE, EMAIL_JOUEUR, TELEPHONE_JOUEUR) values ('FREY'           ,       'SAMY'       ,    '1992-10-23'    ,    'FREY.SAMY@GMAIL.COM'            ,   '0610874502');
insert into JOUEURS (NOM_JOUEUR, PRENOM_JOUEUR, DATE_NAISSANCE, EMAIL_JOUEUR, TELEPHONE_JOUEUR) values ('RICARDO'        ,       'BRUNOZZI'   ,    '1991-05-17'    ,    'RICARDO.BRUNOZZI@GMAIL.COM'     ,   '0620420100');
insert into JOUEURS (NOM_JOUEUR, PRENOM_JOUEUR, DATE_NAISSANCE, EMAIL_JOUEUR, TELEPHONE_JOUEUR) values ('DUPRILLOT'      ,       'JOHEL'      ,    '1993-08-07'    ,    'DUPRILLOT.JOHEL@GMAIL.COM'      ,   '0634025710');
insert into JOUEURS (NOM_JOUEUR, PRENOM_JOUEUR, DATE_NAISSANCE, EMAIL_JOUEUR, TELEPHONE_JOUEUR) values ('LESTRADOS'      ,       'DOMINIQUOS' ,    '1990-01-01'    ,    'LESTRADOS.DOMINIQUOS@GMAIL.COM' ,   '0420327690');
insert into JOUEURS (NOM_JOUEUR, PRENOM_JOUEUR, DATE_NAISSANCE, EMAIL_JOUEUR, TELEPHONE_JOUEUR) values ('DELON'          ,       'ALAIN'      ,    '1992-10-23'    ,    'DELON.ALAIN@GMAIL.COM'          ,   '0610004200');
insert into JOUEURS (NOM_JOUEUR, PRENOM_JOUEUR, DATE_NAISSANCE, EMAIL_JOUEUR, TELEPHONE_JOUEUR) values ('VENTURA'        ,       'LINO'       ,    '1991-05-17'    ,    'VENTURA.LINO@GMAIL.COM'         ,   '0620984530');
insert into JOUEURS (NOM_JOUEUR, PRENOM_JOUEUR, DATE_NAISSANCE, EMAIL_JOUEUR, TELEPHONE_JOUEUR) values ('MASSARI'        ,       'LEA'        ,    '1993-08-07'    ,    'MASSARI.LEA@GMAIL.COM'          ,   '0630070120');
insert into JOUEURS (NOM_JOUEUR, PRENOM_JOUEUR, DATE_NAISSANCE, EMAIL_JOUEUR, TELEPHONE_JOUEUR) values ('POIRET'         ,       'JEAN'       ,    '1990-01-01'    ,    'POIRET.JEAN@GMAIL.COM'          ,   '0604217009');
insert into JOUEURS (NOM_JOUEUR, PRENOM_JOUEUR, DATE_NAISSANCE, EMAIL_JOUEUR, TELEPHONE_JOUEUR) values ('CLUZET'         ,       'FRANCOIS'   ,    '1992-10-23'    ,    'CLUZET.FRANCOIS@GMAIL.COM'      ,   '0610001010');
insert into JOUEURS (NOM_JOUEUR, PRENOM_JOUEUR, DATE_NAISSANCE, EMAIL_JOUEUR, TELEPHONE_JOUEUR) values ('MALAVOY'        ,       'CHRISTOPHE' ,    '1991-05-17'    ,    'MALAVOY.CHRISTOPHE@GMAIL.COM'   ,   '0620028760');
insert into JOUEURS (NOM_JOUEUR, PRENOM_JOUEUR, DATE_NAISSANCE, EMAIL_JOUEUR, TELEPHONE_JOUEUR) values ('BOURVIL'        ,       'BOURVIL'    ,    '1993-08-07'    ,    'BOURVIL.BOURVIL@GMAIL.COM'      ,   '0420044231');
insert into JOUEURS (NOM_JOUEUR, PRENOM_JOUEUR, DATE_NAISSANCE, EMAIL_JOUEUR, TELEPHONE_JOUEUR) values ('ROBERT'         ,       'YVES'       ,    '1990-01-01'    ,    'ROBERT.YVES@GMAIL.COM'          ,   '0609840430');
insert into JOUEURS (NOM_JOUEUR, PRENOM_JOUEUR, DATE_NAISSANCE, EMAIL_JOUEUR, TELEPHONE_JOUEUR) values ('MANESSE'        ,       'GASPARD'    ,    '1992-10-23'    ,    'MANESSE.GASPARD@GMAIL.COM'      ,   '0610134280');
insert into JOUEURS (NOM_JOUEUR, PRENOM_JOUEUR, DATE_NAISSANCE, EMAIL_JOUEUR, TELEPHONE_JOUEUR) values ('BELLI'          ,       'AGOSTINA'   ,    '1991-05-17'    ,    'BELLI.AGOSTINA@GMAIL.COM'       ,   '0620987638');
insert into JOUEURS (NOM_JOUEUR, PRENOM_JOUEUR, DATE_NAISSANCE, EMAIL_JOUEUR, TELEPHONE_JOUEUR) values ('BRASSEUR'       ,       'CLAUDE'     ,    '1993-08-07'    ,    'BRASSEUR.CLAUDE@GMAIL.COM'      ,   '0642893461');

commit;


start transaction;

insert into RENCONTRES (DATE_DE_RENCONTRE, SCORE_EQUIPE_ACCUEILLANTE, SCORE_EQUIPE_RECUE, NUMERO_EQUIPE_ACCUEILLANTE, NUMERO_EQUIPE_RECUE) values ('2017-12-31'   ,   34    ,    30    ,   1   ,   3);
insert into RENCONTRES (DATE_DE_RENCONTRE, SCORE_EQUIPE_ACCUEILLANTE, SCORE_EQUIPE_RECUE, NUMERO_EQUIPE_ACCUEILLANTE, NUMERO_EQUIPE_RECUE) values ('2018-01-15'   ,   32    ,    28    ,   3   ,   1);
insert into RENCONTRES (DATE_DE_RENCONTRE, SCORE_EQUIPE_ACCUEILLANTE, SCORE_EQUIPE_RECUE, NUMERO_EQUIPE_ACCUEILLANTE, NUMERO_EQUIPE_RECUE) values ('2017-04-17'   ,   35    ,    36    ,   2   ,   4);
insert into RENCONTRES (DATE_DE_RENCONTRE, SCORE_EQUIPE_ACCUEILLANTE, SCORE_EQUIPE_RECUE, NUMERO_EQUIPE_ACCUEILLANTE, NUMERO_EQUIPE_RECUE) values ('2018-02-22'   ,   40    ,    42    ,   4   ,   2);
insert into RENCONTRES (DATE_DE_RENCONTRE, SCORE_EQUIPE_ACCUEILLANTE, SCORE_EQUIPE_RECUE, NUMERO_EQUIPE_ACCUEILLANTE, NUMERO_EQUIPE_RECUE) values ('2018-02-22'   ,   3     ,    2     ,   4   ,   2);

commit;



start transaction;

insert into SAISONS (DATE_DE_DEBUT) values ('2017-01-01');
insert into SAISONS (DATE_DE_DEBUT) values ('2018-01-01');
insert into SAISONS (DATE_DE_DEBUT) values ('2019-01-01');
insert into SAISONS (DATE_DE_DEBUT) values ('2020-01-01');

commit;




start transaction;

insert into DATES_ENTREE values ('2017-12-31');
insert into DATES_ENTREE values ('2017-01-15');
insert into DATES_ENTREE values ('2018-01-17');
insert into DATES_ENTREE values ('2019-02-22');
insert into DATES_ENTREE values ('2017-03-11');
insert into DATES_ENTREE values ('2017-03-21');
insert into DATES_ENTREE values ('2019-12-31');
insert into DATES_ENTREE values ('2017-03-15');
insert into DATES_ENTREE values ('2017-01-17');
insert into DATES_ENTREE values ('2018-02-22');
insert into DATES_ENTREE values ('2017-03-12');
insert into DATES_ENTREE values ('2018-03-21');



start transaction;

insert into COMMENCER_A_JOUER values (1     ,   '2017-12-31'   , 1);
insert into COMMENCER_A_JOUER values (2     ,   '2017-01-15'   , 1);
insert into COMMENCER_A_JOUER values (3     ,   '2019-02-22'   , 1);
insert into COMMENCER_A_JOUER values (4     ,   '2017-01-17'   , 1);
insert into COMMENCER_A_JOUER values (5     ,   '2018-03-21'   , 2);
insert into COMMENCER_A_JOUER values (6     ,   '2017-01-15'   , 2);
insert into COMMENCER_A_JOUER values (7     ,   '2017-03-11'   , 2);
insert into COMMENCER_A_JOUER values (8     ,   '2018-02-22'   , 2);
insert into COMMENCER_A_JOUER values (9     ,   '2017-03-11'   , 3);
insert into COMMENCER_A_JOUER values (10    ,   '2017-01-15'   , 3);
insert into COMMENCER_A_JOUER values (11    ,   '2019-12-31'   , 3);
insert into COMMENCER_A_JOUER values (12    ,   '2017-03-21'   , 3);
insert into COMMENCER_A_JOUER values (13    ,   '2017-12-31'   , 4);
insert into COMMENCER_A_JOUER values (14    ,   '2017-03-11'   , 4);
insert into COMMENCER_A_JOUER values (15    ,   '2019-02-22'   , 4);
insert into COMMENCER_A_JOUER values (16    ,   '2017-01-17'   , 4);

commit;


start transaction;

insert into COMMENCER_A_ENTRAINER values (1    ,   '2017-12-31'     , 1);
insert into COMMENCER_A_ENTRAINER values (2    ,   '2018-03-21'     , 2);
insert into COMMENCER_A_ENTRAINER values (3    ,   '2017-03-11'     , 3);
insert into COMMENCER_A_ENTRAINER values (4    ,   '2018-01-17'     , 4);

commit;


start transaction;

insert into SAISONS_JOUEES values (1    ,   1    );
insert into SAISONS_JOUEES values (1    ,   2    );
insert into SAISONS_JOUEES values (1    ,   3    );
insert into SAISONS_JOUEES values (1    ,   4    );
insert into SAISONS_JOUEES values (1    ,   5    );
insert into SAISONS_JOUEES values (1    ,   6    );
insert into SAISONS_JOUEES values (1    ,   7    );
insert into SAISONS_JOUEES values (1    ,   8    );
insert into SAISONS_JOUEES values (1    ,   9    );
insert into SAISONS_JOUEES values (1    ,   10   );
insert into SAISONS_JOUEES values (1    ,   11   );
insert into SAISONS_JOUEES values (1    ,   12   );
insert into SAISONS_JOUEES values (1    ,   13   );
insert into SAISONS_JOUEES values (1    ,   14   );
insert into SAISONS_JOUEES values (1    ,   15   );
insert into SAISONS_JOUEES values (1    ,   16   );

insert into SAISONS_JOUEES values (2    ,   1    );
insert into SAISONS_JOUEES values (2    ,   2    );
insert into SAISONS_JOUEES values (2    ,   3    );
insert into SAISONS_JOUEES values (2    ,   4    );
insert into SAISONS_JOUEES values (2    ,   5    );
insert into SAISONS_JOUEES values (2    ,   6    );
insert into SAISONS_JOUEES values (2    ,   7    );
insert into SAISONS_JOUEES values (2    ,   8    );
insert into SAISONS_JOUEES values (2    ,   9    );
insert into SAISONS_JOUEES values (2    ,   10   );
insert into SAISONS_JOUEES values (2    ,   11   );
insert into SAISONS_JOUEES values (2    ,   12   );
insert into SAISONS_JOUEES values (2    ,   13   );
insert into SAISONS_JOUEES values (2    ,   14   );
insert into SAISONS_JOUEES values (2    ,   15   );
insert into SAISONS_JOUEES values (2    ,   16   );

insert into SAISONS_JOUEES values (3    ,   1    );
insert into SAISONS_JOUEES values (3    ,   2    );
insert into SAISONS_JOUEES values (3    ,   3    );
insert into SAISONS_JOUEES values (3    ,   4    );
insert into SAISONS_JOUEES values (3    ,   5    );
insert into SAISONS_JOUEES values (3    ,   6    );
insert into SAISONS_JOUEES values (3    ,   7    );
insert into SAISONS_JOUEES values (3    ,   8    );
insert into SAISONS_JOUEES values (3    ,   9    );
insert into SAISONS_JOUEES values (3    ,   10   );
insert into SAISONS_JOUEES values (3    ,   11   );
insert into SAISONS_JOUEES values (3    ,   12   );
insert into SAISONS_JOUEES values (3    ,   13   );
insert into SAISONS_JOUEES values (3    ,   14   );
insert into SAISONS_JOUEES values (3    ,   15   );
insert into SAISONS_JOUEES values (3    ,   16   );

insert into SAISONS_JOUEES values (4    ,   1    );
insert into SAISONS_JOUEES values (4    ,   2    );
insert into SAISONS_JOUEES values (4    ,   3    );
insert into SAISONS_JOUEES values (4    ,   4    );
insert into SAISONS_JOUEES values (4    ,   5    );
insert into SAISONS_JOUEES values (4    ,   6    );
insert into SAISONS_JOUEES values (4    ,   7    );
insert into SAISONS_JOUEES values (4    ,   8    );
insert into SAISONS_JOUEES values (4    ,   9    );
insert into SAISONS_JOUEES values (4    ,   10   );
insert into SAISONS_JOUEES values (4    ,   11   );
insert into SAISONS_JOUEES values (4    ,   12   );
insert into SAISONS_JOUEES values (4    ,   13   );
insert into SAISONS_JOUEES values (4    ,   14   );
insert into SAISONS_JOUEES values (4    ,   15   );
insert into SAISONS_JOUEES values (4    ,   16   );

commit;


start transaction;

insert into PARTICIPER values (1    ,  1   ,  8    ,  2);
insert into PARTICIPER values (1    ,  2   ,  9    ,  3);
insert into PARTICIPER values (1    ,  3   ,  6    ,  2);
insert into PARTICIPER values (1    ,  4   ,  7    ,  1);
insert into PARTICIPER values (1    ,  5   ,  9    ,  3);
insert into PARTICIPER values (1    ,  6   ,  7    ,  2);
insert into PARTICIPER values (1    ,  7   ,  6    ,  3);
insert into PARTICIPER values (1    ,  8   ,  9    ,  5);
insert into PARTICIPER values (4    ,  9   ,  9    ,  0);
insert into PARTICIPER values (4    ,  10  ,  8    ,  3);
insert into PARTICIPER values (4    ,  11  ,  4    ,  1);
insert into PARTICIPER values (4    ,  12  ,  10   ,  3);
insert into PARTICIPER values (4    ,  13  ,  10   ,  2);
insert into PARTICIPER values (4    ,  14  ,  7    ,  3);
insert into PARTICIPER values (4    ,  15  ,  7    ,  0);
insert into PARTICIPER values (4    ,  16  ,  5    ,  4);

insert into PARTICIPER values (2    ,  1   ,  9  ,  2);
insert into PARTICIPER values (2    ,  2   ,  8  ,  3);
insert into PARTICIPER values (2    ,  3   ,  7  ,  0);
insert into PARTICIPER values (2    ,  4   ,  6  ,  0);
insert into PARTICIPER values (2    ,  5   ,  10 ,  2);
insert into PARTICIPER values (2    ,  6   ,  5  ,  3);
insert into PARTICIPER values (2    ,  7   ,  7  ,  5);
insert into PARTICIPER values (2    ,  8   ,  8  ,  4);
insert into PARTICIPER values (3    ,  9   ,  8  ,  2);
insert into PARTICIPER values (3    ,  10  ,  6  ,  3);
insert into PARTICIPER values (3    ,  11  ,  6  ,  3);
insert into PARTICIPER values (3    ,  12  ,  7  ,  1);
insert into PARTICIPER values (3    ,  13  ,  9  ,  3);
insert into PARTICIPER values (3    ,  14  ,  5  ,  4);
insert into PARTICIPER values (3    ,  15  ,  6  ,  5);
insert into PARTICIPER values (3    ,  16  ,  9  ,  2);

commit;



-- ============================================================
--    verification des donnees
-- ============================================================

select count(*),'= 2 ?','CLUBS' from CLUBS 
union
select count(*),'= 4 ?','RESPONSABLES' from RESPONSABLES 
union
select count(*),'= 4 ?','EQUIPES' from EQUIPES
union
select count(*),'= 4 ?','ENTRAINEURS' from ENTRAINEURS
union
select count(*),'= 16 ?','JOUEURS' from JOUEURS
union
select count(*),'= 5 ?','RENCONTRES' from RENCONTRES
union
select count(*),'= 12 ?','DATES_ENTREE' from DATES_ENTREE
union
select count(*),'= 16 ?','COMMENCER_A_JOUER' from COMMENCER_A_JOUER
union
select count(*),'= 4 ?','COMMENCER_A_ENTRAINER' from COMMENCER_A_ENTRAINER
union
select count(*),'= 64 ?','SAISONS_JOUEES' from SAISONS_JOUEES
union
select count(*),'= 32 ?','PARTICIPER' from PARTICIPER
union
select count(*),'= 4 ?','SAISONS' from SAISONS  ; 

