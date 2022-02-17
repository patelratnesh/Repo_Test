Function CheckDuplicateSPN
{
$StrRptFolder="C:\adscripting\ReportSPN"

#—- Using SetSpn.exe to check Duplicate SPN ———-

$SPNResult=Join-Path $strRptFolder “DuplicatesSPN.csv"
$spncmd=”setspn -X -f -p >$SPNResult” 
Invoke-Expression $spncmd

}

 #—– Call the function to execute the code —-

CheckDuplicateSPN




#============================



$smtpServer = "intrelay.corp.allscripts.com"
$smtpFrom = "ADhealthCheck@allscripts.com"
$smtpTo = "Server.Alert.India@allscripts.com"
$messageSubject = "Monthly Allscripts Forest  Duplicate SPN Report"
 
[string]$messagebody = ""
 
$logs = Get-Content C:\adscripting\ReportSPN\DuplicatesSPN.csv
 
foreach ($log in $logs )
{
	$messagebody = $messagebody + $log + "`r`n"
}
 
$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
$smtp.Send($smtpFrom,$smtpTo,$messagesubject,$messagebody)