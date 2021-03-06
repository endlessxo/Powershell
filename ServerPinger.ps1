function Out-Excel
{
  param($Path = "$env:temp\$(Get-Date -Format yyyyMMddHHmmss).csv")
  $input | Export-CSV -Path $Path -UseCulture -Encoding UTF8 -NoTypeInformation
  Invoke-Item -Path $Path
}

function Ping-Server
{
    Test-Connection $args[0]
}

 #Get-Process | Where-Object { $_.MainWindowTitle } | Out-Excel
 
 $servers = "www.google.com", "www.yahoo.com", "www.ibm.com", "www.bostonunderwater.com" 
 $collection = $()
 foreach ($server in $servers)
 {
    $status = @{ "ServerName" = $server; "TimeStamp" = (Get-Date -f s) }
    if (Test-Connection $server -Count 1 -ea 0 -Quiet)
    {
        $status["Results"] = "Up"
    }
    else 
    {
        $status["Results"] = "Down"
    }
    New-Object -TypeName PSObject -Property $status -OutVariable serverStatus
    $collection += $serverStatus
 }
 $collection | Out-Excel
 
 #Ping-Server www.google.com | Out-Excel