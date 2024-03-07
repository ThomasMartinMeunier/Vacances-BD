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



