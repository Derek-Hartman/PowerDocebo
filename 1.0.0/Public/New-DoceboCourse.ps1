<#
.Synopsis
    Get All Courses from Docebo API.

.EXAMPLE
    New-DoeboCourse -CompURL "verabradleyu" -Token "Token" -Name "Test" -Code "T-TTTT" -Description "<p>test test</p>" -CourseType "elearning" -Language "english" -LanguageLabel "English" -Status "published" 

.NOTES
    Modified by: Derek Hartman
    Date: 4/14/2021

#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function New-DoceboCourse {
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
            HelpMessage = "Enter your Docebo Course Name.")]
        [string[]]$Name,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Docebo Course Code.")]
        [string[]]$Code,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Docebo Course Description.")]
        [string[]]$Description,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Docebo Course Type.")]
        [string[]]$CourseType,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Docebo Course Language.")]
        [string[]]$Language,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Docebo Course Language Label.")]
        [string[]]$LanguageLabel,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Docebo Course Status.")]
        [string[]]$Status

    )

    $Uri = @{
        "Courses" = "https://$CompURL.docebosaas.com/learn/v1/courses"
    }

    $Header = @{
        'Authorization'   = "Bearer $Token"
        'Content-Type'  = 'application/json';
    }
    
    $Body = @{"name" = "$Name"} 
    $Body += @{"code" = "$Code"}
    $Body += @{"description" = "$Description"}
    $Body += @{"course_type" = "$CourseType"}
    $Body += @{"selling" = "False"}
    $Body += @{"language" = "$Language"}
    $Body += @{"language_label" = "$LanguageLabel"}
    $Body += @{"price" = "0"}
    $Body += @{"is_new" = "0"}
    $Body += @{"is_opened" = "1"}
    $Body += @{"duration" = "0"}
    $Body += @{"status" = "$Status"}

    $postData = ConvertTo-Json $Body  

    $Courses = Invoke-RestMethod -Method POST -Uri $Uri.Courses -Body $postData -Headers $Header
    Write-Output $Courses.data.items
}