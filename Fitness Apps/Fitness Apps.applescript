--
--  Fitness Apps.applescript
--  Fitness Apps
--
--  Created by Monty on 9/24/12.
--  Copyright (c) 2012 taolam. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
	-- this property will be used to configure our notification
	property myNotification : missing value
    
    property theAppName : "Fitness Apps"
    property theSetMessage : "The Fitness applications have been launched."
    property theClearMessage : "The Fitness applications have been closed."
	#    property theList : {"Garmin Training Center", "Garmin ANT Agent"}
	property theList : {"Garmin ANT Agent"}
	property theResult : "false"

	
	on applicationWillFinishLaunching_(aNotification)
		if utilAppIsRunning("Garmin Training Center") is true or utilAppIsRunning("Garmin ANT Agent") is true then
			-- Close some apps
			repeat with theApp in theList
				if utilAppIsRunning(theApp) is true then
					tell application theApp to quit
				end if
			end repeat
			tell application "Numbers"
				activate
				close document "Fitness Log 2015" saving ask
			end tell
		else
			set theResult to "true"
			--Launch a few applications
			repeat with theApp in theList
				if utilAppIsRunning(theApp) is false then
					tell application theApp to activate
				end if
			end repeat
			tell application "Numbers"
				activate
				open "Users:monty:Library:Mobile Documents:com~apple~Numbers:Documents:Fitness Log 2015.numbers"
			end tell
			tell application "Safari" to open location "http://connect.garmin.com/dashboard"
		end if
		if theResult is "true"
			-- send a notification to indicate the Screen Saver Pasword has been set
			sendNotificationWithTitle_AndMessage_(theAppName,theSetMessage)
        else
			-- send a notification to indicate the Screen Saver Pasword has been cleared
			sendNotificationWithTitle_AndMessage_(theAppName,theClearMessage)
		end	if
	quit
		
	end applicationWillFinishLaunching_

	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
    
    on utilAppIsRunning(appName)
        tell application "System Events" to set appNameIsRunning to exists (processes where name is appName)
        if appNameIsRunning is true then
            log appName & " is running"
            else
            log appName & " is not running"
        end if
        return appNameIsRunning
    end utilAppIsRunning

	-- Method for sending a notification based on supplied title and text
	on sendNotificationWithTitle_AndMessage_(aTitle, aMessage)
		set myNotification to current application's NSUserNotification's alloc()'s init()
		set myNotification's title to aTitle
		set myNotification's informativeText to aMessage
		current application's NSUserNotificationCenter's defaultUserNotificationCenter's deliverNotification_(myNotification)
	end sendNotification

end script
