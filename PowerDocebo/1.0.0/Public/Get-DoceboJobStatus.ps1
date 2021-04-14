<#
.Synopsis
    Get Latest Job Status

.EXAMPLE
    Get-DoeboJobStatus -CompURL "verabradleyu" -Token "Token" -AuthorID "AuthorID"

.NOTES
    Modified by: Derek Hartman
    Date: 4/14/2021

#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-DoceboJobStatus {
    [CmdletBinding()]

    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Companies URL.")]
        [string[]]$CompURL,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Docebo Token.")]
        [string[]]$Token,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Docebo Job Author ID.")]
        [string[]]$AuthorID

    )

    $Uri = @{
        "Manage" = "https://$CompURL.docebosaas.com/manage/v1/job?id_author=$AuthorID&page_size=1"
    }

    $Header = @{
        'Authorization'   = "Bearer $Token"
        'Content-Type'  = 'application/json';
    }  

    $Manage = Invoke-RestMethod -Method GET -Uri $Uri.Manage -Headers $Header
    Write-Output $Manage.data.jobs
}