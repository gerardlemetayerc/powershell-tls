function Set-TlsNetFramework {
    param(
        [Parameter(Mandatory)]
        [ValidateSet("4.0.30319", "2.0.50727")]
        $version,
        [ValidateSet("64", "32", "*")]
        $proc = "*",
        $SchUseStrongCrypto,
        $SystemDefaultTlsVersions
    )
    if($proc -eq "32"){$_proc = 'HKLM:\SOFTWARE\Microsoft*' }
    elseif($proc -eq "64"){$_proc = 'HKLM:\SOFTWARE\WOW6432Node\Microsoft*'}
    else{$_proc = "*"}
    
    $registry = $TLSRegValues | Where-Object {$_.Path -like $_proc -and $_.Path -match $version}
    if($null -ne $SchUseStrongCrypto){
        if($SchUseStrongCrypto -eq $true){$SchUseStrongCrypto = 1}
        elseif($SchUseStrongCrypto -eq $false){$SchUseStrongCrypto = 0}
        if($SchUseStrongCrypto -in (0,1)){
             
            $currentValue = Show-TLSRegValues -regCollection $registry | Where-Object Name -eq SchUseStrongCrypto
            if($currentValue.value -in (0,1)){
                Set-ItemProperty -Path $currentValue.Path -Name SchUseStrongCrypto -Value $SchUseStrongCrypto
            }else{
                if(-not(Test-Path $registry.Path)){
                    New-Item -Path $registry.Path -Force | Out-Null
                }
                New-ItemProperty -Path $registry.Path -Name SchUseStrongCrypto -Value $SchUseStrongCrypto | Out-Null
            }
        }
    }

    if($null -ne $SystemDefaultTlsVersions){
        if($SystemDefaultTlsVersions -eq $true){$SystemDefaultTlsVersions = 1}
        elseif($SystemDefaultTlsVersions -eq $false){$SystemDefaultTlsVersions = 0}
        if($SystemDefaultTlsVersions -in (0,1)){
             
            $currentValue = Show-TLSRegValues -regCollection $registry | Where-Object Name -eq SchUseStrongCrypto
            if($currentValue.value -in (0,1)){
                Set-ItemProperty -Path $currentValue.Path -Name SystemDefaultTlsVersions -Value $SystemDefaultTlsVersions
            }else{
                if(-not(Test-Path $registry.Path)){
                    New-Item -Path $registry.Path -Force | Out-Null
                }
                New-ItemProperty -Path $registry.Path -Name SystemDefaultTlsVersions -Value $SystemDefaultTlsVersions | Out-Null
            }
        }
    }

}