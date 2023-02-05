# script to check music directory for equivalent MP3 and WMA files!

Get-ChildItem -Path 'D:\Music' -Recurse |
   Foreach-Object {
     $fname = $_.BaseName
     $fdir  = $_.Directory
     $ftype = $_.Extension
     if ($ftype -eq ".wma") {
        $fcheck = "$fdir\$fname.mp3"
        $fdelete = "$fdir\$fname.wma"
        $fboth = "$fdir\$fname.*"
        if (Test-Path $fcheck -PathType Leaf) {
            # Found an MP3 equiv of the WMA file
                dir $fboth
                Remove-Item -Path $fdelete -Confirm
            }
        }

   }
