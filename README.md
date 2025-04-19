Windows 11 - Script d'Optimisation et de Sécurisation

Description

Ce script PowerShell permet une optimisation rapide et basique ainsi qu'une sécurisation initiale d'un poste de travail Windows 11, en s'appuyant sur les meilleures pratiques de sécurité informatique issues des recommandations du CISA Benchmark et de l'ANSSI.

Il effectue notamment :

L'optimisation des paramètres système (hibernation, alimentation, etc.).

L'activation de plusieurs fonctionnalités de sécurité natives.

La désactivation de protocoles réseau obsolètes (NetBIOS, LLMNR).

L'activation du Pare-feu Windows et de Windows Defender avec une journalisation étendue.

L'activation de Windows Defender SmartScreen.

La désinstallation automatique d'applications inutiles préinstallées (Xbox, Skype, Solitaire, etc.).

La désactivation de tâches planifiées inutiles (OneDrive, Cortana, etc.).

Prérequis

Windows 11

Exécuter le script en tant qu'administrateur

Assurez-vous que l'exécution des scripts PowerShell soit autorisée temporairement (voir ci-dessous)

Utilisation

Téléchargement : Téléchargez le script Windows11_PostInstall_Hardening_v2.ps1 et le fichier launch_script.bat.

Exécution : Cliquez droit sur le fichier launch_script.bat et sélectionnez « Exécuter en tant qu'administrateur ».

Alternativement, ouvrez une invite PowerShell en tant qu'administrateur et exécutez :

Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
.\Windows11_PostInstall_Hardening_v2.ps1

Consultation des logs : Deux fichiers de log seront créés sur votre bureau pour le suivi des opérations effectuées :

PostInstallationLog.txt

resultat_final.txt

Remarques Importantes

Ce script est minimaliste et destiné principalement à une audience cherchant une solution rapide d'optimisation et de sécurisation de base.

Il n'est pas exhaustif : des configurations supplémentaires peuvent être nécessaires selon votre environnement.

Testez toujours ce type de script sur un poste de test avant de l'utiliser en production.

Auteur

Mous

Licence

Ce script est distribué librement. Vous êtes libre de l'utiliser, le modifier et le redistribuer, tout en respectant les bonnes pratiques de créditation.+
