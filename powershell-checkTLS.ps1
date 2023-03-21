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
