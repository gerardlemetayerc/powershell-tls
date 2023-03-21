$TLSRegValues = @()
$TLSRegValues += [PSCustomObject]@{
    "Path" = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319"
    "Keys" = @("SchUseStrongCrypto","SystemDefaultTlsVersions")
}
$TLSRegValues += [PSCustomObject]@{
    "Path" = "HKLM:\SOFTWARE\Microsoft\.NETFramework\v2.0.50727"
    "Keys" = @("SchUseStrongCrypto","SystemDefaultTlsVersions")
}
$TLSRegValues += [PSCustomObject]@{
    "Path" = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Server"
    "Keys" = @("Enabled","DisabledByDefault")
}
$TLSRegValues += [PSCustomObject]@{
    "Path" = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Client"
    "Keys" = @("Enabled","DisabledByDefault")
}
$TLSRegValues += [PSCustomObject]@{
    "Path" = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server"
    "Keys" = @("Enabled","DisabledByDefault")
}
$TLSRegValues += [PSCustomObject]@{
    "Path" = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client"
    "Keys" = @("Enabled","DisabledByDefault")
}
$TLSRegValues += [PSCustomObject]@{
    "Path" = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server"
    "Keys" = @("Enabled","DisabledByDefault")
}
$TLSRegValues += [PSCustomObject]@{
    "Path" = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client"
    "Keys" = @("Enabled","DisabledByDefault")
}
$TLSRegValues += [PSCustomObject]@{
    "Path" = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server"
    "Keys" = @("Enabled","DisabledByDefault")
}
$TLSRegValues += [PSCustomObject]@{
    "Path" = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client"
    "Keys" = @("Enabled","DisabledByDefault")
}

Function Show-TLSRegValues {
    [CmdletBinding()]
    Param
    (
        $regCollection = $TLSRegValues
    )
    $array = @()
    foreach($registry in $regCollection){
        if(Test-Path $registry.path){
            foreach($name in $registry.keys){
                $value = Get-ItemProperty -Path $registry.path -Name $name -ErrorAction Ignore
                $output = [PSCustomObject]@{
                    Path = $registry.path
                    Name = $name
                    value = "Not Found"
                }
                If ($value -ne $null) {
                    $output.Value = $value.$name
                }
                $array += $output
            }
        }
    }
    return $array
}


function Set-TLSSChannel
{
    param(
        [Parameter(Mandatory)]
        [ValidateSet("Client", "Server")]
        $scope = "client",
        [ValidateSet("1.0", "1.1", "1.2")]
        $version,
        $enabled,
        $DisabledByDefault,
        $force
    )

    if($enabled -ne $null){
        if($enabled -eq $true){$enabled = 1}
        elseif($enabled -eq $false){$enabled = 0}
        if($enabled -in (0,1)){
            $registry = $TLSRegValues | ? {$_.Path -match $scope -and $_.Path -match $version} 
            $currentValue = Show-TLSRegValues -regCollection $registry | ? Name -eq Enabled
            if($currentValue.value -in (0,1)){
                Set-ItemProperty -Path $currentValue.Path -Name Enabled -Value $enabled
            }else{
                if(-not(Test-Path $registry.Path)){
                    New-Item -Path $registry.Path -Force | Out-Null
                }
                New-ItemProperty -Path $registry.Path -Name Enabled -Value $enabled | Out-Null
            }
        }
        
    }

    if($DisabledByDefault  -ne $null){
        if($DisabledByDefault -eq $true){$DisabledByDefault = 1}
        elseif($DisabledByDefault -eq $false){$DisabledByDefault = 0}
        if($DisabledByDefault -in (0,1)){
            $registry = $TLSRegValues | ? {$_.Path -match $scope -and $_.Path -match $version} 
            $currentValue = Show-TLSRegValues -regCollection $registry | ? Name -eq DisabledByDefault
            if($currentValue.value -in (0,1)){
                Set-ItemProperty -Path $currentValue.Path -Name DisabledByDefault -Value $DisabledByDefault
            }else{
                if(-not(Test-Path $registry.Path)){
                    New-Item -Path $registry.Path -Force | Out-Null
                }
                New-ItemProperty -Path $registry.Path -Name DisabledByDefault -Value $DisabledByDefault | Out-Null
            }
        }
    }
}