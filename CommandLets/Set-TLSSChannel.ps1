function Set-TLSSChannel
{
    param(
        [Parameter(Mandatory)]
        [ValidateSet("Client", "Server")]
        $scope,
        [ValidateSet("1.0", "1.1", "1.2")]
        $version,
        $enabled,
        $DisabledByDefault,
        $force
    )

    if($null -ne $enabled){
        if($enabled -eq $true){$enabled = 1}
        elseif($enabled -eq $false){$enabled = 0}
        if($enabled -in (0,1)){
            $registry = $TLSRegValues | Where-Object {$_.Path -match $scope -and $_.Path -match $version} 
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

    if($null -ne $DisabledByDefault){
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