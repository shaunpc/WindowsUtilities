<# :
:: MoveWindow - 
:: 
#>


# Expose the WIN32 explicit MoveWindow function
Add-Type @"
  using System;
  using System.Runtime.InteropServices;
  
  public class Win32 {
    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
  }
"@

# Grab the four parameters - no sanity checking!
$process = $args[0]
$X_Position = $args[1]
$Y_Position = $args[2]
$Width = $args[3]
$Height = $args[4]

write-host "$PID / Moving Window (PID:$process) to (x=$X_Position,y=$Y_Position) with width=$Width and height=$Height"

# Get the window handler for this process
$h = (Get-Process | where {$_.Id -eq $process}).MainWindowHandle

# Move the window accord to parameters passed
[Win32]::MoveWindow($h, $X_Position,$Y_Position,$Width,$Height, $true )