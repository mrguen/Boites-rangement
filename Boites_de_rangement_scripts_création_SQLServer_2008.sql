/*==============================================================*/
/* Nom de SGBD :  Microsoft SQL Server 2008                     */
/* Date de création :  20/02/2025 16:22:17                      */
/*==============================================================*/


if exists (select 1
            from  sysobjects
           where  id = object_id('BOITE')
            and   type = 'U')
   drop table BOITE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CLIENT')
            and   type = 'U')
   drop table CLIENT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('COMMANDE')
            and   type = 'U')
   drop table COMMANDE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('COULEUR')
            and   type = 'U')
   drop table COULEUR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('MATIERE')
            and   type = 'U')
   drop table MATIERE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('MATIERE_COULEUR')
            and   type = 'U')
   drop table MATIERE_COULEUR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('QTE_BOITE')
            and   type = 'U')
   drop table QTE_BOITE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('REMISE_VOLUME')
            and   type = 'U')
   drop table REMISE_VOLUME
go

/*==============================================================*/
/* Table : BOITE                                                */
/*==============================================================*/
create table BOITE (
   ID_BOITE             bigint               not null,
   ID_COULEUR2          char(7)              not null,
   LONGUEUR             int                  null,
   LARGEUR              int                  null,
   HAUTEUR              int                  null,
   constraint PK_BOITE primary key nonclustered (ID_BOITE),
   constraint DIMENSION_MAXIMALE_BOITE check (Longueur + Largeur + Hauteur < 1000)
)
go

/*==============================================================*/
/* Table : CLIENT                                               */
/*==============================================================*/
create table CLIENT (
   ID_CLIENT            char(6)              not null,
   PRENOM               varchar(38)          null,
   NOM                  varchar(38)          null,
   ADRESSE              varchar(38)          null,
   CP                   char(5)              null,
   VILLE                varchar(38)          null,
   constraint PK_CLIENT primary key nonclustered (ID_CLIENT),
   constraint FORMAT_ID_CLIENT check (id_client LIKE '[a-z][a-z]-[0-9][0-9][0-9]')
)
go

/*==============================================================*/
/* Table : COMMANDE                                             */
/*==============================================================*/
create table COMMANDE (
   ID_COMMANDE          bigint               not null,
   ID_CLIENT            char(6)              not null,
   DATE_COMMANDE        datetime             null,
   DATE_LIVRAISON       datetime             null,
   ETAT                 text                 null,
   constraint PK_COMMANDE primary key nonclustered (ID_COMMANDE)
)
go

/*==============================================================*/
/* Table : COULEUR                                              */
/*==============================================================*/
create table COULEUR (
   ID_COULEUR           char(3)              not null,
   LIBELLE              varchar(20)          null,
   constraint PK_COULEUR primary key nonclustered (ID_COULEUR)
)
go

/*==============================================================*/
/* Table : MATIERE                                              */
/*==============================================================*/
create table MATIERE (
   ID_MATIERE           varchar(3)           not null,
   LIBELLE              varchar(20)          null,
   constraint PK_MATIERE primary key nonclustered (ID_MATIERE)
)
go

/*==============================================================*/
/* Table : MATIERE_COULEUR                                      */
/*==============================================================*/
create table MATIERE_COULEUR (
   ID_COULEUR2          char(7)              not null,
   ID_MATIERE           varchar(3)           not null,
   ID_COULEUR           char(3)              not null,
   constraint PK_MATIERE_COULEUR primary key nonclustered (ID_COULEUR2)
)
go

/*==============================================================*/
/* Table : QTE_BOITE                                            */
/*==============================================================*/
create table QTE_BOITE (
   ID_COMMANDE          bigint               not null,
   ID_BOITE             bigint               not null,
   ID_REMISE_VOLUME     smallint             not null,
   QTE                  int                  null,
   PU_HT                decimal(6,2)         null,
   constraint PK_QTE_BOITE primary key nonclustered (ID_COMMANDE, ID_BOITE, ID_REMISE_VOLUME)
)
go

/*==============================================================*/
/* Table : REMISE_VOLUME                                        */
/*==============================================================*/
create table REMISE_VOLUME (
   ID_REMISE_VOLUME     smallint             not null,
   QTE_MINIMALE         int                  null,
   POURCENTAGE_REMISE   decimal(3,1)         null,
   constraint PK_REMISE_VOLUME primary key nonclustered (ID_REMISE_VOLUME)
)
go

