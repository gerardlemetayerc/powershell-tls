## Getting current param values
```
Show-TLSRegValues
``` 

## Define SChannel to disable TLS 1.0, 1.1 but not 1.2
```
Set-TLSSChannel -scope Server -version 1.1 -enabled $false -DisabledByDefault $true
Set-TLSSChannel -scope Server -version 1.0 -enabled $false -DisabledByDefault $true
Set-TLSSChannel -scope Server -version 1.2 -enabled $true -DisabledByDefault $false
```

## Use cases

#### ADFS with Azure MFA, enforcing TLS 1.2
```
Set-TlsNetFramework -version '4.0.30319' -proc * -SchUseStrongCrypto 1 -SystemDefaultTlsVersions 1
Set-TlsNetFramework -version '2.0.50727' -proc * -SchUseStrongCrypto 1 -SystemDefaultTlsVersions 1
Set-TLSSChannel -scope Server -version 1.2 -enabled $true -DisabledByDefault $false
```