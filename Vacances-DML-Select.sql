/* **********************************************************
	DML Select
	Sch�ma MRD:	"Cas Village Vacances"
	Auteur:		Arthur Tirado et Thomas Martin-Meunier
***********************************************************/

USE VILLAGE_VACANCES

/*
-- 1
Produire la liste des tarifs des nuit�es pour le type de logement D3
Pour chaque prix, indiquer dans l�ordre :
- Le code du type de logement,
- La description du type de logement,
- Le num�ro de la cat�gorie du village,
- La description de la cat�gorie du village,
- Le prix/nuit/personne en $ canadiens, avec le format d�affichage : 80,00 $ (format
mon�taire canadien fran�ais, 2 chiffres apr�s la virgule)
� Trier par cat�gorie de village.
*/
SELECT 
	TYPE_LOGEMENT.CODE_TYPE_LOGEMENT,
	TYPE_LOGEMENT.DESCRIPTION AS "DESCRIPTION_TYPE_LOGEMENT",
	CATEGORIE_VILLAGE.NO_CATEGORIE,
	CATEGORIE_VILLAGE.DESCRIPTION AS "DESCRIPTION_CATEGORIE_VILLAGE",
	LEFT(FORMAT(TARIF_NUITEE.TARIF_UNITAIRE, 'C', 'fr-CA'),10) AS "PRIX_PAR_NUIT_PAR_PERSONNE"
FROM 
	TARIF_NUITEE
	INNER JOIN TYPE_LOGEMENT
		ON TARIF_NUITEE.ID_TYPE_LOGEMENT = TYPE_LOGEMENT.ID_TYPE_LOGEMENT
	INNER JOIN CATEGORIE_VILLAGE
		ON TARIF_NUITEE.ID_CATEGORIE_VILLAGE = CATEGORIE_VILLAGE.ID_CATEGORIE_VILLAGE
WHERE
	TYPE_LOGEMENT.CODE_TYPE_LOGEMENT = 'D3'
ORDER BY 
	CATEGORIE_VILLAGE.NO_CATEGORIE
/*
CODE_TYPE_LOGEMENT DESCRIPTION_TYPE_LOGEMENT           NO_CATEGORIE DESCRIPTION_CATEGORIE_VILLAGE                      PRIX_PAR_NUIT_PAR_PERSONNE
------------------ ----------------------------------- ------------ -------------------------------------------------- --------------------------
D3                 Chalet 2 personnes                  1            tennis, piscine, mini-golf, golf, sauna, garderie  80,00 $
D3                 Chalet 2 personnes                  2            tennis, piscine, golf, sauna                       60,00 $
D3                 Chalet 2 personnes                  3            tennis, piscine, garderie                          55,00 $

(3 rows affected)
*/

/*
--2
Produire la liste des cat�gories de village et calculer le tarif moyen des nuit�es pour chacune.
� Pour chaque cat�gorie de village, indiquer dans l�ordre :
- Le num�ro de la cat�gorie du village,
- La description de la cat�gorie du village,
- Le prix moyen par personne et par nuit des logements avec le format d�affichage :
63,75 $ (format mon�taire canadien fran�ais, 2 chiffres apr�s la virgule)
� Trier par cat�gorie de village
*/

SELECT
	CATEGORIE_VILLAGE.NO_CATEGORIE,
	CATEGORIE_VILLAGE.DESCRIPTION AS "DESCRIPTION_CATEGORIE_VILLAGE",
	LEFT(FORMAT(AVG(TARIF_NUITEE.TARIF_UNITAIRE), 'C', 'fr-CA'), 10) AS "PRIX_PAR_NUIT_PAR_PERSONNE"
FROM
	TARIF_NUITEE
		RIGHT OUTER JOIN CATEGORIE_VILLAGE
			ON TARIF_NUITEE.ID_CATEGORIE_VILLAGE = CATEGORIE_VILLAGE.ID_CATEGORIE_VILLAGE
GROUP BY
	CATEGORIE_VILLAGE.NO_CATEGORIE,
	CATEGORIE_VILLAGE.DESCRIPTION
ORDER BY 
	CATEGORIE_VILLAGE.NO_CATEGORIE

/*
NO_CATEGORIE DESCRIPTION_CATEGORIE_VILLAGE                      PRIX_PAR_NUIT_PAR_PERSONNE
------------ -------------------------------------------------- --------------------------
1            tennis, piscine, mini-golf, golf, sauna, garderie  57,27 $
2            tennis, piscine, golf, sauna                       48,64 $
3            tennis, piscine, garderie                          43,64 $
4            spa, ping-pong, activit�s nautiques                NULL

(4�lignes affect�es)
*/

/*
--3
� Produire le calendrier d�occupation du logement 108 du village Casa-Dali pour le mois de mars
2024.
� Indiquer dans l�ordre :
- Le num�ro du logement,
- Le nom du village,
- Le nom du pays,
- Le code du type de logement,
- La description du type de logement,
- L�identifiant de la r�servation,
- La date du s�jour (de la nuit occup�e) avec le format d�affichage : 28/03/2024.
� Trier par date.
*/

SELECT 
	LOGEMENT.NO_LOGEMENT,
	VILLAGE.NOM_VILLAGE,
	VILLAGE.PAYS,
	TYPE_LOGEMENT.CODE_TYPE_LOGEMENT,
	TYPE_LOGEMENT.DESCRIPTION AS "DESCRIPTION_TYPE_LOGEMENT",
	SEJOUR.ID_RESERVATION,
	LEFT(FORMAT(SEJOUR.DATE_SEJOUR, 'dd/MM/yyyy'), 10) AS DATE_DE_SEJOUR
FROM
	SEJOUR
		INNER JOIN LOGEMENT
			ON SEJOUR.ID_LOGEMENT = LOGEMENT.ID_LOGEMENT
		INNER JOIN VILLAGE
			ON LOGEMENT.ID_VILLAGE = VILLAGE.ID_VILLAGE
		INNER JOIN TYPE_LOGEMENT
			ON LOGEMENT.ID_TYPE_LOGEMENT = TYPE_LOGEMENT.ID_TYPE_LOGEMENT
WHERE
	LOGEMENT.NO_LOGEMENT = 108 
	AND VILLAGE.NOM_VILLAGE = 'Casa-Dali'
	AND SEJOUR.DATE_SEJOUR BETWEEN '2024-03-01' AND '2024-03-31'
ORDER BY 
	SEJOUR.DATE_SEJOUR

/*
NO_LOGEMENT NOM_VILLAGE     PAYS       CODE_TYPE_LOGEMENT DESCRIPTION_TYPE_LOGEMENT           ID_RESERVATION                          DATE_DE_SEJOUR
----------- --------------- ---------- ------------------ ----------------------------------- --------------------------------------- --------------
108         Casa-Dali       Espagne    D2                 Chalet 4 personnes                  1002                                    09/03/2024
108         Casa-Dali       Espagne    D2                 Chalet 4 personnes                  1002                                    10/03/2024
108         Casa-Dali       Espagne    D2                 Chalet 4 personnes                  1002                                    11/03/2024
108         Casa-Dali       Espagne    D2                 Chalet 4 personnes                  1002                                    12/03/2024
108         Casa-Dali       Espagne    D2                 Chalet 4 personnes                  1000                                    15/03/2024
108         Casa-Dali       Espagne    D2                 Chalet 4 personnes                  1000                                    16/03/2024
108         Casa-Dali       Espagne    D2                 Chalet 4 personnes                  1000                                    17/03/2024
108         Casa-Dali       Espagne    D2                 Chalet 4 personnes                  1000                                    18/03/2024
108         Casa-Dali       Espagne    D2                 Chalet 4 personnes                  1000                                    19/03/2024
108         Casa-Dali       Espagne    D2                 Chalet 4 personnes                  1005                                    20/03/2024
108         Casa-Dali       Espagne    D2                 Chalet 4 personnes                  1005                                    21/03/2024
108         Casa-Dali       Espagne    D2                 Chalet 4 personnes                  1005                                    22/03/2024
108         Casa-Dali       Espagne    D2                 Chalet 4 personnes                  1005                                    23/03/2024
108         Casa-Dali       Espagne    D2                 Chalet 4 personnes                  1005                                    24/03/2024
108         Casa-Dali       Espagne    D2                 Chalet 4 personnes                  1005                                    25/03/2024

(15�lignes affect�es)
*/

/*
--4 
Pour les clients ayant plus d�une r�servation, indiquer le village, la date d�arriv�e et le nombre de
jours de chaque r�servation.
� Indiquer dans l�ordre :
- Les nom et pr�nom et identifiant du client, sous le format : Sylvie Monjal (1)
- L�identifiant de la r�servation,
- La date d�arriv�e au village avec le format d�affichage : jeudi 09 mars 2024 (format
long canadien fran�ais de date),
- Le nom du village vacances,
- La dur�e en nombre de jours des vacances.
� Trier par nom et pr�nom du client, puis date d�arriv�e au village vacances de la r�servation
*/
SELECT
	CONCAT(CLIENT.NOM, ' ', CLIENT.PRENOM, ' (',CLIENT.ID_CLIENT ,')') AS CLIENT,
	RESERVATION.ID_RESERVATION,
	LEFT(FORMAT(MIN(SEJOUR.DATE_SEJOUR), 'dddd dd MMMM yyyy', 'fr-CA'),25) AS DATE_ARRIVE,
	VILLAGE.NOM_VILLAGE,
	COUNT(DISTINCT SEJOUR.DATE_SEJOUR) AS DUREE_VACANCE
FROM 
	SEJOUR
	INNER JOIN RESERVATION
		ON SEJOUR.ID_RESERVATION = RESERVATION.ID_RESERVATION
	INNER JOIN CLIENT 
		ON RESERVATION.ID_CLIENT = CLIENT.ID_CLIENT
	INNER JOIN VILLAGE
		ON RESERVATION.ID_VILLAGE = VILLAGE.ID_VILLAGE
WHERE
	CLIENT.ID_CLIENT IN (SELECT ID_CLIENT 
						FROM 
							RESERVATION
						GROUP BY 
							RESERVATION.ID_CLIENT
						HAVING
							COUNT(ID_CLIENT) > 1)
GROUP BY
	CLIENT.ID_CLIENT,
	CLIENT.NOM,
	CLIENT.PRENOM,
	RESERVATION.ID_RESERVATION,
	RESERVATION.DATE_RESERVATION,
	VILLAGE.NOM_VILLAGE
ORDER BY
	CONCAT(CLIENT.NOM, ' ', CLIENT.PRENOM),
	MIN(SEJOUR.DATE_SEJOUR)

/*
CLIENT                                                                                          ID_RESERVATION                          DATE_ARRIVE               NOM_VILLAGE     DUREE_VACANCE
----------------------------------------------------------------------------------------------- --------------------------------------- ------------------------- --------------- -------------
Daho �tienne (1)                                                                                1012                                    mercredi 27 d�cembre 2023 Porto-Nuevo     7
Daho �tienne (1)                                                                                1014                                    jeudi 07 mars 2024        Porto-Nuevo     3
Daho �tienne (1)                                                                                1000                                    vendredi 15 mars 2024     Casa-Dali       5
Fiset Val�rie (12)                                                                              1006                                    mercredi 06 mars 2024     Casa-Dali       4
Fiset Val�rie (12)                                                                              1010                                    mercredi 03 avril 2024    Casa-Dali       2
Fortin Marine (9)                                                                               1017                                    dimanche 17 mars 2024     Kouros          4
Fortin Marine (9)                                                                               1007                                    mardi 26 mars 2024        Casa-Dali       4
Plante Jos�e (8)                                                                                1015                                    samedi 09 mars 2024       Porto-Nuevo     6
Plante Jos�e (8)                                                                                1001                                    mercredi 13 mars 2024     Casa-Dali       6
St-Onge �ric (7)                                                                                1002                                    samedi 09 mars 2024       Casa-Dali       4
St-Onge �ric (7)                                                                                1009                                    dimanche 31 mars 2024     Casa-Dali       6
St-Onge �ric (7)                                                                                1003                                    mardi 11 mars 2025        Casa-Dali       4

(12�lignes affect�es)

*/

/*
--5
� Produire la liste des logements du village Casa-Dali disponibles pour toute la p�riode du 17 au 23
mars 2024 inclusivement.
� Pour chaque logement disponible, indiquer dans l�ordre :
- Le num�ro du logement,
- Le code du type de logement,
- La description du type de logement.
� Trier par num�ro de logement.

A) �crire la requ�te en utilisant l�op�rateur IN ou NOT IN.
*/

SELECT 
	LOGEMENT.NO_LOGEMENT, 
	TYPE_LOGEMENT.CODE_TYPE_LOGEMENT, 
	TYPE_LOGEMENT.DESCRIPTION AS DESCRIPTION_TYPE_LOGEMENT
FROM 
	LOGEMENT 
		INNER JOIN TYPE_LOGEMENT 
		ON LOGEMENT.ID_TYPE_LOGEMENT = TYPE_LOGEMENT.ID_TYPE_LOGEMENT
WHERE 
	LOGEMENT.ID_VILLAGE = (SELECT 
							ID_VILLAGE 
						   FROM 
							VILLAGE 
						   WHERE 
							NOM_VILLAGE = 'Casa-Dali')
	AND LOGEMENT.ID_LOGEMENT NOT IN ( SELECT 
											SEJOUR.ID_LOGEMENT
									   FROM 
											SEJOUR
									   WHERE 
											SEJOUR.DATE_SEJOUR BETWEEN '2024-03-17' AND '2024-03-23')
ORDER BY 
	LOGEMENT.NO_LOGEMENT

/*
NO_LOGEMENT CODE_TYPE_LOGEMENT DESCRIPTION_TYPE_LOGEMENT
----------- ------------------ -----------------------------------
8           B2                 Suite 2 personnes
11          B2                 Suite 2 personnes
105         D2                 Chalet 4 personnes
107         D2                 Chalet 4 personnes

(4�lignes affect�es)


B) �crire la requ�te en utilisant l�op�rateur EXIST ou NOT EXIST.
*/

SELECT 
	LOGEMENT.NO_LOGEMENT, 
	TYPE_LOGEMENT.CODE_TYPE_LOGEMENT, 
	TYPE_LOGEMENT.DESCRIPTION AS DESCRIPTION_TYPE_LOGEMENT
FROM 
	LOGEMENT 
		INNER JOIN TYPE_LOGEMENT 
		ON LOGEMENT.ID_TYPE_LOGEMENT = TYPE_LOGEMENT.ID_TYPE_LOGEMENT
WHERE 
	LOGEMENT.ID_VILLAGE = (SELECT 
							ID_VILLAGE 
						   FROM 
							VILLAGE 
						   WHERE 
							NOM_VILLAGE = 'Casa-Dali')
	AND NOT EXISTS ( SELECT 
						1
					FROM 
						SEJOUR
					WHERE 
						SEJOUR.ID_LOGEMENT = LOGEMENT.ID_LOGEMENT AND
						SEJOUR.DATE_SEJOUR BETWEEN '2024-03-17' AND '2024-03-23')
ORDER BY 
	LOGEMENT.NO_LOGEMENT
/*
NO_LOGEMENT CODE_TYPE_LOGEMENT DESCRIPTION_TYPE_LOGEMENT
----------- ------------------ -----------------------------------
8           B2                 Suite 2 personnes
11          B2                 Suite 2 personnes
105         D2                 Chalet 4 personnes
107         D2                 Chalet 4 personnes

(4�lignes affect�es)
*/

/* 
--6

A) Cr�er la vue V_NB_NUITEES qui compte pour chaque village vacances le nombre total de
nuit�es vendues.
La vue doit contenir :
- L�identifiant du village,
- Le nom du village.
- Le pays,
- Le nombre total de nuit�es.
Faire ensuite un SELECT pour v�rifier le contenu de la vue.
*/
DROP VIEW IF EXISTS V_NB_NUITEES 
GO 
CREATE VIEW V_NB_NUITEES 
AS
	SELECT
		VILLAGE.ID_VILLAGE,
		VILLAGE.NOM_VILLAGE,
		VILLAGE.PAYS,
		COUNT(SEJOUR.DATE_SEJOUR)*SEJOUR.NB_PERSONNES AS NOMBRE_NUITEE
	FROM VILLAGE
		LEFT OUTER JOIN RESERVATION
			ON VILLAGE.ID_VILLAGE = RESERVATION.ID_VILLAGE
		LEFT OUTER JOIN SEJOUR
			ON RESERVATION.ID_RESERVATION = SEJOUR.ID_RESERVATION
	GROUP BY
		VILLAGE.ID_VILLAGE,
		VILLAGE.NOM_VILLAGE,
		VILLAGE.PAYS

GO
/*
B) �crire la requ�te suivante en utilisant la vue V_NB_NUITEES. (7 pts)
� Quel ou quels sont le ou les villages avec le plus grand nombre de nuit�es vendues?
� Indiquer dans l�ordre :
- Le pays,
- Le nom village,
- Le nombre de nuit�es.
*/

SELECT
	V_NB_NUITEES.PAYS,
	V_NB_NUITEES.NOM_VILLAGE,
	V_NB_NUITEES.NOMBRE_NUITEE
FROM V_NB_NUITEES
WHERE 
	V_NB_NUITEES.NOMBRE_NUITEE IN (SELECT MAX(NOMBRE_NUITEE) FROM V_NB_NUITEES)

/*
--7
A) Cr�er la vue V_RECAPITULATIF_RESERVATION qui contient toutes les r�servations.
La vue doit contenir :
- L�identifiant de la r�servation,
- La date de r�servation,
- L�identifiant du client,
- L�identifiant du village,
- La date de d�part de Montr�al,
- La date de retour � Montr�al,
- La dur�e de la r�servation en nombre de jours,
- Le nombre de personnes concern�es par la r�servation (nombre de personnes
h�berg�es),
- Le nombre total de nuit�es qui seront factur�es.
Faire ensuite un SELECT pour v�rifier le contenu de la vue.
*/
DROP VIEW IF EXISTS V_RECAPITULATIF_RESERVATION 
GO 
CREATE VIEW V_RECAPITULATIF_RESERVATION 
AS
	SELECT
		RESERVATION.ID_RESERVATION,
		LEFT(FORMAT(RESERVATION.DATE_RESERVATION, 'dd/MM/yyyy'), 10) AS DATE_RESERVATION,
		RESERVATION.ID_CLIENT,
		RESERVATION.ID_VILLAGE,
		LEFT(FORMAT(MIN(SEJOUR.DATE_SEJOUR), 'dd/MM/yyyy'), 10) AS DATE_DEPART_MONTREAL,
		LEFT(FORMAT(MAX(SEJOUR.DATE_SEJOUR)+1, 'dd/MM/yyyy'), 10) AS DATE_RETOUR_MONTREAL,
		COUNT(DISTINCT SEJOUR.DATE_SEJOUR) AS DUREE_RESERVATION,
		SEJOUR.NB_PERSONNES,
		COUNT(SEJOUR.DATE_SEJOUR)*SEJOUR.NB_PERSONNES AS NUITES_FACTUREES
	FROM RESERVATION
		INNER JOIN SEJOUR
		ON RESERVATION.ID_RESERVATION = SEJOUR.ID_RESERVATION
	GROUP BY
		RESERVATION.ID_RESERVATION,
		RESERVATION.DATE_RESERVATION,
		RESERVATION.ID_CLIENT,
		RESERVATION.ID_VILLAGE,
		SEJOUR.NB_PERSONNES
GO

SELECT * FROM V_RECAPITULATIF_RESERVATION

/*
ID_RESERVATION                          DATE_RESERVATION ID_CLIENT                               ID_VILLAGE                              DATE_DEPART_MONTREAL DATE_RETOUR_MONTREAL DUREE_RESERVATION NB_PERSONNES NUITES_FACTUREES
--------------------------------------- ---------------- --------------------------------------- --------------------------------------- -------------------- -------------------- ----------------- ------------ ----------------
1000                                    12/02/2024       1                                       1                                       15/03/2024           20/03/2024           5                 2            10
1000                                    12/02/2024       1                                       1                                       15/03/2024           20/03/2024           5                 4            20
1001                                    13/02/2024       8                                       1                                       13/03/2024           19/03/2024           6                 2            24
1002                                    15/02/2024       7                                       1                                       09/03/2024           13/03/2024           4                 3            12
1003                                    15/02/2024       7                                       1                                       11/03/2025           15/03/2025           4                 3            12
1004                                    24/02/2024       2                                       1                                       17/03/2024           24/03/2024           7                 2            42
1004                                    24/02/2024       2                                       1                                       17/03/2024           24/03/2024           7                 4            28
1004                                    24/02/2024       2                                       1                                       17/03/2024           24/03/2024           7                 5            35
1005                                    19/02/2024       5                                       1                                       20/03/2024           26/03/2024           6                 4            24
1005                                    19/02/2024       5                                       1                                       20/03/2024           26/03/2024           6                 5            30
1006                                    31/01/2024       12                                      1                                       06/03/2024           10/03/2024           4                 2            8
1007                                    12/12/2023       9                                       1                                       26/03/2024           30/03/2024           4                 2            24
1007                                    12/12/2023       9                                       1                                       26/03/2024           30/03/2024           4                 4            16
1008                                    11/01/2023       6                                       1                                       26/02/2024           29/02/2024           3                 4            60
1009                                    19/02/2024       7                                       1                                       31/03/2024           06/04/2024           6                 6            36
1010                                    31/01/2024       12                                      1                                       03/04/2024           05/04/2024           2                 2            4
1011                                    02/01/2024       14                                      1                                       24/02/2024           03/04/2024           39                2            78
1012                                    15/09/2023       1                                       2                                       27/12/2023           03/01/2024           7                 2            56
1013                                    17/02/2024       3                                       2                                       02/03/2025           07/03/2025           5                 2            40
1014                                    28/02/2024       1                                       2                                       07/03/2024           10/03/2024           3                 2            6
1015                                    28/02/2024       8                                       2                                       09/03/2024           15/03/2024           6                 2            24
1016                                    19/02/2024       4                                       2                                       01/03/2024           02/03/2024           1                 3            3
1017                                    24/02/2024       9                                       4                                       17/03/2024           21/03/2024           4                 1            4
1018                                    25/02/2024       13                                      4                                       18/03/2024           21/03/2024           3                 1            3
1018                                    25/02/2024       13                                      4                                       18/03/2024           21/03/2024           3                 4            12

(25 rows affected)
*/

/*
B) �crire la requ�te suivante en utilisant la vue V_RECAPITULATIF_RESERVATION. (7 pts)
� Produire les confirmations pour toutes les r�servations effectu�es (date de r�servation) entre le
12 et le 20 f�vrier 2024 inclusivement.
� Pour chaque r�servation, indiquer dans l�ordre :
- L�identifiant de la r�servation,
- Les nom, pr�nom et identifiant du client sous le format : Sylvie Monjal (1)
- Le nom du village,
- La date de d�part de Montr�al avec le format d�affichage : 2024-03-15 (format
canadien fran�ais de date par d�faut),
- La date de retour � Montr�al avec le format d�affichage : 2024-03-20,
- Le nombre de personnes concern�es par la r�servation (nombre de personnes
h�berg�es).
� Trier par date de r�servation, puis par identifiant de r�servation.
*/

SELECT
	V_RECAPITULATIF_RESERVATION.ID_RESERVATION,
	CONCAT(CLIENT.NOM, ' ', CLIENT.PRENOM, ' (',CLIENT.ID_CLIENT ,')') AS CLIENT,
	VILLAGE.NOM_VILLAGE,
	V_RECAPITULATIF_RESERVATION.DATE_DEPART_MONTREAL,
	V_RECAPITULATIF_RESERVATION.DATE_RETOUR_MONTREAL,
	V_RECAPITULATIF_RESERVATION.NB_PERSONNES

FROM 
	V_RECAPITULATIF_RESERVATION
		INNER JOIN CLIENT
			ON V_RECAPITULATIF_RESERVATION.ID_CLIENT = CLIENT.ID_CLIENT
		INNER JOIN VILLAGE
			ON V_RECAPITULATIF_RESERVATION.ID_VILLAGE = VILLAGE.ID_VILLAGE
WHERE
	V_RECAPITULATIF_RESERVATION.DATE_RESERVATION BETWEEN '2024-02-12' AND '2024-02-20'

ORDER BY 
	V_RECAPITULATIF_RESERVATION.DATE_RESERVATION,
	V_RECAPITULATIF_RESERVATION.ID_RESERVATION
