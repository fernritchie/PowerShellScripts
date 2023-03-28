
#Enter the software name exactly
$softwareQuery = Read-Host 'What is the software you wish to query?'

#Selects the identifying number and versions number from the name entered
      $product = Get-WmiObject win32_product | where{$_.name -eq $softwareQuery}
      
      Write-Host "Your software version is: $($product.Version)"
      Write-Host "Your software GUID is:  $($product.IdentifyingNumber)"

#Asks if you would like to uninstall the software, uses the /qn and /norestart switch, change these where necessary

      $uninstallSoftware = Read-Host 'Would you like to uninstall this software? (Y or N)'

      if ( $uninstallSoftware -eq "Y" ) {

      Start-Process "C:\Windows\System32\msiexec.exe" `
      -ArgumentList "/x $($product.IdentifyingNumber) /qn /norestart" -Wait

      }

      else {
      Write-Host 'Have a nice day!'
      }