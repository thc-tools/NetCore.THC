param (
    [Parameter(Mandatory=$true)]
    [string]$appName,
    
    [Parameter(Mandatory=$true)]
    [string]$index,
    
    [Parameter(Mandatory=$true)]
    [string]$businessName
)

$TextInfo = (Get-Culture).TextInfo
$baseBusinessName = $businessName.toLower()
$titleBusinessName = $TextInfo.ToTitleCase($businessName)
$titleAppName = $TextInfo.ToTitleCase($appName)

write-output "Generating business structure for application $titleAppName"
write-output "The business projects will be placed in $index-$businessName"

# Base folders names
$commonFoler = "00-common"
$dalFolder = "01-dal"
$businessFoler = "02-business"
$frontendFolder = "03-frontend"
$baseBusinessPath = "$businessFoler/$index-$baseBusinessName"

# Projects names
$modelProjectName = "$titleAppName.Model"
$contractProjectName = "$titleAppName.$titleBusinessName" + "Contract"
$impleProjectName = "$titleAppName.$titleBusinessName" + "Implementation"
$testProjectName = "$titleAppName.$titleBusinessName" + "Tests"

# Create projects
iex "dotnet new classlib -n $contractProjectName -o $baseBusinessPath/$contractProjectName"
iex "dotnet new classlib -n $impleProjectName -o $baseBusinessPath/$impleProjectName"
iex "dotnet new xunit -n $testProjectName -o $baseBusinessPath/$testProjectName"

# Link projects between them
iex "dotnet add $baseBusinessPath/$contractProjectName/$contractProjectName.csproj reference $dalFolder/$modelProjectName/$modelProjectName.csproj"

iex "dotnet add $baseBusinessPath/$impleProjectName/$impleProjectName.csproj reference $dalFolder/$modelProjectName/$modelProjectName.csproj"
iex "dotnet add $baseBusinessPath/$impleProjectName/$impleProjectName.csproj reference $baseBusinessPath/$contractProjectName/$contractProjectName.csproj"

iex "dotnet add $baseBusinessPath/$testProjectName/$testProjectName.csproj reference $baseBusinessPath/$impleProjectName/$impleProjectName.csproj"

# Add them to the solution
iex "dotnet sln add $baseBusinessPath/$contractProjectName"
iex "dotnet sln add $baseBusinessPath/$impleProjectName"
iex "dotnet sln add $baseBusinessPath/$testProjectName"