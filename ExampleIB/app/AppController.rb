
#
#  Project 'ExampleIB'  --  AppController.rb
#
#  This class provides accessors (outlets and bindings), methods (actions),
#  and initialization for UI items in the Xcode IB AppWindow.nib file.
#
#


class AppController < NSWindowController

   ##################################################
   #  ――― IB Outlets ―――
   ##################################################

   # 'window' is already defined in the controller
   attr_accessor :textField      # a text field to play with
   attr_accessor :button         # a button to play with


   ##################################################
   #  ――― IB Bindings ―――
   #  Note that to maintain KVO compliance, self.<key>
   #  or setter method is needed when assigning values
   ##################################################

   attr_accessor :textFieldText  # a binding to play with
   attr_accessor :buttonEnabled  # another binding to play with


   ##################################################
   #  ――― Initialization ―――
   ##################################################

   # Initialize UI after window/view is loaded.
   def awakeFromNib  # called when loaded from the IB archive
      self.textFieldText = 'whatever'  # IB binding
      self.buttonEnabled = false  # IB binding
      # whatever
   end


   def init
      initWithWindowNibName('AppWindow')
      self
   end


   ##################################################
   #  ――― Class Methods ―――
   ##################################################

   # Cocoa shared instance
   def self.sharedInstance
      Dispatch.once { @sharedInstance ||= new }
      @sharedInstance
   end


   ##################################################
   #  ――― IB Action Methods ―――
   ##################################################

   # IBAction connected to the smaller button
   def doButton(sender)
      text = "'#{sender.title}' was #{@button.title == 'Changed' ? 'changed' : 'pressed'}"
      text = 'Again' if @textField.stringValue == text
      @button.title = 'Button'  # IBOutlet
      @textField.stringValue = "#{text}"  # IBOutlet
   end


   # IBAction connected to the bigger button
   def someOtherAction(sender)
      text = 'Again' if @textField.stringValue == (text = 'The other button was pressed')
      @button.title = 'Changed'  # IBOutlet
      self.buttonEnabled = !@buttonEnabled  # IB binding
      @textField.stringValue = text  # IBOutlet
   end

end

