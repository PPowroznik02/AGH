Describe "PowerShell" {
    It "should run in PowerShell 7.3" {
        $Version = $PSVersionTable.PSVersion
        $Version | Should -BeLike "7.3.*"
    }
}

Describe "Remoting" {
    BeforeAll {
        # TODO: Assign your user name to the $remoteUser variable
        $remoteUser = "Student"
    
        # TODO: Get credential for the $remoteUser and store it in $credential
        $credential = Get-Credential -UserName $remoteUser
    
        # TODO: Assign your remote host name to the $remoteHost variable
        $Script:remoteHost = "wsc.internal.cloudapp.net"
    
        # TODO: Create new session to $remoteHost using $credential and store it in $session
        $Script:session = New-PSSession -ComputerName $remoteHost -Credential $credential
    }
    Context "seession" {
        It "should not be null or empty" {
            # TODO: Check that session is created
            $session | Should -Not -BeNullOrEmpty
        }
        It "should be opened" {
            # TODO: Check that session is opened
            $session.State | Should -Be "Opened"
        }
        It "should be available" {
            # TODO: Check that session is available
            $session.Availability | Should -Be "Available"
        }
    }
    Context "invoke" {
        It "should get processes runing on remote machine" {
            # TODO: Get all processes runing on remote machine and store them in $processes variable
            $processes = Invoke-Command -Session $session { Get-Process }
            # TODO: Check that the number of processes in greater than zero
            $processes.Count | Should -BeGreaterThan 0
            # TODO: Check that each process computer name is set to $remoteHost
            $processes | ForEach-Object { $_.PSComputerName | Should -Be $remoteHost }
        }
    }
    AfterAll {
        # TODO: Delete the remote session
        Remove-PSSession $session
    }
}