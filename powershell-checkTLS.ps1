$TLSRegValues = @()
$TLSRegValues += [PSCustomObject]@{
    "Path" = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319"
    "Keys" = @("SchUseStrongCrypto","SystemDefaultTlsVersions")
}
$TLSRegValues += [PSCustomObject]@{
    "Path" = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v2.0.50727"
    "Keys" = @("SchUseStrongCrypto","SystemDefaultTlsVersions")
}
$TLSRegValues += [PSCustomObject]@{
    "Path" = "HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319"
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

Get-ChildItem "$($MyInvocation.PSScriptRoot)\CommandLets" | Foreach-Object {. $_.FullName}