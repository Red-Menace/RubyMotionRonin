
#
#  Project 'User Defaults'  --  PrefsController.rb
#
#  This class handles the preferences (defaults).
#


class PrefsController

   ##################################################
   # ――― CONSTANTS and Attributes ―――
   ##################################################

   PREFS_FRAME = [[400, 600], [275, 212]] # preferences window location and size
   TEXT_FRAME = [[21, 60], [228, 22]]     # textField initial location and size
   BUTTON_FRAME = [[175, 20], [80, 20]]   # button initial location and size
   
   SHEET = true
   WHO = 'Hello, World'
   WHAT = 'Welcome to RubyMotion!'
   
   attr_accessor :who, :what
   
   
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

   # Show the preferences window.
   def showPreferences
      appWindow = NSApp.delegate.appController.window
      if @sheet
         appWindow.title = "#{@appName} Preferences"
         appWindow.beginSheet(@prefsWindow, completionHandler: nil)
      else
         @prefsWindow.makeKeyAndOrderFront self
      end
   end
   
   
   # Handle the preference window button press.
   def doPrefsButton(sender)
      appController = NSApp.delegate.appController
      @sheet ? appController.window.endSheet(@prefsWindow) : @prefsWindow.close
      appController.window.title = @appName
      case sender.title
      when 'OK' # new
         @sheet = @checkbox.state == 1
         @who = @whoField.stringValue
         @what = @whatField.stringValue
      when 'Default' # original
         @checkbox.state = (@sheet = SHEET)
         @whoField.stringValue = (@who = WHO)
         @whatField.stringValue = (@what = WHAT)
      else # existing
         @checkbox.state = @sheet
         @whoField.stringValue = @who
         @whatField.stringValue = @what
      end
         @prefsWindow.makeFirstResponder nil # reset
         appController.hello
   end
   

   # Register and read the user defaults.
   def readDefaults
      NSUserDefaults.standardUserDefaults.tap do |defaults|
         defaults.registerDefaults({'UseSheet' => @sheet, 'WhoText' => @who, 'WhatText' => @what})
         @sheet = defaults.objectForKey 'UseSheet'
         @who = defaults.objectForKey 'WhoText'
         @what = defaults.objectForKey 'WhatText'
         puts "sheet: #{@sheet.inspect},  who: #{@who.inspect},  what: #{@what.inspect}"
      end
   end


   # Write the user defaults.
   def writeDefaults
      NSUserDefaults.standardUserDefaults.tap do |defaults|
         defaults.setObject(@sheet, forKey: 'UseSheet')
         defaults.setObject(@who, forKey: 'WhoText')
         defaults.setObject(@what, forKey: 'WhatText')
         puts "sheet: #{@sheet.inspect},  who: #{@who.inspect},  what: #{@what.inspect}"
      end
   end


   ##################################################
   #  #mark  ――― Private/Protected Methods ―――
   ##################################################

   private

   # Build the preferences window.
   def buildWindow
      @prefsWindow = NSPanel.alloc
                            .initWithContentRect( PREFS_FRAME,
                                       styleMask: NSWindowStyleMaskTitled,
                                         backing: NSBackingStoreBuffered,
                                           defer: false)
      @prefsWindow.frameAutosaveName = 'Prefs Window' # save the window frame too
      @prefsWindow.frameUsingName = 'Prefs Window'
      @prefsWindow.title = 'Preferences'
      @whatField = addLabeledField('What:', 0)
      @whatField.stringValue = @what
      @whoField = addLabeledField('Who:', 60)
      @whoField.stringValue = @who
      @checkbox = addCheckbox('Present preferences as a sheet', 115)
      @checkbox.state = @sheet
      addButton('OK', 0)
      addButton('Default', 80)
      addButton('Cancel', 160).tap do |cancel|
         @prefsWindow.initialFirstResponder = cancel
         cancel.keyEquivalent = "\e" # escape and command-period
      end
   end


   # Add a textField with a label to the preferences window.
   # the offset is from the base textField frame Y coordinate
   # returns the textField
   def addLabeledField(label, offset)
      position = TEXT_FRAME[0].dup
      textField = NSTextField.alloc.initWithFrame(TEXT_FRAME).tap do |textField|
         textField.frameOrigin = [position[0], position[1] + offset]
      end
      labelField = NSTextField.alloc.initWithFrame(TEXT_FRAME).tap do |labelField|
         labelField.frameOrigin = [position[0], position[1] + offset + 22]
         labelField.refusesFirstResponder = true
         labelField.selectable = false
         labelField.bordered = false
         labelField.drawsBackground = false
         labelField.stringValue = label
      end
      [textField, labelField].each { |item| @prefsWindow.contentView.addSubview item }
      @prefsWindow.recalculateKeyViewLoop
      textField
   end


   # Add a button to the preferences window.
   # the offset is from the base button frame X coordinate
   # returns the button
   def addButton(name, offset)
      position = BUTTON_FRAME[0].dup
      button = NSButton.alloc.initWithFrame(BUTTON_FRAME).tap do |button|
         button.frameOrigin = [position[0] - offset, position[1]]
         button.target = self
         button.action = 'doPrefsButton:'
         button.buttonType = NSMomentaryLightButton
         button.bezelStyle = NSRoundedBezelStyle
         button.title = name
      end
      @prefsWindow.contentView.addSubview button
      @prefsWindow.recalculateKeyViewLoop
      button
   end
   
   
   # Add a checkbox to the preferences window.
   # the offset is from the base textField frame Y coordinate
   # returns the checkbox
   def addCheckbox(name, offset)
      position = TEXT_FRAME[0].dup
      checkbox = NSButton.alloc.initWithFrame(TEXT_FRAME).tap do |check|
         check.frameOrigin = [position[0], position[1] + offset]
         check.buttonType = NSSwitchButton
         check.title = name
      end
      @prefsWindow.contentView.addSubview checkbox
      @prefsWindow.recalculateKeyViewLoop
      checkbox
   end


   ##################################################
   #  #mark ――― Initialization ―――
   ##################################################
   
   # Standard Ruby class initialization (.new).
   def initialize
      @appName = NSBundle.mainBundle.infoDictionary['CFBundleName']
      @sheet = SHEET    # display preferences as a sheet?
      @who = WHO        # the who part of the window message
      @what = WHAT      # the what part of the window message
      readDefaults
      buildWindow
   end

end

