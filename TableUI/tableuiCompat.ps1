#Requires -Version 6.0

# run in the same folder as tableui.psm1

function Replace-AnsiWithVariables {
    param (
        [string]$InputString
    )

    $replacementTable = @{
        '•' = '$charDot'
        '…' = '$charEllipsis'
        '─' = '$charHorizontalLine'
        '│' = '$charVerticalLine'
        '┌' = '$charTopLeftCorner'
        '┐' = '$charTopRightCorner'
        '└' = '$charBottomLeftCorner'
        '┘' = '$charBottomRightCorner'
        '├' = '$charLeftTee'
        '┤' = '$charRightTee'
        '┬' = '$charTopTee'
        '┴' = '$charBottomTee'
        '┼' = '$charCross'
        '║' = '$charDoubleVerticalLine'
        '╖' = '$charDoubleDownAndRight'
        '╜' = '$charDoubleUpAndRight'
        '╢' = '$charDoubleVerticalAndRight'
    }

    $outputString = $InputString

    foreach ($key in $replacementTable.Keys) {
        $outputString = $outputString.Replace($key, $replacementTable[$key])
    }

    return $outputString
}
$scriptContent = Get-Content -Path "tableui.psm1" -Raw
$modifiedScriptContent = Replace-AnsiWithVariables -InputString $scriptContent
Set-Content -Path "tableuiCompat.psm1" -Value $modifiedScriptContent
