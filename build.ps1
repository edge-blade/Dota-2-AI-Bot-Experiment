$rootDirectory = Get-Location;
$source = [string]$rootDirectory;
$dest = "$($rootDirectory)\output";

$includes = '*.lua'

$targets = Get-ChildItem $rootDirectory -File -Force -Filter '*.lua' | Select-Object FullName
ForEach( $file in $targets ) {
    $target = $file.FullName
    $fileDest = Join-Path $dest $target.Substring($source.length)
    
    New-Item -ItemType File -Path $fileDest -Force
    Copy-Item $target -Destination $fileDest -Force -Recurse
}

$targets = Get-ChildItem $source -Directory -Force |
    ? Name -NotMatch 'dev_and_plan|npc|references|.git|output|.vscode' |
        Get-ChildItem -File -Force -Filter $includes |
            select-Object FullName
ForEach( $file in $targets ) {
    $target = $file.FullName
    $fileDest = Join-Path $dest $target.Substring($source.length)
    New-Item -ItemType File -Path $fileDest -Force
    Copy-Item $target -Destination $fileDest -Force -Recurse
}


$license = "$source\LICENSE"
$licenseDest = Join-Path $dest $license.Substring($source.length)
New-Item -ItemType File -Path $licenseDest -Force
Copy-Item  $license -Destination $licenseDest -Force -Recurse