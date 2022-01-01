# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from mainApp.models import Clubs, Entraineurs, Equipes, Participer, Rencontres, Responsables, Joueurs, Saisons
from mainApp.forms import *
from django.db import connections
from django.http import Http404
from django.shortcuts import render
from django.db import connection
from django.contrib import messages
from django.http import HttpResponseNotFound


def home(request):
    return render(request, 'html/home.html')


def baseModify(request):
    return render(request, 'html/baseModify.html')


def rencontres(request):
    query = 'select * from RENCONTRES'
    context = {
        'rencontres': Rencontres.objects.raw(query)
    }
    return render(request, 'html/rencontres.html', context)


def clubs(request):
    query = 'select * from CLUBS'
    context = {
        'clubs': Clubs.objects.raw(query)
    }
    return render(request, 'html/clubs.html', context)


def joueurs(request):
    query = 'select * from JOUEURS'
    context = {
        'joueurs': Joueurs.objects.raw(query)
    }
    return render(request, 'html/joueurs.html', context)


def rencontre_details(request, numero_de_rencontre):
    query1 = 'select * from RENCONTRES where NUMERO_DE_RENCONTRE={}'.format(
        numero_de_rencontre)
    query2 = 'select * from PARTICIPER left outer join RENCONTRES on PARTICIPER.NUMERO_DE_RENCONTRE=RENCONTRES.NUMERO_DE_RENCONTRE where RENCONTRES.NUMERO_DE_RENCONTRE={}'.format(
        numero_de_rencontre)
    context = {
        'rencontre': Rencontres.objects.raw(query1)[0],
        'joueurs_accueillants': Participer.objects.raw(query2)[:int(len(Joueurs.objects.raw(query2))/2)],
        'joueurs_recus': Participer.objects.raw(query2)[int(len(Joueurs.objects.raw(query2))/2):],
    }
    return render(request, 'html/rencontre_details.html', context)


def club_details(request, numero_club):
    assert type(numero_club) == int

    query1 = 'select * from CLUBS where NUMERO_CLUB={}'.format(numero_club)
    query2 = 'select * from RESPONSABLES where NUMERO_CLUB={}'.format(
        numero_club)
    query3 = 'select * from EQUIPES where NUMERO_CLUB={}'.format(numero_club)

    context = {
        'club': Clubs.objects.raw(query1)[0],
        'responsables': Responsables.objects.raw(query2),
        'equipes': Equipes.objects.raw(query3)
    }
    print(context['club'])
    return render(request, 'html/club_details.html', context)


def equipe_details(request, numero_equipe):
    assert type(numero_equipe) == int

    query1 = 'select * from EQUIPES where NUMERO_EQUIPE={}'.format(
        numero_equipe)

    query2 = 'select RENCONTRES.* from RENCONTRES left outer join EQUIPES on RENCONTRES.NUMERO_EQUIPE_RECUE=EQUIPES.NUMERO_EQUIPE where EQUIPES.NUMERO_EQUIPE={} union select RENCONTRES.* from RENCONTRES left outer join EQUIPES on RENCONTRES.NUMERO_EQUIPE_ACCUEILLANTE=EQUIPES.NUMERO_EQUIPE where EQUIPES.NUMERO_EQUIPE={}'.format(
        numero_equipe, numero_equipe)

    query3 = 'select ENTRAINEURS.* from ENTRAINEURS left outer join COMMENCER_A_ENTRAINER on ENTRAINEURS.NUMERO_ENTRAINEUR=COMMENCER_A_ENTRAINER.NUMERO_ENTRAINEUR left outer join EQUIPES on COMMENCER_A_ENTRAINER.NUMERO_EQUIPE=EQUIPES.NUMERO_EQUIPE where EQUIPES.NUMERO_EQUIPE={}'.format(
        numero_equipe)

    query4 = 'select JOUEURS.* from JOUEURS left outer join COMMENCER_A_JOUER on JOUEURS.NUMERO_DE_LICENCE=COMMENCER_A_JOUER.NUMERO_DE_LICENCE left outer join EQUIPES on COMMENCER_A_JOUER.NUMERO_EQUIPE=EQUIPES.NUMERO_EQUIPE where EQUIPES.NUMERO_EQUIPE={}'.format(
        numero_equipe)

    context = {
        'equipe': Equipes.objects.raw(query1)[0],
        'rencontres': Rencontres.objects.raw(query2),
        'entraineurs': Entraineurs.objects.raw(query3),
        'joueurs': Joueurs.objects.raw(query4),
    }
    return render(request, 'html/equipe_details.html', context)


def joueur_details(request, numero_de_licence):
    query1 = 'select * from JOUEURS where NUMERO_DE_LICENCE={}'.format(
        numero_de_licence)

    query3 = 'select * from EQUIPES left outer join COMMENCER_A_JOUER on EQUIPES.NUMERO_EQUIPE=COMMENCER_A_JOUER.NUMERO_EQUIPE left outer join JOUEURS on JOUEURS.NUMERO_DE_LICENCE=COMMENCER_A_JOUER.NUMERO_DE_LICENCE where JOUEURS.NUMERO_DE_LICENCE={}'.format(
        numero_de_licence)
    with connection.cursor() as cursor:
        cursor.execute('select sum(NOMBRE_POINTS_MARQUES) from (select NOMBRE_POINTS_MARQUES from PARTICIPER where NUMERO_DE_LICENCE={}) as t'.format(
            numero_de_licence))
        query4 = cursor.fetchall()
        cursor.execute('select sum(NOMBRE_FAUTES_COMMISES) from (select NOMBRE_FAUTES_COMMISES from PARTICIPER where NUMERO_DE_LICENCE={}) as t'.format(
            numero_de_licence))
        query5 = cursor.fetchall()
    context = {
        'joueur': Joueurs.objects.raw(query1)[0],
        'points_marques': query4[0][0],
        'fautes_commises': query5[0][0],
    }
    if(len(Equipes.objects.raw(query3))):
        context['equipe_du_joueur'] = Equipes.objects.raw(query3)[-1]
    if(query4[0][0]):
        context['points_marques'] = query4[0][0]
    else:
        context['points_marques'] = 0
    if(query5[0][0]):
        context['fautes_commises'] = query5[0][0]
    else:
        context['fautes_commises'] = 0
    return render(request, 'html/joueur_details.html', context)


######################################## Creation et ajout de donnees a la base ########################################
def creer_joueur(request):
    context = {
    }
    return render(request, 'html/creer_joueur.html', context)


def creer_joueur_submit(request):
    if request.method == 'POST':
        form = AjouterJoueur(request.POST)
        if form.is_valid():
            prenom_joueur = request.POST.get('firstName')
            nom_joueur = request.POST.get('lastName')
            date_naissance = request.POST.get('birthdate')
            email_joueur = request.POST.get('email')
            telephone_joueur = request.POST.get('phoneNumber')
            query = "insert into JOUEURS (NOM_JOUEUR, PRENOM_JOUEUR, DATE_NAISSANCE, EMAIL_JOUEUR, TELEPHONE_JOUEUR) values ('{}','{}','{}','{}','{}')".format(
                nom_joueur, prenom_joueur, date_naissance, email_joueur, telephone_joueur)
            cursor = connections['default'].cursor()
            cursor.execute(query)
            return render(request, 'html/home.html')
        else:
            raise Http404

# -------------------------------------


def creer_club(request):
    context = {
    }
    return render(request, 'html/creer_club.html', context)


def creer_club_submit(request):
    if request.method == 'POST':
        form = AjouterClub(request.POST)
        if form.is_valid():
            club_name = request.POST.get('clubName')
            query = "insert into CLUBS (NOM_CLUB) values ('{}')".format(
                club_name)
            cursor = connections['default'].cursor()
            cursor.execute(query)
            return render(request, 'html/home.html')
        else:
            raise Http404

# -------------------------------------


def creer_responsable(request):
    context = {
    }
    return render(request, 'html/creer_responsable.html', context)


def creer_responsable_submit(request):
    if request.method == 'POST':
        form = AjouterResponsable(request.POST)
        if form.is_valid():
            prenom_responsable = request.POST.get('firstName')
            nom_responsable = request.POST.get('lastName')
            poste = request.POST.get('poste')
            email_responsable = request.POST.get('email')
            telephone_responsable = request.POST.get('phoneNumber')
            numero_club = request.POST.get('numClub')
            query = "insert into RESPONSABLES (NOM_RESPONSABLE, PRENOM_RESPONSABLE, POSTE, EMAIL_RESPONSABLE, TELEPHONE_RESPONSABLE, NUMERO_CLUB) values ('{}','{}','{}','{}','{}', {})".format(
                prenom_responsable, nom_responsable, poste, email_responsable, telephone_responsable, numero_club)
            cursor = connections['default'].cursor()
            cursor.execute(query)
            return render(request, 'html/home.html')
        else:
            raise Http404

# -------------------------------------


def creer_entraineur(request):
    context = {
    }
    return render(request, 'html/creer_entraineur.html', context)


def creer_entraineur_submit(request):
    if request.method == 'POST':
        form = AjouterEntraineur(request.POST)
        if form.is_valid():
            prenom_entraineur = request.POST.get('firstName')
            nom_entraineur = request.POST.get('lastName')
            email_entraineur = request.POST.get('email')
            telephone_entraineur = request.POST.get('phoneNumber')
            query = "insert into  ENTRAINEURS (NOM_ENTRAINEUR, PRENOM_ENTRAINEUR, EMAIL_ENTRAINEUR, TELEPHONE_ENTRAINEUR) values ('{}','{}','{}','{}')".format(
                nom_entraineur, prenom_entraineur, email_entraineur, telephone_entraineur)
            cursor = connections['default'].cursor()
            cursor.execute(query)
            return render(request, 'html/home.html')
        else:
            raise Http404

# -------------------------------------


def creer_equipe(request):
    context = {
    }
    return render(request, 'html/creer_equipe.html', context)


def creer_equipe_submit(request):
    if request.method == 'POST':
        form = AjouterEquipe(request.POST)
        if form.is_valid():
            nom_equipe = request.POST.get('nomEquipe')
            categorie = request.POST.get('categorie')
            ordre = request.POST.get('ordre')
            numero_club = request.POST.get('numClub')
            query = "insert into EQUIPES (NOM_EQUIPE, CATEGORIE, ORDRE_DANS_CATEGORIE, NUMERO_CLUB) values ('{}','{}',{}, {})".format(
                nom_equipe, categorie, ordre, numero_club)
            cursor = connections['default'].cursor()
            cursor.execute(query)
            return render(request, 'html/home.html')
        else:
            raise Http404

# -------------------------------------


def creer_rencontre(request):
    context = {
    }
    return render(request, 'html/creer_rencontre.html', context)


def creer_rencontre_submit(request):
    if request.method == 'POST':
        form = AjouterRencontre(request.POST)
        if form.is_valid():
            date_rencontre = request.POST.get('dateRencontre')
            score_equipe_accueillante = request.POST.get(
                'score_equipe_accueillante')
            score_equipe_recue = request.POST.get(
                'score_equipe_recue')
            numero_equipe_accueillante = request.POST.get(
                'numero_equipe_accueillante')
            numero_equipe_recue = request.POST.get(
                'numero_equipe_recue')
            query = "insert into RENCONTRES (DATE_DE_RENCONTRE, SCORE_EQUIPE_ACCUEILLANTE, SCORE_EQUIPE_RECUE, NUMERO_EQUIPE_ACCUEILLANTE, NUMERO_EQUIPE_RECUE) values ('{}',{},{},{}, {})".format(
                date_rencontre, score_equipe_accueillante, score_equipe_recue, numero_equipe_accueillante, numero_equipe_recue)
            cursor = connections['default'].cursor()
            cursor.execute(query)
            return render(request, 'html/home.html')
        else:
            raise Http404

# -------------------------------------


def creer_participer(request):
    context = {
    }
    return render(request, 'html/creer_participer.html', context)


def creer_participer_submit(request):
    if request.method == 'POST':
        form = AjouterParticiper(request.POST)
        if form.is_valid():
            numRencontre = request.POST.get('numRencontre')
            numLicence = request.POST.get('numLicence')
            points_marques = request.POST.get('points_marques')
            fautes = request.POST.get('fautes')
            query = "insert into PARTICIPER values ({},{},{}, {})".format(
                numRencontre, numLicence, points_marques, fautes)
            cursor = connections['default'].cursor()
            cursor.execute(query)
            return render(request, 'html/home.html')
        else:
            raise Http404


######################################## Suppression d'objets ########################################

def supprimer_joueur(request, id):
    with connection.cursor() as cursor:
        query1 = "delete from JOUEURS where NUMERO_DE_LICENCE='{}'".format(id)
        cursor.execute(query1)
    messages.success(request, "L'élément a bien été supprimé !")
    return render(request, 'html/home.html')


def supprimer_club(request, id):
    with connection.cursor() as cursor:
        query1 = "delete from CLUBS where NUMERO_CLUB='{}'".format(id)
        cursor.execute(query1)
    messages.success(request, "L'élément a bien été supprimé !")
    return render(request, 'html/home.html')


def supprimer_responsable(request, id):
    with connection.cursor() as cursor:
        query1 = "delete from RESPONSABLES where NUMERO_RESPONSABLE='{}'".format(
            id)
        cursor.execute(query1)
    messages.success(request, "L'élément a bien été supprimé !")
    return render(request, 'html/home.html')


def supprimer_entraineur(request, id):
    with connection.cursor() as cursor:
        query1 = "delete from ENTRAINEURS where NUMERO_ENTRAINEUR='{}'".format(
            id)
        cursor.execute(query1)
    messages.success(request, "L'élément a bien été supprimé !")
    return render(request, 'html/home.html')


def supprimer_equipe(request, id):
    with connection.cursor() as cursor:
        query1 = "delete from EQUIPES where NUMERO_EQUIPE='{}'".format(id)
        cursor.execute(query1)
    messages.success(request, "L'élément a bien été supprimé !")
    return render(request, 'html/home.html')


def supprimer_rencontre(request, id):
    with connection.cursor() as cursor:
        query1 = "delete from RENCONTRES where NUMERO_DE_RENCONTRE='{}'".format(
            id)
        cursor.execute(query1)
    messages.success(request, "L'élément a bien été supprimé !")
    return render(request, 'html/home.html')


######################################## Statistiques ########################################


def statistics(request):
    return render(request, 'html/statistics.html')


def statistics_results(request):
    if request.method == 'POST':
        form = Statistics(request.POST)
        if form.is_valid():
            context = {}
            date = request.POST.get('date')
            context['date'] = date
            with connection.cursor() as cursor:
                query1 = "select * from (select DATE_DE_RENCONTRE, AVG( R.SCORE_EQUIPE_ACCUEILLANTE + R.SCORE_EQUIPE_RECUE) as MOYENNE_POINTS from RENCONTRES R group by 1) as T where DATE_DE_RENCONTRE='{}'".format(date)
                query2 = "select * from (select R.DATE_DE_RENCONTRE, R.NUMERO_DE_RENCONTRE,J.NOM_JOUEUR,J.PRENOM_JOUEUR,P.NOMBRE_POINTS_MARQUES,P.NOMBRE_FAUTES_COMMISES from RENCONTRES R, PARTICIPER P, JOUEURS J where R.NUMERO_DE_RENCONTRE = P.NUMERO_DE_RENCONTRE and P.NUMERO_DE_LICENCE = J.NUMERO_DE_LICENCE order by 5 DESC,6 ASC) as T where DATE_DE_RENCONTRE='{}'".format(date)
                cursor.execute(query1)
                query_result1 = cursor.fetchall()
                cursor.execute(query2)
                query_result2 = cursor.fetchall()
                if(query_result1):
                    context['moyenne'] = query_result1[0][1]
                else:
                    context['moyenne'] = 0
                context['joueurs'] = query_result2
            return render(request, 'html/statistics_results.html', context)
    else:
        raise Http404


def statistics_results2(request):
    if request.method == 'POST':
        form = Statistics2(request.POST)
        if form.is_valid():
            context = {}
            saison = int(request.POST.get('saison'))
            context['saison'] = saison
            if (saison < Saisons.objects.count()):
                with connection.cursor() as cursor:
                    query1 = """select * from (select S.NUMERO_SAISON, S.DATE_DE_DEBUT as DEBUT_DE_SAISON , AVG( (R.SCORE_EQUIPE_ACCUEILLANTE + R.SCORE_EQUIPE_RECUE)/2 )
                                from RENCONTRES R, PARTICIPER P, JOUEURS J, SAISONS_JOUEES SJ, SAISONS S
                                where R.NUMERO_DE_RENCONTRE = P.NUMERO_DE_RENCONTRE
                                    and P.NUMERO_DE_LICENCE = J.NUMERO_DE_LICENCE
                                    and J.NUMERO_DE_LICENCE = SJ.NUMERO_DE_LICENCE
                                    and SJ.NUMERO_SAISON = S.NUMERO_SAISON
                                and R.DATE_DE_RENCONTRE > S.DATE_DE_DEBUT
                                group by 1, 2) as T where NUMERO_SAISON='{}'""".format(saison)
                    query2 = """create or replace view TAB (SAISON,NUM_EQUIPE,RENCONTRE,DATE,W,L,N)
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
                                    group by 1,2,3,4"""

                    query3 = "select TAB.NUM_EQUIPE,E.NOM_EQUIPE,SUM(TAB.W) as W,SUM(TAB.L) as L,SUM(TAB.N) as N  from TAB , EQUIPES E where E.NUMERO_EQUIPE = TAB.NUM_EQUIPE and TAB.SAISON = {} group by 1,2  order by 3 DESC, 4 ASC ,5 DESC".format(
                        saison)
                    cursor.execute(query1)
                    query_result1 = cursor.fetchall()
                    cursor.execute(query2)
                    cursor.execute(query3)
                    query_result2 = cursor.fetchall()
                    if(query_result1):
                        context['moyenne'] = query_result1[0][2]
                    else:
                        context['moyenne'] = 0
                    context['equipes'] = query_result2
                return render(request, 'html/statistics_results2.html', context)
            else:
                return HttpResponseNotFound("Numero de saison non valide")
    else:
        return HttpResponseNotFound("Numero de saison non valide")
