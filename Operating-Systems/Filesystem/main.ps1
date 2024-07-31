# References for this exercise:
# https://learn.microsoft.com/en-us/powershell/scripting/samples/working-with-files-and-folders?view=powershell-7.3
# https://github.com/jdhitsolutions/PSScriptTools

function ToDo ([string]$What, [Switch]$Done) {
    if ($Done -eq $true) {
        Write-Host "DONE: $What" -ForegroundColor Green
    }
    else {
        Write-Host "TODO: $What" -ForegroundColor Red
    }
}

$playground = ".\Playground"

ToDo -What "Print the playgornd location" -Done
Write-Host $playground

ToDo -What "Remove the playground entirely" -Done
Remove-Item -Path $playground -Recurse -Force -ErrorAction SilentlyContinue

ToDo -What "Create a new playground directory (quietly)" -Done
New-Item -Path $playground -ItemType Directory | Out-Null

ToDo -What "Push location into the playground" -Done
Push-Location $playground

ToDo -What "Create directories 'A', 'B', 'C' and 'D' (quietly)" -Done
New-Item -Path A -ItemType Directory | Out-Null
New-Item -Path B -ItemType Directory | Out-Null
New-Item -Path C -ItemType Directory | Out-Null
New-Item -Path D -ItemType Directory | Out-Null

ToDo -What "List newly created directories" -Done
Get-ChildItem

$file = "test.txt"

ToDo -What "Create a file named '$file'" -Done
New-Item -Path $file -ItemType File

ToDo -What "Write your name into the file" -Done
Add-Content -Path $file -Value "Damian"

ToDo -What "Write your surname into the file" -Done
Add-Content -Path $file -Value "Gwiżdż"

ToDo -What "Get the contentes of the file" -Done
Get-Content -Path $file

ToDo -What "Copy the file into each directory" -Done
Copy-Item -Path $file -Destination "A"
Copy-Item -Path $file -Destination "B"
Copy-Item -Path $file -Destination "C"
Copy-Item -Path $file -Destination "D"

ToDo -What "Remove the original file" -Done
Remove-Item -Path $file

ToDo -What "List the directories and files recursively as tree (using PSScriptTools)" -Done
Show-Tree -ShowItem

$archive = "archive.zip"

ToDo -What "Compress all directories into an archive named '$archive'" -Done
Compress-Archive -Path "A", "B", "C", "D" -Destination $archive

$expanded = ".\Expanded"

ToDo -What "Expand '$archive' in the 'expanded' irectory" -Done
Expand-Archive -Path $archive -DestinationPath $expanded

ToDo -What "Find all files named '$file' and print full name in a table" -Done
Get-Childitem -Include test.txt -File -Recurse | Select-Object FullName | Format-Table

ToDo -What "Pop location into the original location" -Done
Pop-Location