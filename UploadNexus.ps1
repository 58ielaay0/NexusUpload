### Minimum powershell version required : 7.0 ###
param
(
    [Parameter(mandatory=$true)]
	[PSCredential] $Credential,
    [string] $NexusURL,
    [Parameter(mandatory=$true)]
	[string] $Repository,
    [Parameter(mandatory=$true)]
    [string] $RepositoryDirectory,
    [Parameter(mandatory=$true)]
    [string] $PackagePath
)


function Publish-Package
{
	param
    (
		[Parameter(mandatory=$true)]
		[PSCredential] $Credential,
        [string] $Package,
		[string] $RepositoryUrl,
		[string] $Directory="test"
    )
	
	Write-Host "Pushing <$Package> zip artifact to $RepositoryUrl..."
	
	$packageFilename = Read-Filename "$Package"

    $Form = @{
        'raw.directory' = $Directory
        'raw.asset1.filename' = "$packageFilename"
        'raw.asset1' = Get-Item -Path $Package
    }
	
	Invoke-RestMethod -Uri "$RepositoryUrl" -Method Post -Authentication Basic -Credential $Credential -Form $Form

    return $packageFilename
}

function Read-Filename
{
	param([string] $Path)
	return Split-Path $Path -leaf
}

####################
### Script Start ###
####################

$RepositoryURL = $NexusURL + '/service/rest/v1/components?repository=' + $Repository
Publish-Package -Package "$PackagePath" -RepositoryUrl "$RepositoryURL" -Directory "$RepositoryDirectory" -Credential $Credential