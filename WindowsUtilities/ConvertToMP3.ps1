# script to check music directory for any remaining WMA files, and convert to for equivalent MP3 and WMA files!


# Had to install VLC fromthe Windows store - and find where the executable was!

# Had to upgrade machine PIP 
# C:\Users\shaun\AppData\Local\Microsoft\WindowsApps\PythonSoftwareFoundation.Python.3.10_qbz5n2kfra8p0\python.exe -m pip install --upgrade pip

# Had to instal the MUTAGEN command to give the MID3CP command access
# pip install mutagen

# Had to install the ID3 module
# Install-Module -Name ID3


function ConvertToMp3(
	[switch] $inputObject,
	[string] $vlc = 'C:\Program Files\VideoLAN\VLC\vlc.exe')
{
	process {
		Write-Host $_
		$codec = 'mp3'
		$newFile = $_.FullName.Replace("'", "\'").Replace($_.Extension, ".$codec")
		&"$vlc" -I dummy "$_" ":sout=#transcode{acodec=$codec,vcodec=dummy}:standard{access=file,mux=raw,dst=`'$newFile`'}" vlc://quit | out-null

        # grab the tags from the WMA file
        $old_tags = mutagen-inspect $_
        $title = ""
        $author =""
        $genre = ""
        $album = ""
        $track = ""
        $tracknum = ""
        $composer = ""
        $year = ""
        $albumartist = ""

        foreach ($tag in $old_tags.GetEnumerator()) {
            if ($tag.Contains("=")) {
                $tag_pair = $tag.Split("=",2)
                $tag_lhs = $tag_pair[0]
                $tag_rhs = $tag_pair[1]
                switch ($tag_lhs) 
                {
                    "Title"                {$title = $tag_rhs}
                    "Author"               {$author = $tag_rhs}
                    "WM/Genre"             {$genre = $tag_rhs}
                    "WM/AlbumTitle"        {$album = $tag_rhs}
                    "WM/Track"             {$track = $tag_rhs}
                    "WM/TrackNumber"       {$tracknum = $tag_rhs}
                    "WM/Composer"          {$composer = $tag_rhs}
                    "WM/Year"              {$year = $tag_rhs}
                    "WM/AlbumArtist"       {$albumartist = $tag_rhs}
                }
            }
        }

        #update ID3 tags on target file
        $new_file = $_.FullName.Replace($_.Extension, ".$codec")
        if ($new_file.Contains("[")) {$new_file = $new_file.Replace("[","``[")}
        if ($new_file.Contains("]")) {$new_file = $new_file.Replace("]","``]")}
        
        $new_tags = @{"Title"="$title";"Year"="$year";"Genres"="$genre"; "Album"="$album"; "AlbumArtists"="$albumartist"; "Composers"="$composer"; "Artists"="$author"; "Track"="$tracknum"}
        try {
            set-id3tag $new_file @{"Title"="$title";"Year"="$year";"Genres"="$genre"; "Album"="$album"; "AlbumArtists"="$albumartist"; "Composers"="$composer"; "Artists"="$author"; "Track"="$tracknum"}
            }
        catch {
            write-host "ERROR: Had a problem with ID3TAGs on $new_file"
            exit 1
        }

		# Uncomment the next line when you're sure everything is working right
		#Remove-Item $_.FullName.Replace('[', '`[').Replace(']', '`]')
	}
}

function ConvertAllToMp3([string] $sourcePath) {
	Get-ChildItem "$sourcePath\*" -recurse -include *.wma| ConvertToMp3
}


ConvertAllToMp3 "D:\Music"


# D:\Music\A Ruffer Version- At King Tubby's 1974-1978\20 Blood Dunza Version [Alternate Mix].wma