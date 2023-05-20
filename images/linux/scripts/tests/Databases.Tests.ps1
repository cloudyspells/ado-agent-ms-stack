Describe "MongoDB" -Skip:(Test-IsUbuntu22) {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "mongo" }
        @{ ToolName = "mongod" }
    ) {
        $toolsetVersion = (Get-ToolsetContent).mongodb.version
        (&$ToolName --version)[2].Split('"')[-2] | Should -BeLike "$toolsetVersion*"
    }
}

Describe "PostgreSQL" {
    It "PostgreSQL Service" {
        "sudo systemctl start postgresql" | Should -ReturnZeroExitCode
        "pg_isready" | Should -MatchCommandOutput "/var/run/postgresql:5432 - accepting connections"
        "sudo systemctl stop postgresql" | Should -ReturnZeroExitCode
    }

    It "PostgreSQL version should correspond to the version in the toolset" {
        $toolsetVersion = (Get-ToolsetContent).postgresql.version
        # Client version
        (psql --version).split()[-1] | Should -BeLike "$toolsetVersion*"
        # Server version
        (pg_config --version).split()[-1] | Should -BeLike "$toolsetVersion*"
    }
}
