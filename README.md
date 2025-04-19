Windows 11 - Post-Install PowerShell Hardening Script

🔒 Objectif

Un script PowerShell simple et efficace pour optimiser et sécuriser un poste Windows 11 après installation. Il applique des configurations essentielles inspirées des recommandations de l’ANSSI et du CIS Benchmark, tout en supprimant les logiciels inutiles souvent préinstallés.

Ce projet ne vise pas l’exhaustivité. Il fournit une base saine et accessible, que chacun peut ensuite adapter selon ses besoins et son niveau d’exigence.

📦 Contenu du dépôt

Windows11_PostInstall_Hardening_v2.ps1 — Le script principal à exécuter.

launch_script.bat — Permet de lancer le script PowerShell en un double-clic.

PostInstallationLog.txt — Log détaillé généré automatiquement.

resultat_final.txt — Résumé synthétique des actions appliquées.

README.md — Ce fichier d’explication.

⚙️ Ce que fait le script

🔧 Optimisation système

Désactivation de l’hibernation et du démarrage rapide

Passage au mode d’alimentation haute performance

Nettoyage des tâches planifiées inutiles (OneDrive, Cortana, Skype...)

🔐 Sécurisation

Activation de Defender, pare-feu Windows, SmartScreen, UAC renforcé

Désactivation de protocoles obsolètes : NetBIOS, LLMNR, SMBv1, PowerShell v2

Suppression des bloatwares : Xbox, Skype, OneDrive, 3DBuilder, etc.

Application de quelques bonnes pratiques ANSSI/CIS (logging, politique de mot de passe, etc.)

📁 Log & Audit

Deux fichiers .txt sont générés pour suivre toutes les actions exécutées

Aucun redémarrage automatique n’est forcé

▶️ Exécution

Méthode 1 : Lancement automatique
launch_script.bat
📌 Fichier à exécuter en tant qu’administrateur (clic droit > Exécuter en tant qu’administrateur).

Méthode 2 : Exécution manuelle

Set-ExecutionPolicy Bypass -Scope Process -Force
.\Windows11_PostInstall_Hardening_v2.ps1

📌 Remarques

Ce script n’est pas signé. Il est conseillé de le lire avant exécution.

Il ne modifie pas de paramètres critiques ou risqués, mais mieux vaut le tester sur une VM avant tout déploiement en production.

Toutes les actions sont réversibles manuellement.

🙌 Contributions

Les pull requests sont les bienvenues !
Si vous souhaitez proposer une amélioration ou adapter ce script à d'autres environnements (pro, éducation, etc.), n'hésitez pas.

📜 Licence

MIT — Utilisation libre et modification autorisée.

👤 Auteur

https://github.com/jamelchoulo75

Merci à tous pour vos retours et votre enthousiasme !

