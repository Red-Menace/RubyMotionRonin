
//  
//  Project 'ExampleIB'  --  AppWindow.h
//
//  Proxy header for IB AppWindow.xib file in the resources directory
//
//


@interface AppWindow : NSWindowController
{
//  Typical outlet signature: IBOutlet CocoaClass *accessorName;
//  Usage in RubyMotion:      attr_accessor :accessorName

   //  Outlets:
   IBOutlet NSTextField *textField;  // outlet description
   IBOutlet NSButton *button;
   
   //  Bindings:
   IBOutlet NSObject *textFieldText;  // binding description
   IBOutlet NSObject *buttonEnabled;
   
}

//  Typical action signature: -(IBAction)actionMethod:callingObject;
//  Usage in RubyMotion:      def actionMethod(callingObject)   

 //  Action methods:
-(IBAction)doButton:(id)sender;  // action description
-(IBAction)someOtherAction:(id)sender;

@end

