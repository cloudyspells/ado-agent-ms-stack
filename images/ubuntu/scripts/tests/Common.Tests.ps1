Describe "PHP" {
    $testCases = (Get-ToolsetContent).php.versions | ForEach-Object { @{PhpVersion = $_} }

    It "php <phpVersion>" -TestCases $testCases {
        "php${PhpVersion} --version" | Should -ReturnZeroExitCode
        "php-config${PhpVersion} --version" | Should -ReturnZeroExitCode
        "phpize${PhpVersion} --version" | Should -ReturnZeroExitCode
    }

    It "PHPUnit" {
        "phpunit --version" | Should -ReturnZeroExitCode
    }

    It "Composer" {
        "composer --version" | Should -ReturnZeroExitCode
    }

    It "Pear" {
        "pear" | Should -ReturnZeroExitCode
    }

    It "Pecl" {
        "pecl" | Should -ReturnZeroExitCode
    }
}

Describe "PipxPackages" {
    $testCases = (Get-ToolsetContent).pipx | ForEach-Object { @{package=$_.package; cmd = $_.cmd} }

    It "<package>" -TestCases $testCases {
        "$cmd --version" | Should -ReturnZeroExitCode
    }
}
