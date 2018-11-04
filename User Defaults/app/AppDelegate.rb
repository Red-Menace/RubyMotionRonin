
#
#  Project 'User Defaults'  --  AppDelegate.rb
#
#  This class provides application delegate and startup methods.
#


class AppDelegate

   ##################################################
   #  ――― CONSTANTS and Attributes ―――
   ##################################################

   attr_reader :appController, :prefsController
   

   ##################################################
   #  ――― Instance Methods ―――
   ##################################################

   def openPreferences(sender)
      @prefsController.showPreferences
   end
   
   
   ##################################################
   #  ――― Delegate Methods ―――
   ##################################################

   # ① Set up just before the application object is initialized.
   def applicationWillFinishLaunching(notification)
      buildMenu
      @prefsController = PrefsController.sharedInstance
      @appController = AppController.sharedInstance
   end


   # ② Handle files dropped onto the application.
   def application(theApplication, openFiles: fileNames)

   end


   # ③ The application is initialized and is about to receive its first event.
   def applicationDidFinishLaunching(notification)
      
   end


   # ④ Allow application to terminate?
   def applicationShouldTerminate(sender)
      NSTerminateNow
   end


   # ⑤ Clean things up - the application is about to terminate.
   def applicationWillTerminate(_aNotification)
      @prefsController.writeDefaults
   end


   # Handle reopening active application (from the Dock, etc).
   def applicationShouldHandleReopen(theApplication, hasVisibleWindows: flag)
      true # application performs its normal tasks
   end


   # Quit when there are no more windows.
   def applicationShouldTerminateAfterLastWindowClosed(theApplication)
      true
   end

end

