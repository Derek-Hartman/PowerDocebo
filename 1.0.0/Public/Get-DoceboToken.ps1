<#
.Synopsis
    Generates Token for Docebo API.

.EXAMPLE
    Get-DoeboToken -CompURL "verabradleyu" -ClientID "XXX" -ClientSecret "ClientSecret" -Username "Username" -Password "Password"

.NOTES
    Modified by: Derek Hartman
    Date: 4/14/2021

#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-DoceboToken {
    [CmdletBinding()]

    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Companies URL.")]
        [string[]]$CompURL,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your ClientID.")]
        [string[]]$ClientID,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your ClientSecret.")]
        [string[]]$ClientSecret,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Docebo Username.")]
        [string[]]$Username,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Docebo Password.")]
        [string[]]$Password

    )

    $Uri = @{
        "Token" = "https://$CompURL.docebosaas.com/oauth2/token"
    }

    $Body = @{'grant_type' = "password";} 
    $Body += @{'client_id'   = "$ClientID";}
    $Body += @{'client_secret'   = "$ClientSecret";}
    $Body += @{'scope'      = "api"}
    $Body += @{'username'      = "$Username"}
    $Body += @{'password'      = "$Password"}

    $JsonBody = ConvertTo-Json $Body

    $Header = @{
        'Content-Type'  = 'application/json';
    }

    $Token = Invoke-RestMethod -Method POST -Uri $Uri.Token -Body $JsonBody -Headers $Header

    Write-Output $Token.access_token
}