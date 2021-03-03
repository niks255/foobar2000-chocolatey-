import-module au

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64\s*=\s*)('.*')"     = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest 'https://api.github.com/repos/AdguardTeam/AdGuardHome/tags' | ConvertFrom-Json
    $tag  = $download_page.Name -NotLike "beta" | Select -First 1

    @{
        URL32 = "https://github.com/AdguardTeam/AdGuardHome/releases/download/$tag/AdGuardHome_windows_386.zip"
        URL64 = "https://github.com/AdguardTeam/AdGuardHome/releases/download/$tag/AdGuardHome_windows_amd64.zip"
        Version = $tag -replace 'v'
    }
}

update