# script to check music directory for equivalent MP3 and WMA files!

Get-ChildItem -Path 'D:\Music' -Recurse |
   Foreach-Object {
     $ftype = $_.Extension

     if ($ftype -eq ".wma") {
        }

   }
   }
