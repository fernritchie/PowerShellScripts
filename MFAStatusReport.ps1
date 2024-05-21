<#
=============================================================================================
Name:           Get MFA Status Report
Description:    Gets MFA status for all users and authentication methods
Version:        1.0
Website:        activedirectorypro.com
Script by:      activedirectorypro.com
Instructions:   https://activedirectorypro.com/mfa-status-powershell

Updated by: Fern Ritchie
Description: Added test for directory and export to CSV
============================================================================================
#>

$directory = "C:\YITD\Audits"
if (-not (Test-Path -Path $directory)) {
    New-Item -ItemType Directory -Path $directory
}

#Get all Azure users
$users = Get-MgUser -All

$results = @()
Write-Host "`nRetrieved $($users.Count) users"

# Loop through each user account
foreach ($user in $users) {

    Write-Host "`n$($user.UserPrincipalName)"
    $myObject = [PSCustomObject]@{
        user            = "-"
        MFAstatus       = "_"
        email           = "-"
        fido2           = "-"
        app             = "-"
        password        = "-"
        phone           = "-"
        softwareoath    = "-"
        tempaccess      = "-"
        hellobusiness   = "-"
    }

    $MFAData = Get-MgUserAuthenticationMethod -UserId $user.UserPrincipalName #-ErrorAction SilentlyContinue

    $myObject.user = $user.UserPrincipalName
    # Check authentication methods for each user
    ForEach ($method in $MFAData) {
        Switch ($method.AdditionalProperties["@odata.type"]) {
            "#microsoft.graph.emailAuthenticationMethod" { 
                $myObject.email = $true 
                $myObject.MFAstatus = "Enabled"
            }
            "#microsoft.graph.fido2AuthenticationMethod" { 
                $myObject.fido2 = $true 
                $myObject.MFAstatus = "Enabled"
            }
            "#microsoft.graph.microsoftAuthenticatorAuthenticationMethod" { 
                $myObject.app = $true 
                $myObject.MFAstatus = "Enabled"
            }
            "#microsoft.graph.passwordAuthenticationMethod" {
                $myObject.password = $true 
                # When only the password is set, then MFA is disabled.
                if ($myObject.MFAstatus -ne "Enabled") {
                    $myObject.MFAstatus = "Disabled"
                }
            }
            "#microsoft.graph.phoneAuthenticationMethod" { 
                $myObject.phone = $true 
                $myObject.MFAstatus = "Enabled"
            }
            "#microsoft.graph.softwareOathAuthenticationMethod" { 
                $myObject.softwareoath = $true 
                $myObject.MFAstatus = "Enabled"
            }
            "#microsoft.graph.temporaryAccessPassAuthenticationMethod" { 
                $myObject.tempaccess = $true 
                $myObject.MFAstatus = "Enabled"
            }
            "#microsoft.graph.windowsHelloForBusinessAuthenticationMethod" { 
                $myObject.hellobusiness = $true 
                $myObject.MFAstatus = "Enabled"
            }
        }
    }

    # Collecting objects
    $results += $myObject
}

# Export the custom objects to CSV
# $results | Export-Csv -Path "C:\YITD\Audits\MFAStatusReport.csv" -NoTypeInformation

# Display the custom objects (optional)
$results
