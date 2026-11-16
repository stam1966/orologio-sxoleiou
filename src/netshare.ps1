# Κοινή χρήση του φακέλου «Σχολικές Εφαρμογές» στο δίκτυο (τρέχει με δικαιώματα διαχειριστή).
#   powershell -NoProfile -ExecutionPolicy Bypass -File netshare.ps1 -Path "<φάκελος>" -Out "<αποτέλεσμα.json>"
# Δημιουργεί κοινόχρηστο φάκελο (ASCII όνομα, π.χ. SxolikesEfarmoges), δίνει δικαίωμα αλλαγής στους
# πιστοποιημένους χρήστες (NTFS) και ενεργοποιεί τον κανόνα τείχους προστασίας «Κοινή χρήση αρχείων».
param([string]$Path, [string]$Name = 'SxolikesEfarmoges', [string]$Out)
$ErrorActionPreference = 'Stop'
$r = [ordered]@{ ok = $false }
try {
    $Path = (Get-Item -LiteralPath $Path).FullName.TrimEnd('\')
    $everyone = (New-Object Security.Principal.SecurityIdentifier 'S-1-1-0').Translate([Security.Principal.NTAccount]).Value
    $base = $Name; $i = 1
    while ($true) {
        $ex = Get-SmbShare -Name $Name -ErrorAction SilentlyContinue
        if (-not $ex -or $ex.Path.TrimEnd('\') -ieq $Path) { break }
        $i++; $Name = "$base$i"
    }
    if (-not $ex) {
        New-SmbShare -Name $Name -Path $Path -FullAccess $everyone -Description 'Sxolikes Efarmoges' | Out-Null
    } else {
        Grant-SmbShareAccess -Name $Name -AccountName $everyone -AccessRight Full -Force | Out-Null
    }
    & icacls.exe $Path /grant '*S-1-5-11:(OI)(CI)M' /T /C /Q | Out-Null
    try { Enable-NetFirewallRule -Group '@FirewallAPI.dll,-28502' -ErrorAction Stop } catch { $r.firewall = $_.Exception.Message }
    $r.public = @(Get-NetConnectionProfile -ErrorAction SilentlyContinue | Where-Object { $_.NetworkCategory -eq 'Public' } | ForEach-Object { $_.Name })
    $r.name = $Name
    $r.unc = '\\' + $env:COMPUTERNAME + '\' + $Name
    $r.ok = $true
} catch {
    $r.error = $_.Exception.Message
}
if ($Out) { [IO.File]::WriteAllText($Out, ($r | ConvertTo-Json -Compress), (New-Object Text.UTF8Encoding $false)) }
