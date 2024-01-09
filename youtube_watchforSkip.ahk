; autohotkey
;
; CTRL-Y = start youtube watch-for-skip mode
;		Every 5 seconds the mouse is moved to:
;			x1370,y789 and checked for the yellow bar indicating an advertisement is playing
;			x1903,y965 and checked for the yellow bar indicating an advertisement is playing
;
; CTRL-Q = quit all modes
;

Seconds1  := 1000
Seconds10 := 10000
Minutes30 := 60 * Seconds1 * 30
Minutes15 := 60 * Seconds1 * 15
Cancelled := false

x_skip_sy := 1370
y_skip_sy := 789

; originally this tried to support full-screen - but skip that for now
;x_skip_ly := 1903
;y_skip_ly := 965

x_yellow_sy := 231
y_yellow_sy := 845

x_yellow_ly := 193
y_yellow_ly := 893

x_yellow_syMinus10 := 221
y_yellow_syMinus10 := 845

x_yellow_lyPlus100 := 293
y_yellow_lyPlus100 := 893

yellow_color := 0x00ccff


^y::
	Cancelled:= false
	LookingForSkip := true


	while (LookingForSkip = true)
	{
		MouseMove, %x_skip_sy%, %y_skip_sy%, 0
		Sleep 100

		MouseMove, %x_yellow_lyPlus100%, %y_yellow_lyPlus100%, 0
		Sleep 100

		; Move the mouse to x_yellow_sy, y_yellow_sy
		PixelGetColor, PixColor1, %x_yellow_sy%, %y_yellow_sy%
		Sleep 100
		; Move the mouse to x_yellow_ly, y_yellow_ly
		PixelGetColor, PixColor2, %x_yellow_ly%, %y_yellow_ly%
		Sleep 100

		MouseMove, %x_skip_sy%, %y_skip_sy%, 0
		Sleep 100

		if (PixColor1 = 0x00CCFF)
		{
			;MsgBox "Skipping"
			Sleep 1000
			MouseMove, %x_skip_sy%, %y_skip_sy%, 0
			Sleep 250
			MouseClick, right, %x_skip_sy%, %y_skip_sy%
		}
		if (PixColor2 = 0x00CCFF)
		{
			;MsgBox "Skipping"
			Sleep 1000
			MouseMove, %x_skip_sy%, %y_skip_sy%, 0
			Sleep 250
			MouseClick, right, %x_skip_sy%, %y_skip_sy%
		}



		; wait 5 seconds
		curtime := 5
		while ( !Cancelled && (curtime > 0) )
		{
			curtime := curtime - 1
			Sleep Seconds1
		}
		;MsgBox %PixColor1% %PixColor2%
		MouseMove, %x_yellow_lyPlus100%, %y_yellow_lyPlus100%, 0
		Sleep 100
	
	}
	;MsgBox "exitting"
	return


^q::
	LookingForSkip:=false
	Cancelled:=true
	return

