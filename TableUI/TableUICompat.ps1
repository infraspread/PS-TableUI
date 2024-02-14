#Requires -Version 6.0

# run in the same folder as tableui.psm1, it will output the module to TableUICompat.psm1

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

$replacementTableScript = @"
if (`$PSVersionTable.PSVersion.Major -lt 6) {
    # If it is, use ASCII characters
    `$charDot = '*'
    `$charEllipsis = '...'
    `$charHorizontalLine = '-'
    `$charVerticalLine = '|'
    `$charTopLeftCorner = '+'
    `$charTopRightCorner = '+'
    `$charBottomLeftCorner = '+'
    `$charBottomRightCorner = '+'
    `$charLeftTee = '+'
    `$charRightTee = '+'
    `$charTopTee = '+'
    `$charBottomTee = '+'
    `$charCross = '+'
    `$charDoubleVerticalLine = '|'
    `$charDoubleDownAndRight = '+'
    `$charDoubleUpAndRight = '+'
    `$charDoubleVerticalAndRight = '|'
} else {
    # If it's not, use the original ANSI characters
    `$charDot = '•'
    `$charEllipsis = '…'
    `$charHorizontalLine = '─'
    `$charVerticalLine = '│'
    `$charTopLeftCorner = '┌'
    `$charTopRightCorner = '┐'
    `$charBottomLeftCorner = '└'
    `$charBottomRightCorner = '┘'
    `$charLeftTee = '├'
    `$charRightTee = '┤'
    `$charTopTee = '┬'
    `$charBottomTee = '┴'
    `$charCross = '┼'
    `$charDoubleVerticalLine = '║'
    `$charDoubleDownAndRight = '╖'
    `$charDoubleUpAndRight = '╜'
    `$charDoubleVerticalAndRight = '╢'
}
"@

$scriptContent = Get-Content -Path ".\TableUI.psm1" -Raw
$modifiedScriptContent = Replace-AnsiWithVariables -InputString $scriptContent

# Prepend the replacement table to the modified script content
$finalScriptContent = $replacementTableScript + "`n" + $modifiedScriptContent

Set-Content -Path ".\TableUICompat.psm1" -Value $finalScriptContent
