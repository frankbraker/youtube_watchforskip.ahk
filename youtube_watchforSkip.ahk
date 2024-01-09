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

x_skip_ly := 1903
y_skip_ly := 965

x_yellow_sy := 231
y_yellow_sy := 845

x_yellow_ly := 237
y_yellow_ly := 1024

yellow_color := 0x00ccff


^y::
	Cancelled:= false
	LookingForSkip := true


	while (LookingForSkip = true)
	{

		; Move the mouse to x_yellow_sy, y_yellow_sy
		PixelGetColor, PixColor, %x_yellow_sy%, %y_yellow_sy%
		Sleep 100
		MouseMove, %x_yellow_sy%, %y_yellow_sy%, 0
		Sleep 100

		if (%PixColor%=%yellow_color%)
		{
			MouseClick, right, %x_skip_sy%, %y_skip_sy%
		}

		; Move the mouse to x_yellow_ly, y_yellow_ly
		PixelGetColor, PixColor, %x_yellow_ly%, %y_yellow_ly%
		Sleep 100
		MouseMove, %x_yellow_ly%, %y_yellow_ly%, 0
		Sleep 100

		if (%PixColor%=%yellow_color%)
		{
			MouseClick, right, %x_skip_ly%, %y_skip_ly%
		}


		; wait 5 seconds
		curtime := 5
		while ( !Cancelled && (curtime > 0) )
		{
			curtime := curtime - 1
			Sleep Seconds1
		}
	
	}
	;MsgBox "exitting"
	return


^q::
	LookingForSkip:=false
	Cancelled:=true
	return

