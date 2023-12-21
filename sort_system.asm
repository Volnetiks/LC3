.orig x3000

;####################### func_sort #####################
;##            trie les éléments de TABLEAU           ##
;#######################################################
FUNC_SORT ;LABEL alias d'adresse de la première instruction de la fonction func_sort
;[votre code ici]

LEA R1, TABLEAU ; On charge l'adresse d'une case du tableau (ici la première case)
AND R2, R2, #0 ; On initialise un registre pour tenir le compte des cases parcourues
ST R2, COMPTEUR_PARCOURU_I ; On l'enregistre en mémoire

LD R3, TAILLE_TABLEAU ; On charge la taille de tableau pour la comparer au compteur
NOT R3, R3 ; On l'inverse
ADD R3, R3, #1 ; On Complémente

BOUCLE_TABLEAU LD R2, COMPTEUR_PARCOURU_I
ADD R4, R2, R3 ; première instruction de la boucle au label BOUCLE_TABLEAU
BRZP FIN; On compare et on sort si la fin du tableau est atteinte

; BOUCLE 2 DEBUT
ADD R3, R3, #1 ; on ajoute 1 pour ne pas faire l'itération vide à la fin
AND R2, R2, #0
BOUCLE_DEUX ADD R4, R2, R3
BRZP FIN_DEUX ; On compare et on sors si la boucle est fini

ADD R0, R2, #0 ; on mets R2 à R0
ST R2, COMPTEUR_PARCOURU_J ; on enregistre
LEA R2, TABLEAU ; on charge l'addresse du tableau
ADD R2, R2, R0 ; on ajoute J à R2

LDR R0, R2, #0 ; On récupère à R0
ST R0, VALEUR1m ; on enregistre
LDR R0, R2, #1 ; On récupère la valeur suivante
ST R0, VALEUR2m ; on enregistre

JSR FUNC_MAX

AND R0, R0, #0 ; on réinitialise R0
LD R5, RESULTATm ; on charge le résultat
BRNZ NEXT_VALUE

LDR R5, R2, #0 ; On charge la valeur de la première case du TABLEAU
LDR R6, R2, #1 ; On charge la valeur de la case voisine
STR R5, R2, #1 ; On interchange les deux valeurs 
STR R6, R2, #0

NEXT_VALUE
LD R2, COMPTEUR_PARCOURU_J ; on recharge la valeur

ADD R2, R2, #1
BRNZP BOUCLE_DEUX

FIN_DEUX
; BOUCLE 2 FIN

ADD R3, R3, #-1 ; on rajoute 1 à R3 pour la première boucle
AND R2, R2, #0
ST R2, COMPTEUR_PARCOURU_J ; on remet j à 0
ADD R1, R1, #1 ; On incrémente l'adresse de la case courante
LD R2, COMPTEUR_PARCOURU_I ; On charge pour incrémenter
ADD R2, R2, #1 ; On incrémente le compteur de cases visitées
ST R2, COMPTEUR_PARCOURU_I ; On enregistre à nouveau
BRNZP BOUCLE_TABLEAU ; On boucle de manière inconditionnel

FIN HALT ; Instruction HALT au label FIN

;####################### func_max #######################
;## calcule RESULTATm = 0 si VALEUR1m >= VALEUR2m       ##
;##	        RESULTATm = 1 si VALEUR1m <  VALEUR2m       ##
;########################################################
FUNC_MAX ;LABEL alias d'adresse de la première instruction de la fonction func_max 
;[ma fonction func_max]
LD R0, VALEUR1m ; on charge valeur1m
LD R6, VALEUR2m ; on charge valeur2m

NOT R6, R6 ; on inverse R6
ADD R6, R6, #1 ; on complémente

ADD R5, R0, R6 ; on soustrait
ST R5, RESULTATm ; on enregistre le résultat

RET


;espace mémoire func_max
VALEUR1m .blkw #1
VALEUR2m .blkw #1
RESULTATm .blkw #1

;espace mémoire func_sort
ADRESSE_TABLEAU_I .blkw #1
ADRESSE_TABLEAU_J .blkw #1
COMPTEUR_PARCOURU_I .blkw #1
COMPTEUR_PARCOURU_J .blkw #1
TAILLE_TABLEAU .fill #10
TABLEAU .fill #5
.fill #2
.fill #6
.fill #1
.fill #7
.fill #2
.fill #8
.fill #22
.fill #1
.fill #12

.END


; OBJECTIF: [1, 1, 2, 2, 5, 6, 7, 8, 12, 22]
; CURRENT: [2, 1, 2, 5, 1, 0, 6, 7, 8, 12, 22] 