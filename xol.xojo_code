#tag Module
Protected Module xol
	#tag Method, Flags = &h0
		Function FileTextSave(pFolderItem as folderItem, pText as text) As text
		  #IF TargetDesktop OR TargetWeb OR TargetConsole THEN
		    
		  #ELSEIF TargetiOS THEN
		    
		    Dim output As TextOutputStream
		    Try
		      output = TextOutputStream.Create( pFolderItem, TextEncoding.UTF8)
		      
		      output.WriteLine( pText )
		      
		      output.Close
		    Catch e As IOException
		      return "Error: Unable to create or write to file."
		    End Try
		    
		    return "OK"
		    
		  #ENDIF
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MsgBoxAlert(pTitle as text, pMessage as text, pButton1Text as text)
		  #IF TargetDesktop OR TargetWeb OR TargetConsole THEN
		    
		    MsgBox ( pTitle + ": " + pMessage )
		    
		  #ELSEIF TargetiOS THEN
		    
		    dim theMsgBox as new iOSMessageBox
		    theMsgBox.Title = pTitle
		    theMsgBox.Message = pMessage
		    Dim buttons() As Text
		    buttons.Append( pButton1Text )
		    theMsgBox.Buttons = buttons
		    theMsgBox.Show
		    
		  #ENDIF
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URLEncode(pText as text) As text
		  // Remove newline characters.
		  pText = pText.ReplaceAll ( &u0A, "" )
		  // Make substitutions...
		  pText = pText.ReplaceAll ( "%", "%25" )
		  pText = pText.ReplaceAll ( " ", "%20" )
		  pText = pText.ReplaceAll ( "!", "%21" )
		  pText = pText.ReplaceAll ( """", "%22" )
		  pText = pText.ReplaceAll ( "#", "%23" )
		  pText = pText.ReplaceAll ( "$", "%24" )
		  pText = pText.ReplaceAll ( "&", "%26" )
		  pText = pText.ReplaceAll ( "'", "%27" )
		  pText = pText.ReplaceAll ( "( ", "%28" )
		  pText = pText.ReplaceAll ( ")", "%29" )
		  pText = pText.ReplaceAll ( "*", "%2A" )
		  pText = pText.ReplaceAll ( "+", "%2B" )
		  pText = pText.ReplaceAll ( ",", "%2C" )
		  pText = pText.ReplaceAll ( "-", "%2D" )
		  pText = pText.ReplaceAll ( ".", "%2E" )
		  pText = pText.ReplaceAll ( "/", "%2F" )
		  pText = pText.ReplaceAll ( ":", "%3A" )
		  pText = pText.ReplaceAll ( ";", "%3B" )
		  pText = pText.ReplaceAll ( "<", "%3C" )
		  pText = pText.ReplaceAll ( "=", "%3D" )
		  pText = pText.ReplaceAll ( ">", "%3E" )
		  pText = pText.ReplaceAll ( "?", "%3F" )
		  pText = pText.ReplaceAll ( "@", "%40" )
		  pText = pText.ReplaceAll ( "[", "%5B" )
		  pText = pText.ReplaceAll ( "\\", "%5C" )
		  pText = pText.ReplaceAll ( "]", "%5D" )
		  pText = pText.ReplaceAll ( "^", "%5E" )
		  pText = pText.ReplaceAll ( "`", "%60" )
		  pText = pText.ReplaceAll ( "{", "%7B" )
		  pText = pText.ReplaceAll ( "|", "%7C" )
		  pText = pText.ReplaceAll ( "}", "%7D" )
		  return pText
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URLShow(pURL As Text) As Boolean
		  #IF TargetDesktop OR TargetWeb OR TargetConsole THEN
		    
		    ShowURL( pURL )
		    Return true  // doesn't return a value so assume true.
		    
		  #ENDIF
		  
		  // ==============================================
		  
		  #IF TargetiOS THEN
		    
		    // NSString* launchUrl = @"http://www.xojo.com/";
		    // [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
		    
		    Declare Function NSClassFromString Lib "Foundation" (name As CFStringRef) As Ptr
		    Declare Function sharedApplication Lib "UIKit" Selector "sharedApplication" (obj As Ptr) As Ptr
		    Dim sharedApp As Ptr = sharedApplication(NSClassFromString("UIApplication"))
		    
		    // https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSURL_Class/#//apple_ref/occ/clm/NSURL/URLWithString:
		    Declare Function URLWithString Lib "Foundation" Selector "URLWithString:" ( id As Ptr, URLString As CFStringRef ) As Ptr
		    Dim nsURL As Ptr = URLWithString(NSClassFromString("NSURL"), pURL )
		    
		    // https://developer.apple.com/Library/ios/documentation/UIKit/Reference/UIApplication_Class/index.html#//apple_ref/occ/instm/UIApplication/openURL:
		    Declare Function openURL Lib "UIKit" Selector "openURL:" (id As Ptr, nsurl As Ptr) As Boolean
		    Return openURL(sharedApp, nsURL)
		    
		  #ENDIF
		End Function
	#tag EndMethod


End Module
#tag EndModule
