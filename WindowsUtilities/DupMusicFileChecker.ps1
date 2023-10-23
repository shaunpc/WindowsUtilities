# script to check music directory for equivalent MP3 and WMA files!

Get-ChildItem -Path 'D:\Music' -Recurse |
   Foreach-Object {
     $ftype = $_.Extension

     if ($ftype -eq ".wma") {
            $dname = $_.DirectoryName
            if ($dname.Contains("[")) {$dname = $dname.Replace("[","``[")}
            if ($dname.Contains("]")) {$dname = $dname.Replace("]","``]")}
            $fname = $_.BaseName
            if ($fname.Contains("[")) {$fname = $fname.Replace("[","``[")}
            if ($fname.Contains("]")) {$fname = $fname.Replace("]","``]")}

            $fullname_both = $dname + "\" + $fname + ".*"
            $fullname_wma = $dname + "\" + $fname + ".wma"
            $fullname_mp3 = $dname + "\" + $fname + ".mp3"

            if (Test-Path $fullname_mp3 -PathType Leaf) {
                write-host "FOUND: $fullname_wma and $fullname_mp3"
                dir $fullname_both
                Remove-Item -Path $fullname_wma -Verbose
            }

     }
  }
