Import-Module 'C:\Program Files\Microsoft Dynamics NAV\100\Service\Microsoft.Dynamics.Nav.Management.dll'

$Logfile = "C:\TEMP\$(gc env:computername).log"

Function WriteLogFile
{
Param ([string]$logstring)

$Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
$logstring = $Stamp + ': ' + $logstring

Add-content $Logfile -value $logstring
}

workflow NAVJobSchedulingWF {  
    parallel {    
    	Invoke-NAVCodeunit navostp -CodeunitId 50001 -CompanyName 'EID' -ErrorAction Stop
	Invoke-NAVCodeunit navostp -CodeunitId 50002 -CompanyName 'EID' -ErrorAction Stop
        Invoke-NAVCodeunit navostp -CodeunitId 50003 -CompanyName 'EID' -ErrorAction Stop
             } 
  }

 

try
{

  NAVJobSchedulingWF 

}
catch [Exception]
{
  WriteLogFile "Error returned from NAV: $PSItem"
  Invoke-NAVCodeunit navostp -CodeunitId 50002 -CompanyName 'EID' -ErrorAction Stop
}