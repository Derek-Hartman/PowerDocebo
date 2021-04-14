<#
.Synopsis
    Get All Courses from Docebo API.

.EXAMPLE
    Get-DoeboCourses -CompURL "verabradleyu" -Token "Token"

.NOTES
    Modified by: Derek Hartman
    Date: 4/14/2021

#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-DoceboCourses {
    [CmdletBinding()]

    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Companies URL.")]
        [string[]]$CompURL,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Docebo Token.")]
        [string[]]$Token

    )

    $Uri = @{
        "Courses" = "https://$CompURL.docebosaas.com/learn/v1/courses?page_size=99999"
    }

    $Header = @{
        'Authorization'   = "Bearer $Token"
        'Content-Type'  = 'application/json';
    }  

    $Courses = Invoke-RestMethod -Method GET -Uri $Uri.Courses -Headers $Header
    Write-Output $Courses.data.items
}