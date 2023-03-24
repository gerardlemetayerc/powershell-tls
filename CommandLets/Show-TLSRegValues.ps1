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
                If ($null -ne $value) {
                    $output.Value = $value.$name
                }
                $array += $output
            }
        }
    }
    return $array
}