# Présentation

Le cours d'ESN12 sert à mettre en oeuvre les connaissances apprises lors du cours de conception conjointe. Le but de ces TP est d'utiliser les connaisances que nous avons mis en oeuvre dans les séances d'ESN11. Nous utilisons une carte électronique DE-10 lite qui contient un FPGA. L'objectif de ce lab est de calibrer un accelerometre et d'afficher les valeurs des axes sur les afficheur 7 segments

# Architecture

Voici l'achitecture de notre système:

![image](https://github.com/ESN2024/lacheze_lab3/assets/147801348/b8ac8a19-1bbb-4cab-859f-7cf837ef9eb5)

On retrouve sur le schéma , le timer, le pio du bouton poussoir, les 6 pio pour les afficheurs 7 segments. et le module opencore i2c qui réalise la liaison i2c avec l'accéléromètre.

# Design QSYS

![image](https://github.com/ESN2024/lacheze_lab3/assets/147801348/ad7728c9-82ad-4e38-8cd0-933c9af97026)

![image](https://github.com/ESN2024/lacheze_lab3/assets/147801348/983660cb-4258-484b-9a73-0cbda56b122d)

On retrouve les modules qui ont été décris dans les 
