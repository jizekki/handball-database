-- ============================================================
--   Requetes de statistiques
-- ============================================================

-- moyenne des points marqués PAR RENCONTRE à une date donnée
select DATE_DE_RENCONTRE, AVG( R.SCORE_EQUIPE_ACCUEILLANTE + R.SCORE_EQUIPE_RECUE ) as MOYENNE_POINTS
    from RENCONTRES R
    group by 1
    ;


-- moyenne des points marqués depuis le début de la saison
select S.NUMERO_SAISON, S.DATE_DE_DEBUT as DEBUT_DE_SAISON , AVG( (R.SCORE_EQUIPE_ACCUEILLANTE + R.SCORE_EQUIPE_RECUE)/2 )
    from RENCONTRES R, PARTICIPER P, JOUEURS J, SAISONS_JOUEES SJ, SAISONS S
    where R.NUMERO_DE_RENCONTRE = P.NUMERO_DE_RENCONTRE
        and P.NUMERO_DE_LICENCE = J.NUMERO_DE_LICENCE
        and J.NUMERO_DE_LICENCE = SJ.NUMERO_DE_LICENCE
        and SJ.NUMERO_SAISON = S.NUMERO_SAISON
	and R.DATE_DE_RENCONTRE > S.DATE_DE_DEBUT
    group by 1, 2;


-- liste des joueurs à une date donnée
select R.DATE_DE_RENCONTRE,J.NUMERO_DE_LICENCE,J.NOM_JOUEUR,J.PRENOM_JOUEUR,P.NOMBRE_POINTS_MARQUES,P.NOMBRE_FAUTES_COMMISES
    from RENCONTRES R, PARTICIPER P, JOUEURS J where R.NUMERO_DE_RENCONTRE = P.NUMERO_DE_RENCONTRE and P.NUMERO_DE_LICENCE = J.NUMERO_DE_LICENCE
    order by 5 DESC,6 ASC;


-- creation d'une vue pour le classement des equipes a une saison donnée
create or replace view TAB (SAISON,NUM_EQUIPE,RENCONTRE,DATE,W,L,N)
as select S.NUMERO_SAISON SAISON,
    R.NUMERO_EQUIPE_ACCUEILLANTE as NUM_EQUIPE,
    R.NUMERO_DE_RENCONTRE as RENCONTRE, 
    R.DATE_DE_RENCONTRE as DATE,
    count(case when R.SCORE_EQUIPE_ACCUEILLANTE>R.SCORE_EQUIPE_RECUE then 1 else null end) as W,
    count(case when R.SCORE_EQUIPE_ACCUEILLANTE<R.SCORE_EQUIPE_RECUE then 1 else null end) as L,
    count(case when R.SCORE_EQUIPE_ACCUEILLANTE=R.SCORE_EQUIPE_RECUE then 1 else null end) as N
    from RENCONTRES R,SAISONS S
    where DATEDIFF(R.DATE_DE_RENCONTRE,S.DATE_DE_DEBUT) < 365 and DATEDIFF(R.DATE_DE_RENCONTRE,S.DATE_DE_DEBUT)>0
    group by 1,2,3,4

union

select S.NUMERO_SAISON SAISON,
    R.NUMERO_EQUIPE_RECUE as NUM_EQUIPE,
    R.NUMERO_DE_RENCONTRE as RENCONTRE, 
    R.DATE_DE_RENCONTRE as DATE,
    count(case when R.SCORE_EQUIPE_ACCUEILLANTE<R.SCORE_EQUIPE_RECUE then 1 else null end) as W,
    count(case when R.SCORE_EQUIPE_ACCUEILLANTE>R.SCORE_EQUIPE_RECUE then 1 else null end) as L,
    count(case when R.SCORE_EQUIPE_ACCUEILLANTE=R.SCORE_EQUIPE_RECUE then 1 else null end) as N
    from RENCONTRES R, SAISONS S
    where DATEDIFF(R.DATE_DE_RENCONTRE,S.DATE_DE_DEBUT) < 365 and DATEDIFF(R.DATE_DE_RENCONTRE,S.DATE_DE_DEBUT)>0
    group by 1,2,3,4
;

-- pour un classement dans une saison donnée des equipes
select TAB.NUM_EQUIPE,E.NOM_EQUIPE,SUM(TAB.W) as W,SUM(TAB.L) as L,SUM(TAB.N) as N 
    from TAB , EQUIPES E where E.NUMERO_EQUIPE = TAB.NUM_EQUIPE and TAB.SAISON = 2 group by 1,2 
    order by 3 DESC, 4 ASC ,5 DESC;

    


-- ---------- EXEMPLES : REQUETES DE MISE À JOUR ------------

-- Ajout d'un joueur 
insert into JOUEURS values (13732  ,   'HAMID'    ,   'TIRACHRACH'   ,   '1990-08-07'    ,    'HAMID3@GMAIL.COM' ,   0630797500);
commit;


-- Suppression d'un joueur
delete from JOUEURS where NOM_JOUEUR = 'HAMID';
commit;


-- Modification de quelques joueurs
update JOUEURS set TELEPHONE_JOUEUR = 630071080 where NUMERO_DE_LICENCE = 10424;
commit;
update CLUBS set NOM_CLUB = 'INTER MILAN' where NOM_CLUB = 'BARCELONA';
commit;
update RENCONTRES set SCORE_EQUIPE_ACCUEILLANTE = 36 where NUMERO_DE_RENCONTRE = 1;
commit;