<#
    Fill TODO-s in the code according to provided instructions.
    Each solution should be in a single line if not stated otherwise.

    This script should be executed from VSCode.
    PowerShell and VSCode should be installed in proper directories.
    First tests check those assumptions.
    If they fail, fix them first!
#>

$PowerShellExePath = 'C:\SO\PowerShell\pwsh.exe'
$VSCodeExePath = 'C:\SO\VSCode\code.exe'

Describe "PowerShell" {
    It "should run in PowerShell 7.3" {
        $Version = $PSVersionTable.PSVersion
        $Version | Should -BeLike "7.3.*"
    }
    It "should have binary in proper location" {
        Test-Path $PowerShellExePath | Should -Be $true
    }
}

Describe "VSCode" {
    It "should have binary in proper location" {
        Test-Path $VSCodeExePath | Should -Be $true
    }
}

Describe "Process" {
    Context "Get" {
        It "can get a list of all currently running processes" {
            # TODO: Get all processes and store them in an array
            $Processes = Get-Process
            # TODO: Check that there are more than 100 processes
            $Processes.Count | Should -BeGreaterThan 100
            # TODO: Check that each object in array is of System.Diagnostics.Process type
            $Processes | ForEach-Object { $_ | Should -BeOfType [System.Diagnostics.Process]}
        }
        It "can get 'pwsh' process by name and inspect it and its parent" {
            # TODO: Get current process using the process identifier
            $Process = Get-Process -Id $PID
            # TODO: Check that process idetifier is the same as in current shell
            $Process.Id | Should -Be $PID
            # TODO: Check process name
            $Process.Name | Should -Be 'pwsh'
            # TODO: Check process path (sould point to $PowerShellExePath)
            $Process.Path | Should -Be $PowerShellExePath
            # TODO: Check parent process name
            $Process.Parent.Name | Should -Be 'Code'
            # TODO: Check parent process path (sould point to $VSCodeExePath)
            $Process.Parent.Path | Should -Be $VSCodeExePath
        }
        It "can get multiple 'Code' processes and inspect master and child processes" {
            # TODO: Get all the instances of the 'Code' process and store them in an array
            $Processes = Get-Process -Name Code
            # TODO: Check that there are more than one process
            $Processes.Count | Should -BeGreaterThan 1
            # TODO: Get master process by checking the parent name is 'explorer' and store it in a variable
            $MasterProcess = $Processes | Where-Object { $_.Parent.Name -eq 'explorer' }
            # TODO: Check that there is only one master process
            $MasterProcess.Count | Should -Be 1
            # TODO: Get child processes by checking the parent name is not 'explorer' and store them in an array
            $ChildProcesses = $Processes | Where-Object { $_.Parent.Name -ne 'explorer' }
            # TODO: Check that there are N-1 child processes (N = number of 'Code' processes)
            $ChildProcesses.Count | Should -Be ($Processes.Count-1)
        }
    }
    Context "Start" {
        It "can start notepad to edit a file" {
            # TODO: Create a temporary file (see what command are available for TemporaryFile noun)
            $File = New-TemporaryFile
            # TODO: Start 'notepad' process, pass the path to file as argument and wiat for process to finish
            Start-Process notepad -ArgumentList $File -Wait
            # TODO: Check that user has enered the 'Hello!' string into the file (from notaped!)
            Get-Content $File | Should -Be "Hello!"
            # TODO: Remove the temporary file
            Remove-Item $File
        }
    }
    Context "Stop" {
        It "can start processes and them stop them" {
            # TODO: Create a script block that gets all notepad processes (and store the script block in a variable)
            $GetProcess = { Get-Process -Name notepad -ErrorAction SilentlyContinue }
            # TODO: Using the script block check that there no notepad processes currently running
            & $GetProcess | Should -Be $null
            # TODO: Create four notepad processes and store them in an array (in single line, use pipelines to do that)
            $Processes = 1..4 | ForEach-Object { Start-Process notepad -PassThru }
            # TODO: Wait for processes to start (max three lines of code)
            # HINT: Use while loop and in the condition use the script block to check that there are four processes
            # HINT: If processes are not yet started wait for a short period of time
            while ((& $GetProcess).Count -lt 4) {
                Start-Sleep -Milliseconds 100
            }
            # TODO: Wait for five seconds to see the notepads
            Start-Sleep -Seconds 5
            # TODO: Kill all the processes (use pipelines instead of loops or callng cmdlet for individual processes)
            $Processes | ForEach-Object { $_.Kill($true) }
            # TODO: Wait for processes to stop (max three lines of code)
            # HINT: Use while loop and in the condition use the script block to check that there are no processes
            # HINT: If processes are still running wait for a short period of time
            while ((& $GetProcess).Count -gt 0) {
                Start-Sleep -Milliseconds 100
            }
            # TODO: Using the script block check that there no notepad processes currently running
            & $GetProcess | Should -Be $null
        }
    }
}