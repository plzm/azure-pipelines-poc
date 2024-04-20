$moduleName = "plzm.Azure"
$localFolderPath = "./modules/$moduleName/"
$psm1FileName = "$moduleName.psm1"
$psd1FileName = "$moduleName.psd1"

function Get-PlzmAzureModule()
{
  [CmdletBinding()]
  param
  (
    [Parameter(Mandatory = $true)]
    [object]
    $UrlRoot
  )

  if (!(Test-Path -Path $localFolderPath))
  {
    New-Item -Path $localFolderPath -ItemType "Directory" -Force
  }

  # PSM1 file
  $url = ($UrlRoot + $psm1FileName)
  Invoke-WebRequest -Uri "$url" -OutFile ($localFolderPath + $psm1FileName)

  # PSD1 file
  $url = ($UrlRoot + $psd1FileName)
  Invoke-WebRequest -Uri "$url" -OutFile ($localFolderPath + $psd1FileName)

  return $localFolderPath
}

function Import-PlzmAzureModule()
{
  [CmdletBinding()]
  param
  (
  )
  Import-Module "$localFolderPath" -Force

  Write-Debug -Debug:$true -Message "Module $moduleName imported from $localFolderPath with version $((Get-Module $moduleName).Version)"
}