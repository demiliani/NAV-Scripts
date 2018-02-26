$file = "C:\Users\stefano\OneDrive\CLIENTI\AMUT\Utenti\UTENTI-GRUPPI.xlsx"
$sheetName = "Foglio1"
$domain = "UNIVERS\" #Dominio utenti NAV
#Creazione istanza Excel.Application ed apertura file
$objExcel = New-Object -ComObject Excel.Application
$workbook = $objExcel.Workbooks.Open($file)
$sheet = $workbook.Worksheets.Item($sheetName)
$objExcel.Visible=$false
#Conteggio numero di righe
$rowMax = ($sheet.UsedRange.Rows).count
#Posizione di partenza dei dati da leggere
$rowUser,$colUser = 1,1

#Ciclo per recupero valori
for ($i=1; $i -le $rowMax-1; $i++)
{
    $userid = $domain + $sheet.Cells.Item($rowUser+$i,$colUser).text
    Write-Host ("Username: "+$userid)
    New-NavServerUser -WindowsAccount $userid -ServerInstance dynav
}
#Chiusura file
$objExcel.Quit()