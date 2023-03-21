## Getting current param values
```
Show-TLSRegValues
``` 

## Define SChannel to disable TLS 1.0 and TLS 1.1 but not TLS 1.2
```
Set-TLSSChannel -scope Server -version 1.1 -enabled $false -DisabledByDefault $true
Set-TLSSChannel -scope Server -version 1.0 -enabled $false -DisabledByDefault $true
Set-TLSSChannel -scope Server -version 1.2 -enabled $true -DisabledByDefault $false
```
