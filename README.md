# Xojo-OpenLib

An open library of methods and functions for Xojo.

# Methods and Functions

Almost every Method and Function have comments regarding who developed it, the source, and a calling example.

Miscellaneous
- Function FileTextSave(pFolderItem as folderItem, pText as text) As text
- Sub MsgBoxAlert(pTitle as text, pMessage as text, pButton1Text as text)
- Function StringInstrRev(pInstring as string, pDelim as string) As Integer
- Function StringToText(extends theString as string) As text
- Function TextParse(pText as text, pTagStart as text, pTagEnd as text) As text
- Function TextQuoteSingle(Extends theText as Text) As Text
- Function TextRandomValue(pText as text, pDelimiter as text) As text
- Function TextToDouble(extends theText as text) As double
- Function TextUUIDGenerate() As text
- Function TextUUIDValidate(s As text) As Boolean
- Function URLEncode(pText as text) As text
- Function URLShow(pURL As Text) As Boolean

FM Functions - these are to make moving to Xojo from FileMaker a bit easier.
The list of functions is from Tim Dietrich http://fmwebframe.com/application/fm-to-php-translations.php 
which was originally developed by Jonathan Stark: http://jonathanstark.com
- Function fmAbs(theNum as double) As double
- Function fmCeiling(theNum as double) As double
- Function fmChar(pCodeNumber as Integer) As text
- Function fmCode(pChar as text) As integer
- Function fmDate(pMonth as integer, pDay as integer, pYear as integer) As xojo.core.Date
- Will add the functions listed the 'fmFunctions to Add' note over time.

# Getting Started

- Download Xojo from http://xojo.com/
- Download this project.
- Open the 'Xojo-OpenLib.xojo_project' file.
- Look at the xol module.

# Participate or Make a Request

If you'd like to submit code or make a request, create an issue:
- Click 'Issues' on the right hand side.
- Click 'New issue'.
- Choose a 'Label' on the right hand side.
- Enter a Title and a Comment. If you are submitting a method or function, right click it, choose copy, then paste it in the Comment box so we can add it to the library.
- Please include a comment header similar to this in your methods and functions.
- Try your best to follow the naming conventions. We may rename it to fit in better.
```javascript
// TextParse extracts text between the starting text tag and the ending text tag.
// Hal Gumbert, CampSoftware: http://www.CampSoftware.com 
//
// TextParse( pText as text, pTagStart as text, pTagEnd as text )
//
// Calling Example
// TextParse( "<name>Hal</name>", "<name>", "</name>" ) = Hal
// 
// Code
```

# Suggestions

- Parameters should start with a 'p' and variables with 'the', but it's not required.
- If the code won't work on all platforms, wrap the code for its target.

```javascript
#IF TargetiOS THEN
	Your Code Here
#ENDIF

or

#IF TargetDesktop OR TargetWeb OR TargetConsole THEN
	Your Code Here
#ENDIF
```
