
#Where the script says ENTER SOFTWARE HERE, enter the software you wish to uninstall. 
#Currently the -ArgumentList shows /qn (quiet uninstall) /norestart. Add or remove switches where necessary.
      $product = Get-WmiObject win32_product | where{$_.name -eq "ESET Endpoint Security"}
      $product.IdentifyingNumber
      Start-Process "C:\Windows\System32\msiexec.exe" `
      -ArgumentList "/x $($product.IdentifyingNumber) /qn /norestart" -Wait