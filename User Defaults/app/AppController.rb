
#
#  Project 'User Defaults'  --  AppController.rb
#
#  This class provides the main application methods.
#


class AppController

   ##################################################
   # ――― CONSTANTS and Attributes ―――
   ##################################################

   WINDOW_FRAME = [[0, 0], [520, 300]] # initial/minimum window size

   attr_reader :window, :windowField


   ##################################################
   #  ――― Class Methods ―――
   ##################################################

   class << self
      
      # Cocoa shared instance
      def sharedInstance
         Dispatch.once { @sharedInstance ||= new }
         @sharedInstance
      end
   
   end


   ##################################################
   #  ――― Instance Methods ―――
   ##################################################

   def hello
      windowField.stringValue = "#{@prefsController.who}\n#{@prefsController.what}"
   end


   ##################################################
   #  ――― Private/Protected Methods ―――
   ##################################################

   private

   # Build the application window.
   def buildWindow
      windowMask = NSTitledWindowMask | 
                   NSClosableWindowMask | 
                   NSMiniaturizableWindowMask | 
                   NSResizableWindowMask
      @window = NSWindow.alloc
                        .initWithContentRect( WINDOW_FRAME,
                                   styleMask: windowMask,
                                     backing: NSBackingStoreBuffered,
                                       defer: false)
      @window.frameAutosaveName = 'Main Window' # save the window frame too
      @window.frameUsingName = 'Main Window'
      @window.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
      @window.minSize = WINDOW_FRAME[1]
      @window.cascadeTopLeftFromPoint [20, 20]
      @window.contentView.addSubview buildwindowField
      @window.orderFrontRegardless
   end


   # Build a text field for the window (the content size minus a 20px border)
   def buildwindowField
      size = @window.frame.size.to_a
      textFrame = [[20, 20], [size[0] - 40, size[1] - 60]] # size to window
      @windowField = NSTextField.alloc.initWithFrame(textFrame).tap do |obj|
         obj.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable
         obj.refusesFirstResponder = true
         obj.selectable = false
         obj.bordered = false
         obj.drawsBackground = false
         obj.font = NSFont.fontWithName("Noteworthy Bold", size: 42)
         obj.textColor = NSColor.redColor
      end
   end


   ##################################################
   # ――― Initialization ―――
   ##################################################
   
   # Standard Ruby class initialization (.new).
   def initialize
      @prefsController = NSApp.delegate.prefsController
      buildWindow
      hello
   end

end

