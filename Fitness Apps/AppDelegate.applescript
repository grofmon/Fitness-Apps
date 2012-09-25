--
--  AppDelegate.applescript
--  Fitness Apps
--
--  Created by Monty on 9/24/12.
--  Copyright (c) 2012 taolam. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
	
	on applicationWillFinishLaunching_(aNotification)
		-- Insert code here to initialize your application before any files are opened 
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
end script