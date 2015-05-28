# Xojo-OpenLib

An open library of methods and functions for Xojo.

# Methods and Functions

- Function FileTextSave(pFolderItem as folderItem, pText as text) As text
- Function URLEncode(pText as text) As text
- Function URLShow(pURL As Text) As Boolean
- Sub MsgBoxAlert(pTitle as text, pMessage as text, pButton1Text as text)

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

# Suggestions

- Parameters should start with a 'p', but it's not required.
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