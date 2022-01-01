from django.contrib.staticfiles.urls import staticfiles_urlpatterns
from django.contrib import admin
from django.urls import path
from mainApp import views as mainApp

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', mainApp.home, name='home'),
    path('baseModify', mainApp.baseModify, name='baseModify'),
    path('rencontres', mainApp.rencontres, name='rencontres'),
    path('clubs', mainApp.clubs, name='clubs'),
    path('joueurs', mainApp.joueurs, name='joueurs'),


    path('rencontre_details', mainApp.rencontre_details, name='rencontre_details'),
    path('club_details/<int:numero_club>/', mainApp.club_details,
         name='club_details'),
    path('equipe_details/<int:numero_equipe>/', mainApp.equipe_details,
         name='equipe_details'),
    path('joueur_details/<int:numero_de_licence>/', mainApp.joueur_details,
         name='joueur_details'),
    path('rencontre_details/<int:numero_de_rencontre>/', mainApp.rencontre_details,
         name='rencontre_details'),


    path('creer_joueur', mainApp.creer_joueur, name="creer_joueur"),
    path('creer_joueur_submit', mainApp.creer_joueur_submit,
         name="creer_joueur_submit"),
    path('creer_club', mainApp.creer_club, name="creer_club"),
    path('creer_club_submit', mainApp.creer_club_submit,
         name="creer_club_submit"),
    path('creer_responsable', mainApp.creer_responsable, name="creer_responsable"),
    path('creer_responsable_submit', mainApp.creer_responsable_submit,
         name="creer_responsable_submit"),
    path('creer_entraineur', mainApp.creer_entraineur, name="creer_entraineur"),
    path('creer_entraineur_submit', mainApp.creer_entraineur_submit,
         name="creer_entraineur_submit"),
    path('creer_equipe', mainApp.creer_equipe, name="creer_equipe"),
    path('creer_equipe_submit', mainApp.creer_equipe_submit,
         name="creer_equipe_submit"),
    path('creer_rencontre', mainApp.creer_rencontre, name="creer_rencontre"),
    path('creer_rencontre_submit', mainApp.creer_rencontre_submit,
         name="creer_rencontre_submit"),
    path('creer_participer', mainApp.creer_participer, name="creer_participer"),
    path('creer_participer_submit', mainApp.creer_participer_submit,
         name="creer_participer_submit"),

    path('supprimer_joueur/<int:id>',
         mainApp.supprimer_joueur, name="supprimer_joueur"),
    path('supprimer_club/<int:id>', mainApp.supprimer_club, name="supprimer_club"),
    path('supprimer_responsable/<int:id>', mainApp.supprimer_responsable,
         name="supprimer_responsable"),
    path('supprimer_entraineur/<int:id>', mainApp.supprimer_entraineur,
         name="supprimer_entraineur"),
    path('supprimer_equipe/<int:id>',
         mainApp.supprimer_equipe, name="supprimer_equipe"),
    path('supprimer_rencontre/<int:id>', mainApp.supprimer_rencontre,
         name="supprimer_rencontre"),

    path('statistics', mainApp.statistics, name='statistics'),
    path('statistics_results', mainApp.statistics_results,
         name='statistics_results'),
    path('statistics_results2', mainApp.statistics_results2,
         name='statistics_results2'),
]


urlpatterns += staticfiles_urlpatterns()
