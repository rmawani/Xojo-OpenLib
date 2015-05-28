# Xojo-OpenLib
An open library of methods and functions for Xojo.

If you'd like to submit anything, we'd love to add it. 

- All methods, functions, etc must be prefixed with 'xol' to prevent name conflicts.
- Parameters should start with a 'p'.
- If the code won't work on all platforms, wrap the code for its target"
	```#IF TargetiOS THEN
		Your Code Here
	#ENDIF
	or
	#IF TargetDesktop OR TargetWeb OR TargetConsole THEN
		Your Code Here
	#ENDIF```