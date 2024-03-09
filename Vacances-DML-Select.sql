/* **********************************************************
	DML Select
	Schéma MRD:	"Cas Village Vacances"
	Auteur:		Arthur Tirado et Thomas Martin-Meunier
***********************************************************/

USE VILLAGE_VACANCES

/*
-- 1
Produire la liste des tarifs des nuitées pour le type de logement D3
Pour chaque prix, indiquer dans l’ordre :
- Le code du type de logement,
- La description du type de logement,
- Le numéro de la catégorie du village,
- La description de la catégorie du village,
- Le prix/nuit/personne en $ canadiens, avec le format d’affichage : 80,00 $ (format
monétaire canadien français, 2 chiffres après la virgule)
• Trier par catégorie de village.
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
Produire la liste des catégories de village et calculer le tarif moyen des nuitées pour chacune.
• Pour chaque catégorie de village, indiquer dans l’ordre :
- Le numéro de la catégorie du village,
- La description de la catégorie du village,
- Le prix moyen par personne et par nuit des logements avec le format d’affichage :
63,75 $ (format monétaire canadien français, 2 chiffres après la virgule)
• Trier par catégorie de village
*/

SELECT
	CATEGORIE_VILLAGE.NO_CATEGORIE,
	CATEGORIE_VILLAGE.DESCRIPTION AS "DESCRIPTION_CATEGORIE_VILLAGE",
	LEFT(FORMAT(AVG(TARIF_NUITEE.TARIF_UNITAIRE), 'C', 'fr-CA'), 10) AS "PRIX_PAR_NUIT_PAR_PERSONNE"
FROM
	TARIF_NUITEE
	INNER JOIN CATEGORIE_VILLAGE
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

(3 lignes affectées)
*/

/*
--3
• Produire le calendrier d’occupation du logement 108 du village Casa-Dali pour le mois de mars
2024.
• Indiquer dans l’ordre :
- Le numéro du logement,
- Le nom du village,
- Le nom du pays,
- Le code du type de logement,
- La description du type de logement,
- L’identifiant de la réservation,
- La date du séjour (de la nuit occupée) avec le format d’affichage : 28/03/2024.
• Trier par date.
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

(15 lignes affectées)
*/

/*
--4 
Pour les clients ayant plus d’une réservation, indiquer le village, la date d’arrivée et le nombre de
jours de chaque réservation.
• Indiquer dans l’ordre :
- Les nom et prénom et identifiant du client, sous le format : Sylvie Monjal (1)
- L’identifiant de la réservation,
- La date d’arrivée au village avec le format d’affichage : jeudi 09 mars 2024 (format
long canadien français de date),
- Le nom du village vacances,
- La durée en nombre de jours des vacances.
• Trier par nom et prénom du client, puis date d’arrivée au village vacances de la réservation
*/
SELECT
	CONCAT(CLIENT.NOM, ' ', CLIENT.PRENOM, ' (',CLIENT.ID_CLIENT ,')') AS CLIENT,
	RESERVATION.ID_RESERVATION,
	LEFT(FORMAT(MIN(SEJOUR.DATE_SEJOUR), 'dddd dd MMMM yyyy', 'fr-CA'),25) AS DATE_ARRIVE,
	VILLAGE.NOM_VILLAGE,
	COUNT(SEJOUR.ID_SEJOUR) AS DUREE_VACANCE
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
Daho Étienne (1)                                                                                1012                                    mercredi 27 décembre 2023 Porto-Nuevo     28
Daho Étienne (1)                                                                                1014                                    jeudi 07 mars 2024        Porto-Nuevo     3
Daho Étienne (1)                                                                                1000                                    vendredi 15 mars 2024     Casa-Dali       10
Fiset Valérie (12)                                                                              1006                                    mercredi 06 mars 2024     Casa-Dali       4
Fiset Valérie (12)                                                                              1010                                    mercredi 03 avril 2024    Casa-Dali       2
Fortin Marine (9)                                                                               1017                                    dimanche 17 mars 2024     Kouros          4
Fortin Marine (9)                                                                               1007                                    mardi 26 mars 2024        Casa-Dali       16
Plante Josée (8)                                                                                1015                                    samedi 09 mars 2024       Porto-Nuevo     12
Plante Josée (8)                                                                                1001                                    mercredi 13 mars 2024     Casa-Dali       12
St-Onge Éric (7)                                                                                1002                                    samedi 09 mars 2024       Casa-Dali       4
St-Onge Éric (7)                                                                                1009                                    dimanche 31 mars 2024     Casa-Dali       6
St-Onge Éric (7)                                                                                1003                                    mardi 11 mars 2025        Casa-Dali       4

(12 rows affected)

*/