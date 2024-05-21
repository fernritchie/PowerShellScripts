# PowerShell Scripts

Various administrative PS scripts.

## Backup To C

This script can be run remotely. It will run as system admin, however it will pick up the currently logged in user and copy their data.
It will back up the data to the C drive.

Best use of this script is to back up a users data before moving it to a different profile (eg. Azure profile).

## Uninstall software remote

Edit this script and replace the software name and switches.

## Check Software GUID, prompt uninstall

This can be used to check version number, GUID and uninstall software when on the machine (not remotely).

## MFA Status Report

For this to work you must connect to MS Graph using: Connect-Graph -Scope “UserAuthenticationMethod.Read.All”
