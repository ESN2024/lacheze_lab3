# Présentation

Le cours d'ESN12 sert à mettre en oeuvre les connaissances apprises lors du cours de conception conjointe. Le but de ces TP est d'utiliser les connaisances que nous avons mis en oeuvre dans les séances d'ESN11. Nous utilisons une carte électronique DE-10 lite qui contient un FPGA. L'objectif de ce lab est de calibrer un accelerometre et d'afficher les valeurs des axes sur les afficheur 7 segments

# Architecture

Voici l'achitecture de notre système:

![image](https://github.com/ESN2024/lacheze_lab3/assets/147801348/b8ac8a19-1bbb-4cab-859f-7cf837ef9eb5)

On retrouve sur le schéma , le timer, le pio du bouton poussoir, les 6 pio pour les afficheurs 7 segments. et le module opencore i2c qui réalise la liaison i2c avec l'accéléromètre.

# Design QSYS

![image](https://github.com/ESN2024/lacheze_lab3/assets/147801348/ad7728c9-82ad-4e38-8cd0-933c9af97026)

![image](https://github.com/ESN2024/lacheze_lab3/assets/147801348/983660cb-4258-484b-9a73-0cbda56b122d)

On retrouve les modules qui ont été décris dans le schéma. On a bien les interruptions du système qui serviront a  recuperer les valeurs de l'acceleromètre et changer l'axe de l'accelerometre qui sera affiché sur les 7 segments

# Mise en oeuvre du lab

## offset calibration
On réalise l'offset de l'accelerometre en récupérant les valeurs de l acceleromètre lors de l initialisation.

Sur la datasheet, on remarque:
![image](https://github.com/ESN2024/lacheze_lab3/assets/147801348/06152515-38f4-473e-abde-25a2a13ea169)

on doit donc faire le complement à 2 des valeurs des axes que l ont a récupérer puis on divise la valeur par 4 pour avoir la valeur de l offset qui sera initialisé.

on initialise la valeur que nous avons trouvé dans au debut du main

##creation des fonction read et write

Les méthodes d'écriture et de lecture des registres de l'adx sont fournis dans la datasheet:

![image](https://github.com/ESN2024/lacheze_lab3/assets/147801348/c625ef29-0be7-465a-8b9c-bb9a3fd866ae)

On réalise donc les fonctions acc_read et acc_write en accord avec les instructions de la datasheet

## creation de la fonction segment

la fonction segment est la fonction qui va récupérer la valeur de l'acceleromètre et va la décomposer en segments qui seront ensuite envoyé vers les 7 segments. On réalise cela en faisant des divisions avec des modulos  pour récupérer les différents segments.

## multiplication par 3.9

On doit multiplier les valeurs que l'on eu sur l'acceleromètre car les valeurs de sorties des axes sont en LSB. Multiplier la valeur permet de passer les vlaeurs en mg.

## interruption du timer

L'interruption du timer permet de récupérer les valeurs de l'accéléromètre et de les afficher sur les 7 segments chaque seconde. La majorité du code se trouve dans l'interruption.

## interruption du bp

Les valeurs de l'accéléromètre sont stockés dans un tableau data qui possède 3 composantes : x, y et z. L'appui sur le bp déclenche l'interruption et change l'axe qui sera affiché. Cela permet de ne faire les étapes de traitement des données une seule fois

# Réalisation

Au final, le projet ne fonctionne pas totalement, on a bien les valeurs 0 , 0 et 1000 sur les axes x , y et z mais lorsque l'on penche la carte pour faire varier l'accéléromètre et que la valeur dépasse 480 environ, l'afficheur met un signe négatif et la valeur décroit . Dans les positions particulière ( 0 ou 1000 de valeur, on a bien les bonnes données).


