# OS 2023 G2

To install Pester:
```
Install-Module -Name Pester -Force -SkipPublisherCheck -Scope CurrentUser
```

To install PSKoan:
```
Install-Module PSKoans -SkipPublisherCheck -Scope CurrentUser
```

To run PSKoan:
```
cd .\koan\
Set-PSKoanLocation $PWD
Show-Karma
```
