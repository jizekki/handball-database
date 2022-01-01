# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Clubs(models.Model):
    # Field name made lowercase.
    numero_club = models.IntegerField(
        db_column='NUMERO_CLUB', primary_key=True)
    # Field name made lowercase.
    nom_club = models.CharField(db_column='NOM_CLUB', max_length=20)

    class Meta:
        managed = False
        db_table = 'CLUBS'


class CommencerAEntrainer(models.Model):
    # Field name made lowercase.
    numero_entraineur = models.OneToOneField(
        'Entraineurs', models.DO_NOTHING, db_column='NUMERO_ENTRAINEUR', primary_key=True)
    # Field name made lowercase.
    date_entree = models.ForeignKey(
        'DatesEntree', models.DO_NOTHING, db_column='DATE_ENTREE')
    # Field name made lowercase.
    numero_equipe = models.ForeignKey(
        'Equipes', models.DO_NOTHING, db_column='NUMERO_EQUIPE')

    class Meta:
        managed = False
        db_table = 'COMMENCER_A_ENTRAINER'
        unique_together = (
            ('numero_entraineur', 'date_entree', 'numero_equipe'),)


class CommencerAJouer(models.Model):
    # Field name made lowercase.
    numero_de_licence = models.OneToOneField(
        'Joueurs', models.DO_NOTHING, db_column='NUMERO_DE_LICENCE', primary_key=True)
    # Field name made lowercase.
    date_entree = models.ForeignKey(
        'DatesEntree', models.DO_NOTHING, db_column='DATE_ENTREE')
    # Field name made lowercase.
    numero_equipe = models.ForeignKey(
        'Equipes', models.DO_NOTHING, db_column='NUMERO_EQUIPE')

    class Meta:
        managed = False
        db_table = 'COMMENCER_A_JOUER'
        unique_together = (
            ('numero_de_licence', 'date_entree', 'numero_equipe'),)


class DatesEntree(models.Model):
    # Field name made lowercase.
    date_entree = models.DateField(db_column='DATE_ENTREE', primary_key=True)

    class Meta:
        managed = False
        db_table = 'DATES_ENTREE'


class Entraineurs(models.Model):
    # Field name made lowercase.
    numero_entraineur = models.IntegerField(
        db_column='NUMERO_ENTRAINEUR', primary_key=True)
    # Field name made lowercase.
    nom_entraineur = models.CharField(
        db_column='NOM_ENTRAINEUR', max_length=20)
    # Field name made lowercase.
    prenom_entraineur = models.CharField(
        db_column='PRENOM_ENTRAINEUR', max_length=20)
    # Field name made lowercase.
    email_entraineur = models.CharField(
        db_column='EMAIL_ENTRAINEUR', max_length=50)
    # Field name made lowercase.
    telephone_entraineur = models.IntegerField(
        db_column='TELEPHONE_ENTRAINEUR')

    class Meta:
        managed = False
        db_table = 'ENTRAINEURS'


class Equipes(models.Model):
    # Field name made lowercase.
    numero_equipe = models.IntegerField(
        db_column='NUMERO_EQUIPE', primary_key=True)
    # Field name made lowercase.
    nom_equipe = models.CharField(db_column='NOM_EQUIPE', max_length=30)
    # Field name made lowercase.
    categorie = models.CharField(db_column='CATEGORIE', max_length=20)
    # Field name made lowercase.
    ordre_dans_categorie = models.IntegerField(
        db_column='ORDRE_DANS_CATEGORIE', blank=True, null=True)
    # Field name made lowercase.
    numero_club = models.ForeignKey(
        Clubs, models.DO_NOTHING, db_column='NUMERO_CLUB')

    class Meta:
        managed = False
        db_table = 'EQUIPES'


class Joueurs(models.Model):
    # Field name made lowercase.
    numero_de_licence = models.IntegerField(
        db_column='NUMERO_DE_LICENCE', primary_key=True)
    # Field name made lowercase.
    nom_joueur = models.CharField(db_column='NOM_JOUEUR', max_length=40)
    # Field name made lowercase.
    prenom_joueur = models.CharField(db_column='PRENOM_JOUEUR', max_length=40)
    # Field name made lowercase.
    date_naissance = models.DateField(db_column='DATE_NAISSANCE')
    # Field name made lowercase.
    email_joueur = models.CharField(db_column='EMAIL_JOUEUR', max_length=50)
    # Field name made lowercase.
    telephone_joueur = models.CharField(
        db_column='TELEPHONE_JOUEUR', max_length=10)

    class Meta:
        managed = False
        db_table = 'JOUEURS'


class Participer(models.Model):
    # Field name made lowercase.
    numero_de_rencontre = models.OneToOneField(
        'Rencontres', models.DO_NOTHING, db_column='NUMERO_DE_RENCONTRE', primary_key=True)
    # Field name made lowercase.
    numero_de_licence = models.ForeignKey(
        Joueurs, models.DO_NOTHING, db_column='NUMERO_DE_LICENCE')
    # Field name made lowercase.
    nombre_points_marques = models.IntegerField(
        db_column='NOMBRE_POINTS_MARQUES')
    # Field name made lowercase.
    nombre_fautes_commises = models.IntegerField(
        db_column='NOMBRE_FAUTES_COMMISES')

    class Meta:
        managed = False
        db_table = 'PARTICIPER'
        unique_together = (('numero_de_rencontre', 'numero_de_licence'),)


class Rencontres(models.Model):
    # Field name made lowercase.
    numero_de_rencontre = models.IntegerField(
        db_column='NUMERO_DE_RENCONTRE', primary_key=True)
    # Field name made lowercase.
    date_de_rencontre = models.DateField(db_column='DATE_DE_RENCONTRE')
    # Field name made lowercase.
    score_equipe_accueillante = models.IntegerField(
        db_column='SCORE_EQUIPE_ACCUEILLANTE')
    # Field name made lowercase.
    score_equipe_recue = models.IntegerField(db_column='SCORE_EQUIPE_RECUE')
    # Field name made lowercase.
    numero_equipe_accueillante = models.ForeignKey(
        Equipes, models.DO_NOTHING, db_column='NUMERO_EQUIPE_ACCUEILLANTE', related_name="numero_equipe_accueillante")
    # Field name made lowercase.
    numero_equipe_recue = models.ForeignKey(
        Equipes, models.DO_NOTHING, db_column='NUMERO_EQUIPE_RECUE', related_name="numero_equipe_recue")

    class Meta:
        managed = False
        db_table = 'RENCONTRES'


class Responsables(models.Model):
    # Field name made lowercase.
    numero_responsable = models.IntegerField(
        db_column='NUMERO_RESPONSABLE', primary_key=True)
    # Field name made lowercase.
    nom_responsable = models.CharField(
        db_column='NOM_RESPONSABLE', max_length=20)
    # Field name made lowercase.
    prenom_responsable = models.CharField(
        db_column='PRENOM_RESPONSABLE', max_length=20)
    # Field name made lowercase.
    poste = models.CharField(
        db_column='POSTE', max_length=40, blank=True, null=True)
    # Field name made lowercase.
    email_responsable = models.CharField(
        db_column='EMAIL_RESPONSABLE', max_length=50)
    # Field name made lowercase.
    telephone_responsable = models.IntegerField(
        db_column='TELEPHONE_RESPONSABLE')
    # Field name made lowercase.
    numero_club = models.ForeignKey(
        Clubs, models.DO_NOTHING, db_column='NUMERO_CLUB')

    class Meta:
        managed = False
        db_table = 'RESPONSABLES'


class Saisons(models.Model):
    # Field name made lowercase.
    numero_saison = models.IntegerField(
        db_column='NUMERO_SAISON', primary_key=True)
    # Field name made lowercase.
    date_de_debut = models.DateField(db_column='DATE_DE_DEBUT')

    class Meta:
        managed = False
        db_table = 'SAISONS'


class SaisonsJouees(models.Model):
    # Field name made lowercase.
    numero_saison = models.OneToOneField(
        Saisons, models.DO_NOTHING, db_column='NUMERO_SAISON', primary_key=True)
    # Field name made lowercase.
    numero_de_licence = models.ForeignKey(
        Joueurs, models.DO_NOTHING, db_column='NUMERO_DE_LICENCE')

    class Meta:
        managed = False
        db_table = 'SAISONS_JOUEES'
        unique_together = (('numero_saison', 'numero_de_licence'),)
