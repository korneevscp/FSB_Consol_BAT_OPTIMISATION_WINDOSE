FBS-Console – Terminal de Maintenance Windows
Présentation

FBS-Console est un script .bat complet et interactif conçu pour effectuer la maintenance et l’optimisation de Windows 10 et 11.
Il offre une interface type "console technique", avec un style sobre (fond noir, texte vert) et des outils puissants d’administration système.

Une fois le mot de passe saisi, le menu principal donne accès à toutes les fonctions essentielles : nettoyage, optimisation, informations système, réparation, etc.
Chaque action est enregistrée dans un fichier journal nommé FBS-Terminal-Log.txt.

Fonctionnalités principales
Authentification

Mot de passe d’accès : fsb2025

Protège l’accès au menu principal.

Empêche l’exécution non autorisée ou accidentelle du script.

Maintenance et nettoyage

Suppression des fichiers temporaires et caches système.

Nettoyage du dossier Temp et des caches Windows Update.

Réparation des fichiers système avec SFC /scannow et DISM /RestoreHealth.

Nettoyage du registre et du disque.

Défragmentation rapide des volumes NTFS.

Optimisation réseau (Ethernet)

Optimise automatiquement la carte réseau Ethernet :

Réinitialisation des paramètres TCP/IP et Winsock.

Vidage du cache DNS.

Configuration automatique des DNS Cloudflare (1.1.1.1 / 1.0.0.1).

Ajustement du MTU et des paramètres réseau pour de meilleures performances.

Redémarrage des services réseau essentiels.

Remarque : cette fonction agit uniquement sur l’interface nommée “Ethernet”.

Informations système

Affichage de l’utilisation CPU et RAM.

Espace disque libre et utilisé.

Adresse IP locale et publique.

Test de latence via un ping vers Google.

Autres outils

Lancement du nettoyage intégré de Windows (cleanmgr).

Réinitialisation complète de Windows Update.

Journalisation automatique de toutes les actions dans FBS-Terminal-Log.txt.

Apparence personnalisée : couleur verte 0B, titre de fenêtre FBS-Console.

Utilisation

Copier le fichier FBS-Console.bat sur le bureau.

Cliquer droit → Exécuter en tant qu’administrateur.

Entrer le mot de passe : fsb2025.

Une fois connecté, le menu principal s’affiche.

Taper le numéro correspondant à l’action souhaitée.

Laisser le script exécuter la tâche ; les détails apparaissent à l’écran.

Fichiers créés

FBS-Terminal-Log.txt : journal complet des opérations exécutées.

C:\Windows\Temp\FBS-Backup : dossier temporaire pour certaines sauvegardes système.

Avertissements

Ce script effectue de véritables modifications système (réseau, fichiers, cache).

Il doit être exécuté en tant qu’administrateur pour fonctionner correctement.

Certaines commandes (notamment DISM et SFC) peuvent durer plusieurs minutes.

Ne pas fermer la fenêtre de commande pendant leur exécution.

Crédits

Projet personnalisé inspiré d’outils d’administration système et d’environnements techniques.
Créé pour un usage personnel d’optimisation et de maintenance Windows.

[url] https://i.pinimg.com/736x/68/fe/35/68fe359d4c9b42b13e721b1423454bf4.jpg [/url]

