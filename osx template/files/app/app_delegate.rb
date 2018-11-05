
############################################################
#  ――― Application Delegate ―――  
############################################################

class AppDelegate

  def buildWindow
      windowMask = NSTitledWindowMask |
                   NSClosableWindowMask |
                   NSMiniaturizableWindowMask |
                   NSResizableWindowMask
      @mainWindow = NSWindow.alloc
                            .initWithContentRect( [[0, 0], [520, 300]],
                                       styleMask: windowMask,
                                         backing: NSBackingStoreBuffered,
                                           defer: false)
      @mainWindow.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
      @mainWindow.cascadeTopLeftFromPoint([20, 20]) # top left
      @mainWindow.contentView.addSubview(hello)
      @mainWindow.orderFrontRegardless
  end
  
  
  def hello
   size = @mainWindow.frame.size.to_a
   textFrame = [[20, 20], [size[0] - 40, size[1] - 60]] # size to window
   NSTextField.alloc.initWithFrame(textFrame).tap do |obj|
      obj.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable
      obj.refusesFirstResponder = true
      obj.font = NSFont.fontWithName("Noteworthy Bold", size:42)
      obj.textColor = NSColor.redColor
      obj.stringValue = "Hello, World\nWelcome to RubyMotion!"
    end
  end
  

   ############################################################
   #  ――― Delegate Methods (number indicates call order) ―――  
   ############################################################

   # ① Set up just before the application object is initialized.
   def applicationWillFinishLaunching(notification)
      # whatever
   end


   # ② Handle files dropped onto the application.
   def application(theApplication, openFiles: fileNames)
      # whatever
   end


   # ③ The application is initialized and is about to receive its first event.
   def applicationDidFinishLaunching(notification)
      buildMenu
      buildWindow
   end


   # ④ Allow application to terminate?
   def applicationShouldTerminate(sender)
      NSTerminateNow
   end


   # ⑤ Clean things up - the application is about to terminate.
   def applicationWillTerminate(_aNotification)
      # whatever
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
