# Ctrl + d で Exit
Import-Module PSReadLine
Set-PSReadlineKeyHandler -Key ctrl+d -Function DeleteCharOrExit

# vi mode
Set-PSReadLineOption -EditMode Vi
# prompt vi
Copy-Item -Path function:prompt -Destination function:_OLD_VIRTUAL_PROMPT
Function global:prompt {
    Write-Host -NoNewLine -Separator "" "`e[48;2;105;176;255m`e[30m INSERT `e[0m"
    _OLD_VIRTUAL_PROMPT
}
function OnViModeChange {
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        function global:prompt {
            Write-Host -NoNewLine -Separator "" "`e[48;2;106;215;0m`e[30m NORMAL `e[0m"
            _OLD_VIRTUAL_PROMPT
        }
    }
    else {
        # Set the cursor to a blinking line.
        function global:prompt {
            Write-Host -NoNewLine -Separator "" "`e[48;2;105;176;255m`e[30m INSERT `e[0m"
            _OLD_VIRTUAL_PROMPT
        }
    }
    [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange
# vi insertmode keymap
# Set-PSReadLineKeyHandler -ViMode Insert -key "j,j" -Function ViCommandMode 
$j_timer = New-Object System.Diagnostics.Stopwatch
set-PSReadLineKeyHandler -Key j -ViMode Insert -ScriptBlock {

    if (!$j_timer.IsRunning -or $j_timer.ElapsedMilliseconds -gt 1000) {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert("j")
        $j_timer.Restart()
    }
    else {
        $line = $cursor = $null
        [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
        if ($line.Length -ne 0) {
            if ($line[-1] -eq 'j') {
                [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
                [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
                [Microsoft.PowerShell.PSConsoleReadLine]::Delete($cursor, 1)
                [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor - 1)
            }
            else {
                [Microsoft.PowerShell.PSConsoleReadLine]::Insert('j')
            }
        }
    }
}

# bash風のtab補完
Set-PSReadLineKeyHandler -Key Tab -Function Complete

# 補完
Import-Module posh-git
Import-Module posh-docker

# aliases
Set-Alias clr clear
