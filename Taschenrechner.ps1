Add-Type -AssemblyName System.Windows.Forms

# Erstellt das Hauptfenster
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Taschenrechner"
$Form.Width = 300
$Form.Height = 400

# Erstellt das Anzeigefeld
$Display = New-Object System.Windows.Forms.TextBox
$Display.Location = New-Object System.Drawing.Point(10, 10)
$Display.Width = 270
$Display.Height = 50
$Display.ReadOnly = $true
$Display.Font = New-Object System.Drawing.Font("Calibri", 20)
$Form.Controls.Add($Display)

# Erstellt die Tasten
$Buttons = @()
$x = 10
$y = 70
$buttonWidth = 60
$buttonHeight = 60
$buttonValues = @('7', '8', '9', '/', '4', '5', '6', '*', '1', '2', '3', '-', '0', '.', '=', '+')

foreach ($buttonValue in $buttonValues) {
    $button = New-Object System.Windows.Forms.Button
    $button.Location = New-Object System.Drawing.Point($x, $y)
    $button.Width = $buttonWidth
    $button.Height = $buttonHeight
    $button.Text = $buttonValue
    $button.Font = New-Object System.Drawing.Font("Calibri", 20)
    $button.Add_Click({
        $Display.Text += $button.Text
    })
    $Buttons += $button
    $Form.Controls.Add($button)
    $x += $buttonWidth
    if ($x >= 250) {
        $x = 10
        $y += $buttonHeight
    }
}

# Erstellt die Funktion zum Berechnen des Ergebnisses
function Calculate() {
    $result = [System.Windows.Forms.SendKeys]::SendWait("$($Display.Text)={}")
    $Display.Text = $result.TrimEnd('=')
}

# Erstellt die Taste zum Berechnen des Ergebnisses
$EqualButton = $Buttons | Where-Object { $_.Text -eq '=' }
$EqualButton.Add_Click({
    Calculate
})

# Erstellt die Taste zum Löschen des Anzeigefeldes
$ClearButton = New-Object System.Windows.Forms.Button
$ClearButton.Location = New-Object System.Drawing.Point(10, 330)
$ClearButton.Width = 120
$ClearButton.Height = 50
$ClearButton.Text = "Clear"
$ClearButton.Font = New-Object System.Drawing.Font("Calibri", 20)
$ClearButton.Add_Click({
    $Display.Text = ""
})
$Form.Controls.Add($ClearButton)

# Zeigt das Hauptfenster an
$Form.ShowDialog() | Out-Null
