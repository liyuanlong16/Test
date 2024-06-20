Sub ProcessPostalCodes()
    Dim ws As Worksheet
    Set ws = ThisWorkbook.Sheets(1)

    Dim lastRow As Long
    lastRow = ws.Cells(ws.Rows.Count, "A").End(xlUp).Row

    Dim postalDict As Object
    Set postalDict = CreateObject("Scripting.Dictionary")

    Dim deleteCount As Long
    deleteCount = 0

    Dim i As Long
    For i = 2 To lastRow
        Dim postalCode As String
        postalCode = ws.Cells(i, 1).Value

        If Not postalDict.exists(postalCode) Then
            postalDict.Add postalCode, i
        Else
            Dim firstRow As Long
            firstRow = postalDict(postalCode)

            Dim firstC As String, firstD As String, firstF As String, firstG As String
            firstC = ws.Cells(firstRow, 3).Value
            firstD = ws.Cells(firstRow, 4).Value
            firstF = ws.Cells(firstRow, 6).Value
            firstG = ws.Cells(firstRow, 7).Value

            Dim currentC As String, currentD As String, currentF As String, currentG As String
            currentC = ws.Cells(i, 3).Value
            currentD = ws.Cells(i, 4).Value
            currentF = ws.Cells(i, 6).Value
            currentG = ws.Cells(i, 7).Value

            If firstC <> currentC Then
                ws.Cells(firstRow, 3).ClearContents
                ws.Cells(firstRow, 4).ClearContents
                ws.Cells(firstRow, 6).ClearContents
                ws.Cells(firstRow, 7).ClearContents
                ws.Rows(i).Delete
                i = i - 1
                lastRow = lastRow - 1
                deleteCount = deleteCount + 1
            ElseIf firstD <> currentD Then
                ws.Cells(firstRow, 4).ClearContents
                ws.Cells(firstRow, 7).ClearContents
                ws.Rows(i).Delete
                i = i - 1
                lastRow = lastRow - 1
                deleteCount = deleteCount + 1
            End If
        End If
    Next i

    MsgBox "deleted" & deleteCount & "deleted"
End Sub
