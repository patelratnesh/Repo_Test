Get-ADTrust -Filter * | Select-Object Direction , Name , ForestTransitive , ObjectClass ,  Source , Target | Export-Csv -path C:\adscripting\ADTrust\ActiveDirectoryTrust.csv -NoTypeInformation

#============================================================================




#> 

function Send-HTMLEmail {
#Requires -Version 2.0
[CmdletBinding()]
 Param 
   ([Parameter(Mandatory=$True,
               Position = 0,
               ValueFromPipeline=$true,
               ValueFromPipelineByPropertyName=$true,
               HelpMessage="Please enter the Inputobject")]
    $InputObject,
    [Parameter(Mandatory=$True,
               Position = 1,
               ValueFromPipeline=$true,
               ValueFromPipelineByPropertyName=$true,
               HelpMessage="Please enter the Subject")]
    [String]$Subject,    
    [Parameter(Mandatory=$False,
               Position = 2,
               HelpMessage="Please enter the To address")]    
    [String[]]$To = "Server.Alert.India@allscripts.com",
    [String]$From = "ADhealthCheck@allscripts.com",    
    [String]$CSS,
    [String]$SmtpServer ="intrelay.corp.allscripts.com"
   )#End Param

if (!$CSS)
{
    $CSS = @"
        <style type="text/css">
            table {
    	    font-family: Verdana;
    	    border-style: dashed;
    	    border-width: 1px;
    	    border-color: #FF6600;
    	    padding: 5px;
    	    background-color: #FFFFCC;
    	    table-layout: auto;
    	    text-align: center;
    	    font-size: 8pt;
            }

            table th {
    	    border-bottom-style: solid;
    	    border-bottom-width: 1px;
            font: bold
            }
            table td {
    	    border-top-style: solid;
    	    border-top-width: 1px;
            }
            .style1 {
            font-family: Courier New, Courier, monospace;
            font-weight:bold;
            font-size:small;
            }
            </style>
"@
}#End if

$HTMLDetails = @{
    Title = $Subject
    Head = $CSS
    }
    
$Splat = @{
    To         =$To
    Body       ="$($InputObject | ConvertTo-Html @HTMLDetails)"
    Subject    =$Subject
    SmtpServer =$SmtpServer
    From       =$From
    BodyAsHtml =$True
    }
    Send-MailMessage @Splat
    
}#Send-HTMLEmail

 Send-HtmlEmail -InputObject (Import-Csv -Path "C:\adscripting\ADTrust\ActiveDirectoryTrust.csv") -Subject "Monthly Corporate Domain Trust Validation Report"