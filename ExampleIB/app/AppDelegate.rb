
#
#  Project 'ExampleIB'  --  AppDelegate.rb
#
#  This class provides application delegate and startup methods.
#
#


class AppDelegate

   # Initialize the window/interface controller.
   def buildWindow
      @controller = AppController.sharedInstance
      @controller.showWindow(self)
   end


   ##################################################
   #  ――― Delegate Methods ―――
   ##################################################

   # ① Set up just before the application object is initialized.
   def applicationWillFinishLaunching(notification)
      buildMenu
      buildWindow
   end


   # ② Handle files dropped onto the application.
   def application(theApplication, openFiles: fileNames)
      # whatever
   end


   # ③ The application is initialized and is about to receive its first event.
   def applicationDidFinishLaunching(notification)
      puts 'Ready to go!'
   end


   # ④ Allow application to terminate?
   def applicationShouldTerminate(sender)
      NSTerminateNow
   end


   # ⑤ Clean things up - the application is about to terminate.
   def applicationWillTerminate(_aNotification)
      puts 'done ...'
   end


   # Handle reopening active application (from the Dock, etc).
   def applicationShouldHandleReopen(theApplication, hasVisibleWindows: flag)
      true  # application performs its normal tasks
   end


   # Quit when there are no more windows?
   def applicationShouldTerminateAfterLastWindowClosed(theApplication)
      true
   end

end

