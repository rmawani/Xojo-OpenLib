#tag Module
Protected Module xol
	#tag Method, Flags = &h0
		Function DateDayofWeek(pDate as Date) As text
		  return pDate.DateDayofWeek
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DateDayofWeek(extends pDate as Date) As text
		  // DateDayofWeek
		  // Unknown Origin
		  
		  Select Case pDate.DayOfWeek
		  Case 1
		    return "Sunday"
		  Case 2
		    return "Monday"
		  Case 3
		    return "Tuesday"
		  Case 4
		    return "Wednesday"
		  Case 5
		    return "Thursday"
		  Case 6
		    return "Friday"
		  Case 7
		    return "Saturday"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FileTextSave(pFolderItem as folderItem, pText as text) As text
		  // FileTextSave saves text to a FolderItem.
		  // Hal Gumbert, CampSoftware: http://www.CampSoftware.com
		  //
		  // Function FileTextSave(pFolderItem as folderItem, pText as text) As text
		  //
		  // Calling Example
		  
		  'dim result as text
		  'result = FileTextSave( SpecialFolder.Documents.Child( "Xojo-OpenLib-FileTextSave.txt" ), FileTextSave_BeginTextArea.text.ToText )
		  'MsgBoxAlert( "Alert", "Look in your Documents folder for a 'Xojo-OpenLib-FileTextSave.txt' file. The Result was" + result, "OK" )
		  
		  // Code
		  
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
		Function fmAbs(pNum as double) As double
		  'fmAbs
		  'Returns the absolute value of number.
		  'Example: fmAbs ( -5.2 ) = 5.2
		  
		  return abs(  pNum )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function fmCeiling(pNum as double) As double
		  'fmCeiling
		  'Returns number rounded up to the next integer.
		  'Example: fmCeiling ( -5.2 ) = -5
		  
		  return ceil( pNum )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function fmChar(pCodeNumber as Integer) As text
		  'fmChar
		  'Returns the characters for the Unicode code points in the number.
		  'Example: fmChar ( 98 ) = b
		  
		  return Text.FromUnicodeCodepoint( pCodeNumber )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function fmCode(pChar as text) As integer
		  'fmCode
		  'Returns the Unicode code points for the characters in the text.
		  'Example: fmCode ( 'b' ) = 98
		  
		  For Each codePoint As UInt32 In pChar.Codepoints
		    return codePoint
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function fmDate(pMonth as integer, pDay as integer, pYear as integer) As xojo.core.Date
		  'fmDate
		  'Returns the calendar date for month, day, and year.
		  'Example: fmDate ( 11, 27, 1968 ) = 11/27/1968
		  
		  dim theDate as xojo.core.Date
		  
		  if pMonth > 0 and pDay > 0 and pYear > 0 then
		    theDate = xojo.core.date.fromtext( pYear.ToText + "-" + pMonth.ToText + "-" + pDay.ToText )
		  else
		    theDate = Xojo.Core.Date.Now
		  end if
		  
		  Return theDate
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FolderItemCopy(source as FolderItem, destination as FolderItem) As Boolean
		  // From http://docs.xojo.com/index.php/FolderItem
		  
		  Dim newFolder As FolderItem
		  If source.Directory then //it's a folder
		    newFolder = destination.Child(source.Name)
		    newFolder.CreateAsFolder
		    if not newFolder.Exists or not newFolder.Directory Then
		      // folder was not created - abort
		      Return False
		    End If
		    For i As Integer = 1 To source.Count //go through each item
		      Dim sourceItem as FolderItem = source.TrueItem(i)
		      If sourceItem = nil Then
		        // inaccessible
		        Return False
		      End If
		      If not folderItemCopy (sourceItem, newFolder) Then
		        //copy operation failed
		        Return False
		      End If
		    Next
		  Else //it's not a folder
		    source.CopyFileTo destination
		    If source.LastErrorCode <> 0 Then
		      Return False
		    End If
		  End if
		  
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FolderItemDelete(theFolder as FolderItem, continueIfErrors as Boolean = false) As Integer
		  // From: http://docs.xojo.com/index.php/FolderItem.Delete
		  
		  // Returns an error code if it fails, or zero if the folder was deleted successfully
		  
		  dim returnCode, lastErr, itemCount as integer
		  dim files(), dirs() as FolderItem
		  
		  if theFolder = nil or not theFolder.Exists() then
		    return 0
		  end if
		  
		  // Collect the folder‘s contents first.
		  // This is faster than collecting them in reverse order and deleting them right away!
		  itemCount = theFolder.Count
		  for i as integer = 1 to itemCount
		    dim f as FolderItem
		    f = theFolder.TrueItem( i )
		    if f <> nil then
		      if f.Directory then
		        dirs.Append f
		      else
		        files.Append f
		      end if
		    end if
		  next
		  
		  // Now delete the files
		  for each f as FolderItem in files
		    f.Delete
		    lastErr = f.LastErrorCode   // Check if an error occurred
		    if lastErr <> 0 then
		      if continueIfErrors then
		        if returnCode = 0 then returnCode = lastErr
		      else
		        // Return the error code if any. This will cancel the deletion.
		        return lastErr
		      end if
		    end if
		  next
		  
		  redim files(-1) // free the memory used by the files array before we enter recursion
		  
		  // Now delete the directories
		  for each f as FolderItem in dirs
		    lastErr = folderItemDelete( f, continueIfErrors )
		    if lastErr <> 0 then
		      if continueIfErrors then
		        if returnCode = 0 then returnCode = lastErr
		      else
		        // Return the error code if any. This will cancel the deletion.
		        return lastErr
		      end if
		    end if
		  next
		  
		  if returnCode = 0 then
		    // We‘re done without error, so the folder should be empty and we can delete it.
		    theFolder.Delete
		    returnCode = theFolder.LastErrorCode
		  end if
		  
		  return returnCode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Increment(Extends pInteger As Integer, pAmount As Integer = 1) As Integer
		  // Increment
		  // Unknown Origin
		  
		  return pInteger + pAmount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Increment(pInteger As Integer, pAmount As Integer = 1) As Integer
		  return pInteger.Increment
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsEmpty(Extends pString As string) As Boolean
		  If pString = "" Then
		    Return True
		  Else
		    Return False
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsEmpty(Extends pText As text) As Boolean
		  If pText = "" Then
		    Return True
		  Else
		    Return False
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsEmpty(pString As string) As Boolean
		  return pString.IsEmpty
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsEmpty(pText As text) As Boolean
		  return pText.IsEmpty
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsNotEmpty(Extends pString As string) As Boolean
		  If pString = "" Then
		    Return False
		  Else
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsNotEmpty(Extends pText As text) As Boolean
		  If pText = "" Then
		    Return False
		  Else
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsNotEmpty(pString As string) As Boolean
		  return pString.IsNotEmpty
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsNotEmpty(pText As text) As Boolean
		  return pText.IsNotEmpty
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MsgBoxAlert(pTitle as text, pMessage as text, pButton1Text as text)
		  // MsgBoxAlert displays a dialog on Desktop and iOS.
		  // Hal Gumbert, CampSoftware: http://www.CampSoftware.com
		  //
		  // Sub MsgBoxAlert(pTitle as text, pMessage as text, pButton1Text as text)
		  //
		  // Calling Example
		  
		  'dim result as text
		  'MsgBoxAlert( "Alert", "Hello World!", "OK" )
		  
		  // Code
		  
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
		Function PictureScale(extends Pic as picture, Width as integer, Height as Integer) As auto
		  // PictureScale
		  // Unknown Origin
		  
		  #IF TargetDesktop OR TargetWeb OR TargetConsole THEN
		    
		    'To use it, load your image into a new picture, then assign it to your
		    'webimageviewer control like this (assuming wp is the control and pic is the
		    'picture):
		    '
		    'wp.Picture = pic.ImageScale( wp.Width, wp.Height )
		    
		    
		    // Calculate scale factor
		    dim factor as Double = min( Height / Pic.Height, Width / Pic.Width)
		    
		    // Calculate new size
		    dim w as integer = Pic.Width * factor
		    dim h as integer = Pic.Height * factor
		    
		    // create new picture
		    dim NewPic as new Picture(w,h,32)
		    NewPic.Transparent = 1
		    
		    // draw picture in the new size
		    NewPic.Graphics.DrawPicture( Pic, 0, 0, w, h, 0, 0, Pic.Width, Pic.Height )
		    
		    // return result
		    Return NewPic
		    
		  #ELSEIF TargetiOS THEN
		    
		  #ENDIF
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringInstrRev(extends pInstring as string, pDelim as string) As Integer
		  // InstrRev is a reverse instr that returns the position of the last instance of a string within another string or zero if not found
		  // Peter Job, RetroPrograms http://slt.retroprograms.com/ , from others
		  //
		  // Function StringInstrRev(pInstring as string, pDelim as string) As Integer
		  //
		  // Call with a string to be searched and a string to be found
		  // result = InstrRev(source, find)
		  //
		  // Calling Example
		  
		  'Dim i as integer
		  'i = StringInstrRev( "abdefcdefg", "def" ) ' returns 7
		  
		  // Code
		  
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
		Function StringInstrRev(pInstring as string, pDelim as string) As Integer
		  return pInstring.StringInstrRev( pDelim )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringToText(extends theString as string) As text
		  // StringToText converts a string to text.
		  // Hal Gumbert, CampSoftware: http://www.CampSoftware.com
		  //
		  // Function StringToText(theString as string) As text
		  //
		  // Calling Example
		  
		  'dim theString as string = "Hal"
		  'dim theText as text
		  'theText = theString.StringToText
		  
		  // Code
		  
		  theString = theString.DefineEncoding( Encodings.UTF8 )
		  Return theString.ToText
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringToText(theString as string) As text
		  Return theString.StringToText
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextAsc(theText as text) As integer
		  // TextAsc
		  // Unknown Origin
		  
		  For Each codePoint As UInt32 In theText.Codepoints
		    
		    // return the first asc code
		    return codePoint
		    
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextBytesFormatted(Bytes as Double) As text
		  // TextBytesFormatted
		  // Unknown Origin
		  
		  // Code
		  
		  #IF TargetDesktop OR TargetWeb OR TargetConsole THEN
		    
		    dim theSize as string
		    
		    Select Case Bytes
		      
		    Case is < pow ( 1024 , 1 )
		      theSize = Format ( Bytes , theFormatFileSize ) + " Bytes"
		      
		    Case is < pow ( 1024 , 2 )
		      theSize = Format ( Bytes / pow ( 1024 , 1 ) , theFormatFileSize ) + " KB"
		      
		    Case is < pow ( 1024 , 3 )
		      theSize = Format ( Bytes / pow ( 1024 , 2 ) , theFormatFileSize ) + " MB"
		      
		    Case is < pow ( 1024 , 4 )
		      theSize = Format ( Bytes / pow ( 1024 , 3 ) , theFormatFileSize ) + " GB"
		      
		    Case is < pow ( 1024 , 5 )
		      theSize = Format ( Bytes / pow ( 1024 , 4 ) , theFormatFileSize ) + " TB"
		      
		    End Select
		    
		    return theSize.ToText
		    
		  #ELSEIF TargetiOS THEN
		    
		  #ENDIF
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextChr(pInteger as Integer) As text
		  // TextChr
		  // Unknown Origin
		  
		  return Text.FromUnicodeCodepoint( pInteger )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextFilter(theText as text, theFilter as text) As text
		  // TextFilter
		  // Unknown Origin
		  
		  #IF TargetDesktop OR TargetWeb OR TargetConsole THEN
		    
		    // Returns from theText only those characters specified in theFilter, in the order they were originally entered in theText.
		    //
		    // textFilter( theText as text, theFilter as text ) as text
		    //
		    // textFilter ( "(407) 555-1212", "0123456789"  ) = 4075551212
		    
		    dim theChar, outputText as string
		    dim i as integer = 0
		    
		    do until i > len( theText )
		      
		      i = i + 1
		      theChar = mid( theText, i, 1 )
		      
		      if InStr( theFilter, theChar ) > 0 then
		        outputText = outputText + theChar  // Found theChar so include it for output
		      end if
		      
		    loop
		    
		    return outputText.ToText
		    
		  #ELSEIF TargetiOS THEN
		    
		  #ENDIF
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextParse(extends pText as text, pTagBegin as text, pTagEnd as text, pOccurrence as integer = 1) As text
		  // TextParse extracts text between the starting text tag and the ending text tag for a specific occurrence.
		  // Hal Gumbert, CampSoftware: http://www.CampSoftware.com
		  //
		  // TextParse( pText as text, pTagStart as text, pTagEnd as text )
		  
		  // Call with a known begin and end tags
		  // TextParse( "<name>Lewis</name><name>Nico</name><name>Sebastian</name>", "<name>", "</name>", 3 ) = Sebastian
		  //
		  // If you use an xml tag for the begin tag and leave the end tag empty, we assume that it's the closing xml tag. :)
		  // TextParse( "<name>Lewis</name><name>Nico</name><name>Sebastian</name>", "<name>", "", 3 ) =Sebastian
		  
		  // Prep
		  dim theOccurrence as Integer = 1
		  dim theTagBeginLen, theTextBegin, theTextEnd as integer
		  theTagBeginLen = Len( pTagBegin )
		  dim theText as text
		  
		  // For each Occurrence
		  while theOccurrence <= pOccurrence
		    
		    // Find the first Occurrence
		    theTextBegin = InStr ( pText, pTagBegin )
		    if theTextBegin > 0 then
		      theTextEnd = InStr ( theTextBegin + theTagBeginLen, pText, pTagEnd )
		      if ( theTextEnd > 0 ) and ( theTextEnd > theTextBegin ) then
		        // Get theText for this Occurrence
		        theText = Mid ( pText, theTextBegin + theTagBeginLen, theTextEnd - theTextBegin - theTagBeginLen ).totext
		        // Remove the Occurrence with the tag from pText so we can find the next Occurence.
		        pText = pText.Replace( pTagBegin + theText + pTagEnd, "" )
		      end if
		    else
		      theText = ""
		      Exit
		    end if
		    
		    // Keep going...
		    theOccurrence = theOccurrence + 1
		    
		  wend
		  
		  Return theText
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextParse(pText as text, pTagBegin as text, pTagEnd as text, pOccurrence as integer = 1) As text
		  return pText.TextParse( pTagBegin, pTagEnd, pOccurrence )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextQuoteDouble(Extends theText as Text) As Text
		  // TextQuoteDouble wraps text in single quotes.
		  // Hal Gumbert, CampSoftware: http://www.CampSoftware.com
		  //
		  // Function TextQuoteDouble(Extends theText as Text) As Text
		  //
		  // Calling Example
		  
		  'dim theText as text = "Hal"
		  'theText = theText.TextQuoteSingle
		  
		  // Code
		  
		  return chr( 34 ).ToText + theText + chr( 34 ).ToText
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextQuoteDouble(pText as Text) As Text
		  return pText.TextQuoteDouble
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextQuoteSingle(Extends theText as Text) As Text
		  // TextQuoteSingle wraps text in single quotes.
		  // Hal Gumbert, CampSoftware: http://www.CampSoftware.com
		  //
		  // Function TextQuoteSingle(Extends theText as Text) As Text
		  //
		  // Calling Example
		  
		  'dim theText as text = "Hal"
		  'theText = theText.TextQuoteSingle
		  
		  // Code
		  
		  return chr(39).ToText + theText + chr(39).ToText
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextQuoteSingle(pText as Text) As Text
		  return pText.TextQuoteSingle
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextRandomValue(extends pText as text, pDelimiter as text) As text
		  // TextRandomValue returns a Random Value from the Text.
		  // Hal Gumbert, CampSoftware: http://www.CampSoftware.com
		  //
		  // Function TextRandomValue(pText as text, pDelimiter as text) As text
		  //
		  // Calling Example
		  
		  'dim randomString as text = randomTextValue( "Hal,Tim, Michael", "," )
		  
		  dim theValuesArray() As text
		  theValuesArray = pText.Split( pDelimiter )
		  
		  dim theRandom As New Random
		  dim theIndex As Integer = theRandom.InRange( 0, theValuesArray.ubound )
		  
		  dim theValue as text = theValuesArray( theIndex )
		  
		  return theValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextRandomValue(pText as text, pDelimiter as text) As text
		  return pText.TextRandomValue( pDelimiter )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextToDouble(extends theText as text) As double
		  // TextToDouble converts a number in text to a double.
		  // Hal Gumbert, CampSoftware: http://www.CampSoftware.com
		  //
		  // Function TextToDouble(extends theText as text) As double
		  //
		  // Calling Example
		  
		  'dim theText as text = "3.14"
		  'dim theDouble as Double
		  'theDouble = theText.TextToDouble
		  
		  // Code
		  
		  return Double.FromText( theText )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextToDouble(theText as text) As double
		  return theText.TextToDouble
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextUUIDGenerate() As text
		  // Generate a UUID and assign it
		  
		  // From Kem Tekinay's post on 2015-03-06 on https://forum.xojo.com/18029-native-uuid-generation
		  // From http://www.cryptosys.net/pki/uuid-rfc4122.html
		  //
		  // Generate 16 random bytes (=128 bits)
		  // Adjust certain bits according to RFC 4122 section 4.4 as follows:
		  // set the four most significant bits of the 7th byte to 0100'B, so the high nibble is '4'
		  // set the two most significant bits of the 9th byte to 10'B, so the high nibble will be one of '8', '9', 'A', or 'B'.
		  // Convert the adjusted bytes to 32 hexadecimal digits
		  // Add four hyphen '-' characters to obtain blocks of 8, 4, 4, 4 and 12 hex digits
		  // Output the resulting 36-character string "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
		  
		  // CALLING EXAMPLE
		  'dim theUUID as text = EasyDataHelpers.UUIDGenerate
		  'MsgBoxAlert ( "", theUUID, "OK" )
		  '
		  'if UUIDValidate( theUUID ) then
		  'MsgBoxAlert ( "", "UUID is Valid", "OK" )
		  'else
		  'MsgBoxAlert ( "", "UUID is not Valid", "OK" )
		  'end if
		  
		  dim randomBytes as MemoryBlock = Crypto.GenerateRandomBytes(16)
		  randomBytes.LittleEndian = false
		  
		  //
		  // Adjust seventh byte
		  //
		  dim value as byte = randomBytes.Byte(6)
		  value = value and &b00001111 // Turn off the first four bits
		  value = value or &b01000000 // Turn on the second bit
		  randomBytes.Byte(6) = value
		  
		  //
		  // Adjust ninth byte
		  //
		  value = randomBytes.Byte(8)
		  value = value and &b00111111 // Turn off the first two bits
		  value = value or &b10000000 // Turn on the first bit
		  randomBytes.Byte(8) = value
		  
		  
		  dim result as string = EncodeHex(randomBytes)
		  result = result.LeftB(8) + "-" + result.MidB(9, 4) + "-" + result.MidB(13, 4) + "-" + result.MidB(17, 4) + _
		  "-" + result.RightB(12)
		  
		  return result.ToText
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextUUIDValidate(s As text) As Boolean
		  // From Kem Tekinay's post on 2015-03-06 on https://forum.xojo.com/18029-native-uuid-generation
		  
		  // Validates a RFC-4122 random UUID like the ones generated by
		  // UUIDGenerate
		  
		  // CALLING EXAMPLE
		  'dim theUUID as text = EasyDataHelpers.UUIDGenerate
		  'MsgBoxAlert ( "", theUUID, "OK" )
		  '
		  'if UUIDValidate( theUUID ) then
		  'MsgBoxAlert ( "", "UUID is Valid", "OK" )
		  'else
		  'MsgBoxAlert ( "", "UUID is not Valid", "OK" )
		  'end if
		  
		  
		  static rxValidator as RegEx
		  if rxValidator is nil then
		    rxValidator = new RegEx
		    rxValidator.SearchPattern = "(?mi-Us)\A[[:xdigit:]]{8}-[[:xdigit:]]{4}-4[[:xdigit:]]{3}-[89AB][[:xdigit:]]{3}-[[:xdigit:]]{12}\z"
		  end if
		  
		  return rxValidator.Search(s) IsA RegExMatch
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URLEncode(extends pText as text) As text
		  // URLEncode encodes the text that will change illegal chars in a URL to a hexadecimal code.
		  // Tim Dietrich: http://www.timdietrich.me/
		  //
		  // URLEncode( pText as text )
		  //
		  // Call
		  // URLEncode( "Tim Dietrich") = Tim%20Dietrich
		  
		  // Code
		  
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
		Function URLEncode(pText as text) As text
		  return pText.URLEncode
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
		  
		  'URLShow( "http://www.CampSoftware.com" )
		  
		  // Code
		  
		  #IF TargetDesktop THEN
		    
		    ShowURL( pURL )
		    Return true  // doesn't return a value so assume true.
		    
		  #ENDIF
		  
		  // ==============================================
		  
		  #IF TargetWeb THEN
		    
		    dim theWebControl as WebLabel
		    theWebControl.ShowURL( pURL, true )
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


	#tag Note, Name = fmFunctions to Add
		Adding the following functions from http://fmwebframe.com/application/fm-to-php-translations.php 
		which were originally developed by Jonathan Stark: http://jonathanstark.com
		
		fmDay
		Returns a number in the range 1 through 31, representing the day of the month on which date occurs.
		Example: fmDay ( '11/27/1968' ) = 27
		
		fmDayName
		Returns a text string that is the full name of the weekday for date.
		Example: fmDayName ( '11/27/1968' ) = Wednesday
		
		fmDayOfWeek
		Returns a number representing the day of the week that date falls on. The number 1 represents Sunday, 2 represents Monday, 3 represents Tuesday, and so on.
		Example: fmDayOfWeek ( '11/27/1968' ) = 4
		
		fmDayOfYear
		Returns a number equal to the number of days from the beginning of the year of date.
		Example: fmDayOfYear ( '11/27/1968' ) = 332
		
		fmExact
		Compares the contents of any two fields. If the fields match, the result is 1 (True); otherwise, the result is 0 (False).
		Example: fmExact ( 'McDonald', 'MCDOnald' ) = 0
		
		fmFilter
		Returns from a given string only those characters specified in a second string, in the order that they were originally entered.
		Example: fmFilter( '(408)555-1212', '0123456789' ) = 4085551212
		
		fmFloor
		Returns number rounded down to the next lower integer.
		Example: fmFilter( '(408)555-1212', '0123456789' ) = 4085551212
		
		fmGetAsDate
		Returns dates in text as field type date, for use in formulas involving dates or date functions.
		Example: fmGetAsDate ( '5/1/2007' ) = 5/1/2007
		
		fmGetAsNumber
		Returns only the numbers in text, as field type number, for use with formulas involving numbers or numeric functions.
		Example: fmGetAsNumber ( 'PLAT-NO.1234' ) = -.1234
		
		fmGetAsTime
		Returns times or timestamps in text as field type time, for use with formulas involving the Time or Timestamp functions.
		Example: fmGetAsTime ( '10:51:22' ) = 10:51:22
		
		fmGetAsTimestamp
		Returns text as field type timestamp, for use with formulas involving timestamps.
		Example: fmGetAsTimestamp ( '11/27/1968 10:51:22' ) = 11/27/1968 10:51:22 AM
		
		fmGetAsURLEncoded
		Returns text as URL (Uniform Resource Locator) encoding, for use as a URL.
		Example: fmGetAsURLEncoded ( 'San Diego' ) = San%20Diego
		
		fmGetCurrentDate
		Returns the current date according to the system calendar.
		Example: fmGetCurrentDate() = 6/21/2015
		
		fmGetCurrentTime
		Returns CurrentTime (to the nearest second) according to the system clock.
		Example: fmGetCurrentTime() = 06:13:31 PM
		
		fmGetCurrentTimeStamp
		Returns the current date and time (to the nearest second) according to the system clock.
		Example: fmGetCurrentTimeStamp() = 6/21/2015 18:13:31 PM
		
		fmHour
		Returns a number representing the hour portion (0-23) of a specified time.
		Example: fmHour ( '3:51:22 PM' ) = 15
		
		fmInt
		Drops digits to the right of the decimal point and returns the integer part of number without rounding.
		Example: fmInt ( -5.2 ) = -5
		
		fmLeft
		Returns numberOfCharacters in text, counting from the left.
		Example: fmLeft ( 'Xframe', 3 ) = Xfr
		
		fmLeftWords
		Returns a text result containing numberOfWords in text, counting from the left.
		Example: fmLeftWords ( 'This is a test.', 2 ) = This is
		
		fmLength
		Returns the number of characters in field, including all spaces, numbers, and special characters.
		Example: fmLength ( 'Xframe' ) = 6
		
		fmLower
		Returns all letters in text as lowercase.
		Example: fmLower ( 'This is a test.' ) = this is a test.
		
		fmMiddle
		Extracts the numberOfCharacters from text, starting at the character position specified by start.
		Example: fmMiddle ( 'Xframe', 2, 3 ) = fra
		
		fmMiddleWords
		Returns a text result containing the numberOfWords from text, beginning at startingWord.
		Example: fmMiddleWords ( 'This is a bigger test.', 2, 3 ) = is a bigger
		
		fmMinute
		Returns a number representing the minute portion (0-59) of a specified time.
		Example: fmMinute ( '3:51:22 PM' ) = 51
		
		fmMod
		Returns the remainder after number is divided by divisor.
		Example: fmMod ( 27, 11 ) = 5
		
		fmMonth
		Returns a number in the range 1 through 12, representing the number of the month of the year in which date occurs.
		Example: fmMonth ( '11/27/1968' ) = 11
		
		fmMonthName
		Returns the full name of the month for date.
		Example: fmMonthName ( '11/27/1968' ) = November
		
		fmPatternCount
		Returns the number of occurrences of searchString in text.
		Example: fmPatternCount ( 'FMWebFrame', 'frame' ) = 1
		
		fmPosition
		Returns the starting position of the specified occurrence of searchString in text.
		Example: fmPosition ( 'FMWebFrame', 'frame' ) = 6
		
		fmProper
		Returns the first letter of each word in text as uppercase and all other letters as lowercase.
		Example: fmProper ( 'this is a test.' ) = This Is A Test.
		
		fmRandom
		Returns a number between two values, including the two values.
		Note: The behavior of fmRandom is slightly differently from FileMaker's "Random" function, which returns a number between zero and one, including zero, but not including one.
		Example: fmRandom ( 1, 100 ) = 73
		
		fmRight
		Returns the specified numberOfCharacters in text, counting from the right.
		Example: fmRight ( 'FMWebFrame', 5 ) = Frame
		
		fmRightWords
		Returns a text result containing the numberOfWords in text, counting from the right.
		Example: fmRightWords ( 'This is a test.', 2 ) = a test
		
		fmRound
		Returns number rounded off to the specified precision (number of decimal places).
		Example: fmRound ( 123.456, 2 ) = 123.46
		
		fmSeconds
		Returns a number representing the seconds portion (0-59) of a specified time.
		Example: fmSeconds ( '3:51:22 PM' ) = 22
		
		fmSerialIncrement
		Returns the combined text and numbers specified by text, with the numbers in text incremented by the specified amount.
		Example: fmSerialIncrement ( 'abc12', 1 ) = abc13
		
		fmSubstitute
		Returns a text string with every occurrence of searchString in text replaced by replaceString in text.
		Example: fmSubstitute ( 'Xframe', "ram", "stu" ) = Xfstue
		
		fmTime
		Returns a time result with the specified number of hours, minutes, and seconds.
		Example: fmTime ( 10, 51, 22 ) = 10:51:22
		
		fmTimestamp
		Returns a timestamp containing date as a calendar date and time as a time of day.
		Example: fmTimestamp ( fmGetAsDate ( '5/1/2007' ), fmGetAsTime ( '10:51:22' ) ) = 5/1/2007 10:51:22 AM
		
		fmTrim
		Returns text stripped of all leading and trailing spaces.
		Example: fmTrim ( ' This is a test. ' ) = This is a test.
		
		fmTruncate
		Returns number truncated to the specified precision (number of decimal places).
		Example: fmTruncate ( 123.456, 2 ) = 123.45
		
		fmUpper
		Returns all letters in text as uppercase.
		Example: fmUpper ( 'This is a test.' ) = THIS IS A TEST.
		
		fmWeekOfYear
		Returns the number of weeks after January 1 of the year of date.
		Example: fmWeekOfYear ( '11/27/1968' ) = 48
		
		fmWordCount
		Returns a count of the total number of words in text.
		Example: fmWordCount ( 'This is a test.' ) = 4
		
		fmYear
		Returns a number representing the year in which date occurs.
		Example: fmYear ( '11/27/1968' ) = 1968
	#tag EndNote


	#tag Constant, Name = theFormatFileSize, Type = Text, Dynamic = False, Default = \"###\x2C###\x2C###\x2C###\x2C###", Scope = Public
	#tag EndConstant


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
