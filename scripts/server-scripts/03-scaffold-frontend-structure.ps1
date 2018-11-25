param (
    [Parameter(Mandatory=$true)]
    [string]$appName,

    [Parameter(Mandatory=$true)]
    [string]$frontendName
)

$TextInfo = (Get-Culture).TextInfo
$titleAppName = $TextInfo.ToTitleCase($appName)
$titlefrontendName = $TextInfo.ToTitleCase($frontendName) + "Frontend"

write-output "Generating frontend structure for application $titleAppName"

# Base folders names
$commonFoler = "00-common"
$dalFolder = "01-dal"
$businessFoler = "02-business"
$frontendFolder = "03-frontend"

# Projects names
$modelProjectName = "$titleAppName.Model"
$queriesProjectName = "$titleAppName.Queries"
$frontendProjectName = "$titleAppName.$titlefrontendName"
$referentielContractProjectName = "$titleAppName.ReferentielContract"
$referentielImplementationProjectName = "$titleAppName.ReferentielImplementation"

# Create projects
iex "dotnet new webapi -n $frontendProjectName -o $frontendFolder/$frontendProjectName"

# Link projects between them
iex "dotnet add $frontendFolder/$frontendProjectName/$frontendProjectName.csproj reference $dalFolder/$modelProjectName/$modelProjectName.csproj"
iex "dotnet add $frontendFolder/$frontendProjectName/$frontendProjectName.csproj reference $dalFolder/$queriesProjectName/$queriesProjectName.csproj"
iex "dotnet add $frontendFolder/$frontendProjectName/$frontendProjectName.csproj reference $businessFoler/01-referentiel/$referentielContractProjectName/$referentielContractProjectName.csproj"
iex "dotnet add $frontendFolder/$frontendProjectName/$frontendProjectName.csproj reference $businessFoler/01-referentiel/$referentielImplementationProjectName/$referentielImplementationProjectName.csproj"

# Add them to the solution
iex "dotnet sln add $frontendFolder/$frontendProjectName"