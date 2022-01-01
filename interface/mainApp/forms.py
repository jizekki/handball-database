from django import forms
from django.forms import fields
from .models import Clubs, Entraineurs, Equipes, Participer, Rencontres, Responsables, Joueurs


class AjouterJoueur(forms.Form):
    class Meta:
        model = Joueurs
        fields = ['nom_joueur', 'prenom_joueur',
                  'date_naissance', 'email_joueur', 'telephone_joueur']


class AjouterClub(forms.Form):
    class Meta:
        model = Clubs
        fields = ['nom_club']


class AjouterResponsable(forms.Form):
    class Meta:
        model = Responsables
        fields = ['nom_responsable', 'prenom_responsable',
                  'poste', 'email_responsable', 'telephone_responsable', 'num_club']


class AjouterEntraineur(forms.Form):
    class Meta:
        model = Entraineurs
        fields = ['nom_entraineurs', 'prenom_entraineurs',
                  'email_entraineurs', 'telephone_entraineurs']


class AjouterEquipe(forms.Form):
    class Meta:
        model = Equipes
        fields = ['nom_equipe', 'categorie',
                  'ordre_dans_categorie', 'numero_club']


class AjouterRencontre(forms.Form):
    class Meta:
        model = Rencontres
        fields = ['date_de_rencontre', 'score_equipe_accueillante',
                  'score_equipe_recue', 'numero_equipe_accueillante',
                  'numero_equipe_recue']


class AjouterParticiper(forms.Form):
    class Meta:
        model = Participer
        fields = ['numero_de_rencontre', 'numero_de_licence',
                  'nombre_points_marques', 'nombre_fautes_commises']


class Statistics(forms.Form):
    class Meta:
        fields = ['date']


class Statistics2(forms.Form):
    class Meta:
        fields = ['saison']
