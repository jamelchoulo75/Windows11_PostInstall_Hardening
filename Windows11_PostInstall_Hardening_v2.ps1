# Nom de l'auteur
$author = "Mous"

# Fichiers de Log pour suivre les actions effectuées
$logPath = "$env:USERPROFILE\Desktop\PostInstallationLog.txt"
$finalLogPath = "$env:USERPROFILE\Desktop\resultat_final.txt"
$log = New-Object -TypeName System.IO.StreamWriter -ArgumentList $logPath, $false
$finalLog = New-Object -TypeName System.IO.StreamWriter -ArgumentList $finalLogPath, $false

$log.WriteLine("Post Installation Script - Windows 11")
$log.WriteLine("Auteur: $author")
$log.WriteLine("Date d'exécution: $(Get-Date)")
$finalLog.WriteLine("Post Installation Script - Windows 11")
$finalLog.WriteLine("Auteur: $author")
$finalLog.WriteLine("Date d'exécution: $(Get-Date)")

# Fonction pour loguer les événements et dans le fichier final
Function Log-Event {
    param (
        [string]$message
    )
    Write-Host $message
    $log.WriteLine("$message")
    $finalLog.WriteLine("$message")
}

# 1. Optimisation du Système
Log-Event "Optimisation du Système: Désactivation de l'hibernation et du démarrage rapide"
powercfg /hibernate off
powercfg -h off
Set-ExecutionPolicy RemoteSigned -Scope Process

Log-Event "Optimisation du Système: Configuration de la planification de l'alimentation"
powercfg /change standby-timeout-ac 30
powercfg /change monitor-timeout-ac 10

# 2. Sécurisation selon les recommandations CISA et ANSSI
Log-Event "Sécurisation: Activation de Secure Boot"
$SecureBoot = Confirm-SecureBootUEFI
If ($SecureBoot -eq $false) {
    Log-Event "Secure Boot n'est pas activé. Activation nécessaire dans le BIOS."
}

Log-Event "Sécurisation: Activation de TPM (Trusted Platform Module)"
$TPMStatus = Get-WmiObject -Namespace "Root\CIMv2\Security\MicrosoftTpm" -Class Win32_Tpm
If ($TPMStatus.TpmPresent -eq $false) {
    Log-Event "TPM n'est pas activé. Activation nécessaire dans le BIOS."
}

# 3. Désactivation des Protocoles Obsolètes
Log-Event "Désactivation de NetBIOS et LLMNR"
# Désactivation de NetBIOS via le registre pour plus de sécurité
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" -Name "EnableNetbios" -Value 0
# LLMNR désactivé par GPO, via les paramètres réseau
Set-NetIPInterface -InterfaceAlias "Ethernet" -Dhcp Disabled

# 4. Sécurisation de Windows Defender et activation des logs
Log-Event "Sécurisation de Windows Defender: Activation"
Set-MpPreference -DisableRealtimeMonitoring $false
Set-MpPreference -SubmitSamplesConsent 2
Set-MpPreference -ScanScheduleDay 0
Set-MpPreference -ScanScheduleTime 120

Log-Event "Activation des journaux détaillés pour Windows Defender"
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Logging" -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Logging" -Name "LogFileMaxSize" -Value 100
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Logging" -Name "LogFileLevel" -Value 3

# 5. Activation de l'UAC (Contrôle de Compte Utilisateur)
Log-Event "Activation de l'UAC (Contrôle de Compte Utilisateur)"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value 1

# 6. Protection contre l'exécution de scripts non signés
Log-Event "Activation de la protection contre les scripts non signés"
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine

# 7. Activation du pare-feu Windows
Log-Event "Activation du pare-feu Windows"
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True

# 8. Désactivation de la fonctionnalité de Remote Desktop (si non utilisée)
Log-Event "Limitation des connexions RDP aux utilisateurs autorisés"
Set-Service -Name "TermService" -StartupType Disabled
Stop-Service -Name "TermService"
# Correction du groupe local "Utilisateurs du Bureau à distance"
$group = Get-LocalGroup | Where-Object { $_.Name -eq "Utilisateurs du Bureau à distance" }
If ($group) {
    Add-LocalGroupMember -Group "Utilisateurs du Bureau à distance" -Member "Administrateurs"
} Else {
    Log-Event "Le groupe 'Utilisateurs du Bureau à distance' n'existe pas sur ce système."
}

# 9. Désactivation de la fonctionnalité de PowerShell Remoting
Log-Event "Désactivation de PowerShell Remoting"
Disable-PSRemoting -Force

# 10. Vérification des mises à jour automatiques
Log-Event "Vérification des mises à jour automatiques"
$wuauserv = Get-Service -Name wuauserv
If ($wuauserv.Status -ne 'Running') {
    Start-Service -Name wuauserv
    Log-Event "Les mises à jour automatiques ont été activées."
} Else {
    Log-Event "Les mises à jour automatiques sont déjà activées."
}

# 11. Activation de la fonctionnalité Windows Defender SmartScreen
Log-Event "Activation de Windows Defender SmartScreen"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "SmartScreenEnabled" -Value "Warn"

# 12. Désinstallation des logiciels inutiles
Log-Event "Désinstallation des logiciels inutiles"
# Désinstallation de Skype, Xbox, Solitaire, OneDrive et autres logiciels de Windows
$apps = @("Microsoft.XboxApp", "Microsoft.SkypeApp", "Microsoft.MicrosoftSolitaireCollection", "Microsoft.OneDrive", "Microsoft.ZuneMusic", "Microsoft.ZuneVideo", "Microsoft.3DBuilder", "Microsoft.MicrosoftOfficeHub")

foreach ($app in $apps) {
    Get-AppxPackage -Name $app | Remove-AppxPackage
    Log-Event "Désinstallation de $app"
}

# 13. Désactivation des tâches planifiées inutiles
Log-Event "Désactivation des tâches planifiées inutiles"
Get-ScheduledTask | Where-Object { $_.TaskName -like "*OneDrive*" } | Disable-ScheduledTask
Get-ScheduledTask | Where-Object { $_.TaskName -like "*Cortana*" } | Disable-ScheduledTask
Get-ScheduledTask | Where-Object { $_.TaskName -like "*Skype*" } | Disable-ScheduledTask

# 14. Journalisation et Fin du Script
Log-Event "Fin de l'exécution du script de post-installation."

# Fermeture des fichiers de log
$log.Close()
$finalLog.Close()
