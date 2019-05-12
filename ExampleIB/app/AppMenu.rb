
#
#  Project 'ExampleIB'  --  AppMenu.rb
#
#  This extension to the AppDelegate class sets up the application menu.
#
#


class AppDelegate

   # Build the main application menu.
   def buildMenu
      @mainMenu = NSMenu.new

      appName = NSBundle.mainBundle.infoDictionary['CFBundleName']
      addMenu(appName) do
         addItemWithTitle("About #{appName}", action: 'orderFrontStandardAboutPanel:', keyEquivalent: '')
         addItem(NSMenuItem.separatorItem)
         addItemWithTitle('Preferences', action: 'openPreferences:', keyEquivalent: ',')
         addItem(NSMenuItem.separatorItem)
         servicesItem = addItemWithTitle('Services', action: nil, keyEquivalent: '')
         NSApp.servicesMenu = servicesItem.submenu = NSMenu.new
         addItem(NSMenuItem.separatorItem)
         addItemWithTitle("Hide #{appName}", action: 'hide:', keyEquivalent: 'h')
         item = addItemWithTitle('Hide Others', action: 'hideOtherApplications:', keyEquivalent: 'H')
         item.keyEquivalentModifierMask = NSCommandKeyMask | NSAlternateKeyMask
         addItemWithTitle('Show All', action: 'unhideAllApplications:', keyEquivalent: '')
         addItem(NSMenuItem.separatorItem)
         addItemWithTitle("Quit #{appName}", action: 'terminate:', keyEquivalent: 'q')
      end

      addMenu('File') do
         addItemWithTitle('New', action: 'newDocument:', keyEquivalent: 'n')
         addItemWithTitle('Open…', action: 'openDocument:', keyEquivalent: 'o')
         addItem(NSMenuItem.separatorItem)
         addItemWithTitle('Close', action: 'performClose:', keyEquivalent: 'w')
         addItemWithTitle('Save…', action: 'saveDocument:', keyEquivalent: 's')
         addItemWithTitle('Revert to Saved', action: 'revertDocumentToSaved:', keyEquivalent: '')
         addItem(NSMenuItem.separatorItem)
         addItemWithTitle('Page Setup…', action: 'runPageLayout:', keyEquivalent: 'P')
         addItemWithTitle('Print…', action: 'printDocument:', keyEquivalent: 'p')
      end

      addMenu('Edit') do
         addItemWithTitle('Undo', action: 'undo:', keyEquivalent: 'z')
         addItemWithTitle('Redo', action: 'redo:', keyEquivalent: 'Z')
         addItem(NSMenuItem.separatorItem)
         addItemWithTitle('Cut', action: 'cut:', keyEquivalent: 'x')
         addItemWithTitle('Copy', action: 'copy:', keyEquivalent: 'c')
         addItemWithTitle('Paste', action: 'paste:', keyEquivalent: 'v')
         item = addItemWithTitle('Paste and Match Style', action: 'pasteAsPlainText:', keyEquivalent: 'V')
         item.keyEquivalentModifierMask = NSCommandKeyMask | NSAlternateKeyMask
         addItemWithTitle('Delete', action: 'delete:', keyEquivalent: '')
         addItemWithTitle('Select All', action: 'selectAll:', keyEquivalent: 'a')
      end

      NSApp.windowsMenu = addMenu('Window') do
         addItemWithTitle('Minimize', action: 'performMiniaturize:', keyEquivalent: 'm')
         addItemWithTitle('Zoom', action: 'performZoom:', keyEquivalent: '')
         addItem(NSMenuItem.separatorItem)
         addItemWithTitle('Bring All To Front', action: 'arrangeInFront:', keyEquivalent: '')
      end.submenu

      NSApp.helpMenu = addMenu('Help') do
         addItemWithTitle("#{appName} Help", action: 'showHelp:', keyEquivalent: '?')
      end.submenu

      NSApp.mainMenu = @mainMenu
   end


   private

   def addMenu(title, &block)
      createMenu(title, &block).tap { |obj| @mainMenu.addItem obj }
   end


   def createMenu(title, &block)
      menu = NSMenu.alloc.initWithTitle(title)
      menu.instance_eval(&block) if block
      NSMenuItem.alloc
                .initWithTitle(title, action: nil, keyEquivalent: '')
                .tap { |obj| obj.submenu = menu }
   end

end

