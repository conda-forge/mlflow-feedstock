Set-PSDebug -Trace 1
$ErrorActionPreference = "Stop"

Get-ChildItem -Force | Where-Object { $_.LinkType -ne $null } | ForEach-Object {
    $link = $_
    $target = $link.Target

    if (-not (Test-Path $target)) {
        Write-Warning "Target for $($link.Name) does not exist: $target"
        return
    }

    Write-Host "[INFO] Replacing symlink '$($link.Name)' -> '$target'"

    # Remove the symlink
    Remove-Item $link.FullName -Force

    # Copy the target into place
    if (Test-Path $target -PathType Container) {
        Copy-Item $target -Destination $link.FullName -Recurse
    } else {
        Copy-Item $target -Destination $link.FullName
    }
}
