# Xojo-OpenLib

An open library of methods and functions for Xojo.

# Methods and Functions

Miscellaneous
- Function FileTextSave(pFolderItem as folderItem, pText as text) As text
- Function InstrRev(pInstring as string, pDelim as string) As Integer
- Sub MsgBoxAlert(pTitle as text, pMessage as text, pButton1Text as text)
- Function URLEncode(pText as text) As text
- Function URLShow(pURL As Text) As Boolean
- Sub MsgBoxAlert(pTitle as text, pMessage as text, pButton1Text as text)

FM Functions to make moving to Xojo from FileMaker a bit easier from Tim Dietrich http://fmwebframe.com/application/fm-to-php-translations.php 
which were originally developed by Jonathan Stark: http://jonathanstark.com
- Function fmAbs(theNum as double) As double
- Function fmCeiling(theNum as double) As double
- Will add the functions listed the project notes over time.

# Getting Started

- Download Xojo from http://xojo.com/
- Download this project.
- Open the 'Xojo-OpenLib.xojo_project' file.
- Look at the xol module.
- Run the project and try the 'Test' buttons.

# Participate or Make a Request

If you'd like to submit code or make a request, create an issue:
- Click 'Issues' on the right hand side.
- Click 'New issue'.
- Choose a 'Label' on the right hand side.
- Enter a Title and a Comment. If you are submitting a method or function, right click it, choose copy, then paste it in the Comment box so we can add it to the library.
- Please include a comment header similar to this in your methods and functions.
```javascript
// TextParse extracts text between the starting text tag and the ending text tag.
// Hal Gumbert, CampSoftware: http://www.CampSoftware.com 
//
// TextParse( pText as text, pTagStart as text, pTagEnd as text )
//
// Call with a known begin and end tags
// TextParse( "<name>Hal</name>", "<name>", "</name>" ) = Hal
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