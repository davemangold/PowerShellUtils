$digits = '0123456789'
$specials = '!#$&()*+-?~'
$letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

function Get-Password {

    Param(
        [Parameter(Mandatory=$false, HelpMessage="Password length", ParameterSetName="Length", Position=1)]
        [int]$length = 12
        )

    if($length -lt 8)
    {
        throw "Password must contain a minimum of 8 characters"
    }

    $array_digits = $digits.ToCharArray()
    $array_specials = $specials.ToCharArray()
    $array_letters = $letters.ToCharArray()

    $count_digits = [int][math]::floor($length / 4)
    $count_specials = [int][math]::floor($length / 4)

    $pw_digits = Get-Random -InputObject $array_digits -Count $count_digits
    $pw_specials = Get-Random -InputObject $array_specials -Count $count_specials
    $pw_letters = Get-Random -InputObject $array_letters -Count ($length - $count_digits - $count_specials)

    $password = -join ($pw_digits + $pw_specials + $pw_letters | Get-Random -Count $length | % {[char]$_})

    return $password

}

Export-ModuleMember -Function Get-Password
