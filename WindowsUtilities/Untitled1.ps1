
$excelfile = "C:\Users\shaun\OneDrive\Documents\Personal\Lucy-Flat-Income (NEW).xlsx"
$excelsheet = "CrownCube"
$objExcel=New-Object -ComObject Excel.Application
$objExcel.Visible=$True
$workbook=$objExcel.Workbooks.Open($excelfile)
$worksheet = $workbook.worksheets | where {$_.name -eq 'AnalysisMain'}
Write-Output "worksheet: $worksheet"
