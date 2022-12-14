# This script will be used to run automatically usinng Intune. It will detect whether the current user
# is an allowed admin account and remove the admin privelages if it is not. It will then reboot the machine 
# to ensure that the user is unable to use their admin privelages.
#
# To add another admin account, we would need to add an array and loop through this to check.


# Sets execution policy as unrestricted for this session.
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force

# Gets the current user and stores in currentPrincipal variable.
$currentPrincipal = (Get-WMIObject -ClassName Win32_ComputerSystem).Username

# Admin account variable.
$yitadmin = "AzureAD\Yitadmin"

# If the current user does not equal Yitadmin, the administritave privelages will be revoked and the machine will restart.
if ($currentPrincipal -ne $yitadmin) {
 Remove-LocalGroupMember -Group 'Administrators' -Member (Get-WMIObject -ClassName Win32_ComputerSystem).Username
 Restart-Computer -Force
 Write-Output "User will be removed from the Administrator group. Device restarting."
}

else {
Write-Output "User is an approved admin account."
}
