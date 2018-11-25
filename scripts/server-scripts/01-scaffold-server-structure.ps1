param (
    [Parameter(Mandatory=$true)]
    [string]$appName
)

$TextInfo = (Get-Culture).TextInfo
$titleAppName = $TextInfo.ToTitleCase($appName)

write-output "Generating business structure for application $titleAppName"

# Base folders names
$commonFoler = "00-common"
$dalFolder = "01-dal"
$businessFoler = "02-business"
$frontendFolder = "03-frontend"

# Projects names
$commonProjectName = "$titleAppName.Common"
$modelProjectName = "$titleAppName.Model"
$queriesProjectName = "$titleAppName.Queries"
$queriesTestsProjectName = "$titleAppName.QueriesTests"

# Create folder structure
write-output "Create folder $commonFoler"
md $commonFoler
write-output "Create folder $dalFolder"
md $dalFolder
write-output "Create folder $businessFoler"
md $businessFoler
write-output "Create folder $frontendFolder"
md $frontendFolder

# Make projects
iex "dotnet new classlib -n $commonProjectName -o $commonFoler/$commonProjectName"
iex "dotnet new classlib -n $modelProjectName -o $dalFolder/$modelProjectName"
iex "dotnet new classlib -n $queriesProjectName -o $dalFolder/$queriesProjectName"
iex "dotnet new classlib -n $queriesTestsProjectName -o $dalFolder/$queriesTestsProjectName"

# Link projetcs between them
iex "dotnet add $dalFolder/$modelProjectName/$modelProjectName.csproj reference $commonFoler/$commonProjectName/$commonProjectName.csproj"

iex "dotnet add $dalFolder/$queriesProjectName/$queriesProjectName.csproj reference $commonFoler/$commonProjectName/$commonProjectName.csproj"
iex "dotnet add $dalFolder/$queriesProjectName/$queriesProjectName.csproj reference $dalFolder/$modelProjectName/$modelProjectName.csproj"
iex "dotnet add $dalFolder/$queriesTestsProjectName/$queriesTestsProjectName.csproj reference $dalFolder/$queriesProjectName/$queriesProjectName.csproj"

# Create solution and add projets to it
iex "dotnet new sln -n $titleAppName"
iex "dotnet sln add $commonFoler/$commonProjectName"
iex "dotnet sln add $dalFolder/$modelProjectName"
iex "dotnet sln add $dalFolder/$queriesProjectName"
iex "dotnet sln add $dalFolder/$queriesTestsProjectName"

# Add default referentiel business project
iex "$PSScriptRoot/02-scaffold-business-structure.ps1 -appName $appName -index 01 -businessName referentiel"