-- ============================================================
--   Requetes de consultation
-- ============================================================

-- selectionner tous les clubs de la base de donnees
select * from CLUBS;

-- selectionner toutes les equipes de la base de donnees
select * from EQUIPES;

-- selectionner tous les joueurs de la base de donnees
select * from JOUEURS;


select R.DATE_DE_RENCONTRE,E1.NOM_EQUIPE as EQUIPE_ACCUEILLANTE,R.SCORE_EQUIPE_ACCUEILLANTE,E2.NOM_EQUIPE as EQUIPE_RECUS,R.SCORE_EQUIPE_RECUE
    from RENCONTRES R, EQUIPES E1, EQUIPES E2
    where E1.NUMERO_EQUIPE  = R.NUMERO_EQUIPE_ACCUEILLANTE and E2.NUMERO_EQUIPE  = R.NUMERO_EQUIPE_RECUE; 

-- Liste des joueurs par rencontre
select R.DATE_DE_RENCONTRE, J.NOM_JOUEUR as NOM, J.PRENOM_JOUEUR as PRENOM
    from JOUEURS J, PARTICIPER P,RENCONTRES R 
    where R.NUMERO_DE_RENCONTRE = P.NUMERO_DE_RENCONTRE and P.NUMERO_DE_LICENCE = J.NUMERO_DE_LICENCE;
    

-- Vue contenant la feuille des rencontres : (fautes et points marqué de chaque joueurs de l'équipe accueillante) 
create view T1 (NUMERO_DE_RENCONTRE,DATE_DE_RENCONTRE,EQUIPE_ACCUEILLANTE,NOM,PRENOM,BUTS,FAUTES,SCORE)
as select  R.NUMERO_DE_RENCONTRE,
        R.DATE_DE_RENCONTRE,
        E.NOM_EQUIPE,
        J.NOM_JOUEUR,
        J.PRENOM_JOUEUR,
        P.NOMBRE_POINTS_MARQUES,
        P.NOMBRE_FAUTES_COMMISES,
        R.SCORE_EQUIPE_ACCUEILLANTE
        
        from RENCONTRES R, EQUIPES E, PARTICIPER P, JOUEURS J
        where R.NUMERO_EQUIPE_ACCUEILLANTE = E.NUMERO_EQUIPE
            and R.NUMERO_DE_RENCONTRE = P.NUMERO_DE_RENCONTRE
            and P.NUMERO_DE_LICENCE = J.NUMERO_DE_LICENCE
        ;
        

-- Vue contenant la feuille des rencontres : (fautes et points marqué de chaque joueurs de l'équipe reçue)
create view T2 (NUMERO_DE_RENCONTRE,DATE_DE_RENCONTRE,EQUIPE_RECUS,NOM,PRENOM,BUTS,FAUTES,SCORE)
as select  R.NUMERO_DE_RENCONTRE,
        R.DATE_DE_RENCONTRE,
        E.NOM_EQUIPE,
        J.NOM_JOUEUR,
        J.PRENOM_JOUEUR,
        P.NOMBRE_POINTS_MARQUES,
        P.NOMBRE_FAUTES_COMMISES,
        R.SCORE_EQUIPE_RECUE
        
        from RENCONTRES R, EQUIPES E, PARTICIPER P, JOUEURS J
        where R.NUMERO_EQUIPE_RECUE = E.NUMERO_EQUIPE
            and R.NUMERO_DE_RENCONTRE = P.NUMERO_DE_RENCONTRE
            and P.NUMERO_DE_LICENCE = J.NUMERO_DE_LICENCE
        ;

-- Tous les points marqués et fautes des joueurs dans toutes les rencontres. (utilisé dans l'interface dans les statistiques)  
select T1.NUMERO_DE_RENCONTRE,
    T1.DATE_DE_RENCONTRE,
    T1.EQUIPE_ACCUEILLANTE,
    T1.NOM,
    T1.PRENOM,
    T1.BUTS,
    T1.FAUTES,
    T1.SCORE,
    T2.EQUIPE_RECUS,
    T2.NOM,
    T2.PRENOM,
    T2.BUTS,
    T2.FAUTES,
    T2.SCORE
    from T1 inner join T2 using (NUMERO_DE_RENCONTRE) order by NUMERO_DE_RENCONTRE;


-- Nombre des matchs gagnés par equipe
select E.NUMERO_EQUIPE , E.NOM_EQUIPE, count(*) as MATCHS_GAGNE 
    from EQUIPES E, RENCONTRES R 
    where (E.NUMERO_EQUIPE = R.NUMERO_EQUIPE_ACCUEILLANTE and R.SCORE_EQUIPE_ACCUEILLANTE > R.SCORE_EQUIPE_RECUE) 
        or (E.NUMERO_EQUIPE = R.NUMERO_EQUIPE_RECUE and R.SCORE_EQUIPE_RECUE > R.SCORE_EQUIPE_ACCUEILLANTE)
        group by 1,2; 




-- Nombre des matchs perdus par equipe
select E.NUMERO_EQUIPE , E.NOM_EQUIPE, count(*) as MATCHS_PERDUES 
    from EQUIPES E, RENCONTRES R 
    where (E.NUMERO_EQUIPE = R.NUMERO_EQUIPE_ACCUEILLANTE and R.SCORE_EQUIPE_ACCUEILLANTE < R.SCORE_EQUIPE_RECUE) 
        or (E.NUMERO_EQUIPE = R.NUMERO_EQUIPE_RECUE and R.SCORE_EQUIPE_RECUE < R.SCORE_EQUIPE_ACCUEILLANTE)
        group by 1;

-- Nombre des matchs nuls par equipe
select E.NUMERO_EQUIPE , E.NOM_EQUIPE, count(*) as MATCHS_NULS 
    from EQUIPES E, RENCONTRES R 
    where (E.NUMERO_EQUIPE = R.NUMERO_EQUIPE_ACCUEILLANTE and R.SCORE_EQUIPE_ACCUEILLANTE = R.SCORE_EQUIPE_RECUE)
    group by 1;

-- Nombre des matchs gagnés par club
select C.NUMERO_CLUB , C.NOM_CLUB, count(*) as MATCHS_GAGNE 
    from CLUBS C, EQUIPES E, RENCONTRES R 
    where E.NUMERO_CLUB = C.NUMERO_CLUB
        and ( (E.NUMERO_EQUIPE = R.NUMERO_EQUIPE_ACCUEILLANTE and R.SCORE_EQUIPE_ACCUEILLANTE > R.SCORE_EQUIPE_RECUE) 
        or (E.NUMERO_EQUIPE = R.NUMERO_EQUIPE_RECUE and R.SCORE_EQUIPE_RECUE > R.SCORE_EQUIPE_ACCUEILLANTE))
        group by 1; 


-- Nombre des matchs perdus par club
select C.NUMERO_CLUB , C.NOM_CLUB, count(*) as MATCHS_PERDUES 
    from CLUBS C, EQUIPES E, RENCONTRES R 
    where E.NUMERO_CLUB = C.NUMERO_CLUB
        and ( (E.NUMERO_EQUIPE = R.NUMERO_EQUIPE_ACCUEILLANTE and R.SCORE_EQUIPE_ACCUEILLANTE < R.SCORE_EQUIPE_RECUE) 
        or (E.NUMERO_EQUIPE = R.NUMERO_EQUIPE_RECUE and R.SCORE_EQUIPE_RECUE < R.SCORE_EQUIPE_ACCUEILLANTE) )
        group by 1; 



-- Nombre des matchs nuls par club
select C.NUMERO_CLUB , C.NOM_CLUB, count(*) as MATCHS_NULS 
    from CLUBS C, EQUIPES E, RENCONTRES R 
    where E.NUMERO_CLUB = C.NUMERO_CLUB
        and ( (E.NUMERO_EQUIPE = R.NUMERO_EQUIPE_ACCUEILLANTE and R.SCORE_EQUIPE_ACCUEILLANTE = R.SCORE_EQUIPE_RECUE) )
        group by 1; 
