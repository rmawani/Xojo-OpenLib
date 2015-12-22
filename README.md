# Xojo-OpenLib

An open library of methods and functions for Xojo.

If you'd like to submit code, make a request, report a bug, or offer better code simply create an issue as described below under Participate.

# Methods and Functions

![Xojo-OpenLib Methods](https://raw.github.com/campsoftware/Xojo-OpenLib/master/img/Xojo-OpenLib.png)

Miscellaneous
- Function DateDayofWeek(extends pDate as Date) As text
- **Function EmailAddressVerify(pEmailAddress as String, pNetworkCheck as Boolean = true) As string**
- Function FileTextSave(pFolderItem as folderItem, pText as text) As text
- Function FolderItemCopy(source as FolderItem, destination as FolderItem) As Boolean
- Function FolderItemDelete(theFolder as FolderItem, continueIfErrors as Boolean = false) As Integer
- Function Increment(Extends pInteger As Integer, pAmount As Integer = 1) As Integer
- Function IsEmpty(Extends pString As string) As Boolean
- Function IsEmpty(Extends pText As text) As Boolean
- Function IsNotEmpty(Extends pString As string) As Boolean
- Function IsNotEmpty(Extends pText As text) As Boolean
- Sub MsgBoxAlert(pTitle as text, pMessage as text, pButton1Text as text)
- Function PictureScale(extends Pic as picture, Width as integer, Height as Integer) As auto
- Function StringInstrRev(pInstring as string, pDelim as string) As Integer
- Function StringToText(extends theString as string) As text
- Function TextAsc(theText as text) As integer
- Function TextBytesFormatted(Bytes as Double) As text
- Function TextChr(pInteger as Integer) As text
- Function TextFilter(theText as text, theFilter as text) As text
- Function TextParse(pText as text, pTagStart as text, pTagEnd as text) As text
- Function TextQuoteDouble(Extends theText as Text) As Text
- Function TextQuoteSingle(Extends pText as Text) As Text
- Function TextRandomValue(Extends pText as text, pDelimiter as text) As text
- Function TextToDouble(extends theText as text) As double
- Function TextUUIDGenerate() As text
- Function TextUUIDValidate(s As text) As Boolean
- Function URLEncode(pText as text) As text
- Function URLShow(pURL As Text) As Boolean

**FM Functions - Have been removed as Paul Lefebvre has created 'FM', a FileMaker Library of Functions for Xojo: https://github.com/xojo/FM **

# Notes
- Almost every Method and Function have comments regarding who developed it, the source, and a calling example.
- Thanks to Kem Tekenay explaining 'signatures'! Each function that has an extends parameter can also be called using extends or like a regular method. Here's an example how  TextQuoteSingle can be called. 
```javascript
// Using Extends.
myText = myText.TextQuoteSingle
// Using as a normal method.
myText = TextQuoteSingle( myText )
```

# Getting Started

- Download Xojo from http://xojo.com/
- Download this project.
- Open the 'Xojo-OpenLib.xojo_project' file.
- Look at the xol module.

# Participate

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
