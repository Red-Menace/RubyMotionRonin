
## RubyMotion Interface Builder Example ##

This example project demonstrates a (fairly) simple process to create a RubyMotion project/template that uses Xcode's Interface Builder, without the use of third party gems such as [IB](https://github.com/yury/ib).  I'm not sure how much will apply to an iOS project, since I don't do those. 


## What ##
Although the Interface Builder doesn't look for Ruby files, Objective-C projects are seen by the RubyMotion build system, so a library-like project can be used to wrap an IB .xib.  An Objective-C class header is used to define various outlets and actions which are hooked up to the UI objects as usual, and an IB .xib file is placed in the RM project resources, where everything gets built and connected by the associated Xcode IB project.

There isn't any built-in automation for connecting things up across environments, the idea is to use Xcode to build the user interface, then drop that into your RM project (or use a template IB project that has already been added to your RM project).  The Objective-C header file can be edited directly from your RubyMotion environment, although any changes would need to be matched in the Interface Builder.

## Why ##
Although there are a few interface styling gems around, most are for iOS.  Implementing your user interface in code does have advantages (constraints, source control, reuse, accessibility, etc), but if you are coming from an Xcode environment (where storyboards and XIBs are the norm), it can take a while to transition to something more idiomatic.  The method outlined here is also a way to drop an existing IB XIB into your project with minimal changes (mostly connections to a new Objective-C header file).  I've copied IB XIBs from MacRuby thru AppleScriptObjC to RubyMotion, so if you are like me, another reason might be that you are just lazy.

## How ##
You can edit/adapt the example project, or roll your own:

- To create your own Interface Builder project from scratch, the first thing to do is open Xcode and create a new empty project in your RubyMotion project folder (I put them in Xcode project folders in the **vendor** directory).  Next, add a new Objective-C class file to the Xcode project - check the option to include a XIB for the user interface, and set the subclass to **NSWindowController** (access to the XIB will be via the controller instance).

- In the IB Identity Inspector, set the class of the **File's Owner** to the name of your added Objective-C class - at this point any outlets and actions defined in the header file should show up in the IB Connections Inspector.  This header/proxy file will be edited to include the various IBOutlet and IBAction definitions that are going to be used in your RM project.

- If you are going to be doing any localizations, use the IB File Inspector to localize the XIB, and then go to the Xcode project info settings and check _"Use Base Internationalization"_.  This will create base and locale `iproj` folders, where you can separate the base and language specific parts of your UI resources.

- Now move the XIB file from the Xcode project folder into your RubyMotion project's **resources** folder (this is where the RubyMotion build system expects to find it), and update the new location by using the IB File Inspector.  The user interface can be edited in the Interface Editor by opening the Xcode project as usual, and since files are located relative to the project, Xcode projects can be included in a RubyMotion template.

- To use the outlets and actions in your RubyMotion project, create a class for the user interface, make it inherit from **NSWindowController**, and add accessors and methods to match those declared in the IB Objective-C header/proxy file.  The class can be instantiated from one of the application delegate methods such as **applicationWillFinishLaunching** by using the **initWithWindowNibName** method (or an init method that calls it), and an **awakeFromNib** method in the user interface class can be used to initialize items as desired.  When the project is built, everything will automagically be connected - note that any bindings (yes, they can also be used) will need to use `self.<key>` or setter methods to keep KVO compliance.

- In macOS 10.12 Sierra and beyond, a main nib file should be (and if you are using XIBs (especially with bindings), _must_ be) declared in the Rakefile.  This can be a minimal **MainMenu** file (included in the example project) or none, e.g.
```
app.info_plist['NSMainNibFile'] = ''  # the main nib file
```

<br />
The ExampleIB RubyMotion project includes an Xcode project for the user interface, and will build a simple test/example application with a couple of buttons and a text field.  It can be used as a base for your own custom template, if desired, just don't forget to update the paths (in the Xcode project) if you move the files around.  Templates can be placed into your user's **~/Library/RubyMotion/Template** folder so that they can be used with the `motion create` command.

Also included is a small script that will extract the various IBOutlets and IBActions defined in the header to a text file, where they will be available to copy/paste into your application files.

