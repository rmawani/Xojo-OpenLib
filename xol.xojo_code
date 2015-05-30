#tag Module
Protected Module xol
	#tag Method, Flags = &h0
		Function FileTextSave(pFolderItem as folderItem, pText as text) As text
		  
		  // FileTextSave saves text to a FolderItem.
		  // Hal Gumbert, CampSoftware: http://www.CampSoftware.com
		  //
		  // FileTextSave( pFolderItem as folderItem, pText as text )
		  //
		  // Call
		  // dim result as text
		  // result = FileTextSave( SpecialFolder.Documents.Child( "Xojo-OpenLib-FileTextSave.txt" ), FileTextSave_BeginTextArea.text.ToText )
		  // MsgBoxAlert( "Alert", "Look in your Documents folder for a 'Xojo-OpenLib-FileTextSave.txt' file. The Result was" + result, "OK" )
		  
		  
		  #IF TargetDesktop OR TargetWeb OR TargetConsole THEN
		    
		  #ENDIF
		  
		  #IF TargetiOS THEN
		    
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
		Function InstrRev(pInstring as string, pDelim as string) As Integer
		  // InstrRev is a reverse instr that returns the position of the last instance of a string within another string or zero if not found
		  // Peter Job, RetroPrograms http://slt.retroprograms.com/ , from others
		  //
		  //result = InstrRev(source, find)
		  // Call with a string to be searched and a string to be found:
		  // Dim i as integer
		  // i=InstrRev("abdefcdefg", "def") ' returns 7
		  
		  Dim i as integer
		  If instr(pInstring,pDelim) < 1 then
		    return 0
		  end if
		  For i=len(pInstring) downto 1
		    If instr(i,pInstring,pDelim) > 0 then
		      return instr(i,pInstring,pDelim)
		    end if
		  next
		  return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MsgBoxAlert(pTitle as text, pMessage as text, pButton1Text as text)
		  // MsgBoxAlert displays a dialog on Desktop and iOS.
		  // Hal Gumbert, CampSoftware: http://www.CampSoftware.com
		  //
		  // MsgBoxAlert( pTitle as text, pMessage as text, pButton1Text as text )
		  //
		  // Call
		  // dim result as text
		  // MsgBoxAlert( "Alert", "Hello World!", "OK" )
		  
		  
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
		Function TextParse(pText as text, pTagStart as text, pTagEnd as text) As text
		  
		  // TextParse extracts text between the starting text tag and the ending text tag.
		  // Hal Gumbert, CampSoftware: http://www.CampSoftware.com
		  //
		  // TextParse( pText as text, pTagStart as text, pTagEnd as text )
		  //
		  // Call with a known begin and end tags
		  // TextParse( "<name>Hal</name>", "<name>", "</name>" ) = Hal
		  //
		  // If you use an xml tag for the begin tag and leave the end tag empty, we assume that it's the closing xml tag. :)
		  // TextParse( "<name>Hal</name>", "<name>", "" ) = Hal
		  
		  Dim theCodeStart, theCodeEnd, theTagStartLen as integer
		  Dim theCode as string
		  
		  if pTagEnd = "" then
		    pTagEnd = replace( pTagStart, "<", "</" ).ToText
		  end if
		  
		  theTagStartLen = Len( pTagStart )
		  
		  theCodeStart = InStr ( pText, pTagStart )
		  if theCodeStart > 0 then
		    theCodeEnd = InStr ( theCodeStart + theTagStartLen, pText, pTagEnd )
		    if ( theCodeEnd > 0 ) and ( theCodeEnd > theCodeStart ) then
		      theCode = Mid ( pText, theCodeStart + theTagStartLen, theCodeEnd - theCodeStart - theTagStartLen )
		    end if
		  end if
		  
		  return theCode.ToText
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URLEncode(pText as text) As text
		  
		  // URLEncode encodes the text that will change illegal chars in a URL to a hexadecimal code.
		  // Tim Dietrich: http://www.timdietrich.me/
		  //
		  // URLEncode( pText as text )
		  //
		  // Call
		  // URLEncode( "Tim Dietrich") = Tim%20Dietrich
		  
		  
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
		  
		  // URLShow loads a url on the devices web browser.
		  // Hal Gumbert, CampSoftware: http://www.CampSoftware.com
		  //
		  // URLShow( pURL As Text )
		  //
		  // Call
		  // URLShow( "http://www.CampSoftware.com" )
		  
		  
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


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
