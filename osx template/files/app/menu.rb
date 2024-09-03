
##################################################
#  ―――― Class Extensions ――――
##################################################

class String

   # Return a localized string.
   # Optionally from the specified table and language bundle (en, ja, fr, etc).
   def localized(value = nil, table = nil, languageCode = nil)
      bundle = NSBundle.mainBundle
      unless languageCode.nil? || languageCode == bundle.preferredLocalizations.first
         path = NSBundle.mainBundle.pathForResource(languageCode, ofType: 'lproj')
         bundle = NSBundle.bundleWithPath(path) unless path.nil?
      end
      bundle.localizedStringForKey(self, value: value, table: table).UTF8String
   end

end


class AppDelegate

   ##################################################
   #  ―――― Menu Creation Methods ――――
   ##################################################

   # build localized main application menu
   def buildMenu
      appName = NSBundle.mainBundle.infoDictionary['CFBundleName']
      @mainMenu = NSMenu.new

      appMenu = addMenu(NSBundle.mainBundle.objectForInfoDictionaryKey('CFBundleName')) do
         addItemWithTitle("#{'MAIN:ABOUT'.localized} #{appName}", action: 'orderFrontStandardAboutPanel:', keyEquivalent: '')
         addItem(NSMenuItem.separatorItem)
         addItemWithTitle('MAIN:PREFS'.localized, action: 'openPreferences:', keyEquivalent: ',')
         addItem(NSMenuItem.separatorItem)
         servicesItem = addItemWithTitle('MAIN:SERVICES'.localized, action: nil, keyEquivalent: '')
         NSApp.servicesMenu = servicesItem.submenu = NSMenu.new
         addItem(NSMenuItem.separatorItem)
         addItemWithTitle("#{'MAIN:HIDE'.localized} #{appName}", action: 'hide:', keyEquivalent: 'h')
         addItemWithTitle('MAIN:OTHERS'.localized, action: 'hideOtherApplications:', keyEquivalent: 'h')
                         .keyEquivalentModifierMask = NSCommandKeyMask | NSAlternateKeyMask
         addItemWithTitle('MAIN:SHOW'.localized, action: 'unhideAllApplications:', keyEquivalent: '')
         addItem(NSMenuItem.separatorItem)
         addItemWithTitle("#{'MAIN:QUIT'.localized} #{appName}", action: 'terminate:', keyEquivalent: 'q')
      end
            
      fileMenu = addMenu('FILE:MENU'.localized) do
         addItemWithTitle('FILE:NEW'.localized, action: 'newDocument:', keyEquivalent: 'n')
         addItemWithTitle('FILE:OPEN'.localized, action: 'openDocument:', keyEquivalent: 'o')
         addItem(NSMenuItem.separatorItem)
         addItemWithTitle('FILE:CLOSE'.localized, action: 'performClose:', keyEquivalent: 'w')
         addItemWithTitle('FILE:SAVE'.localized, action: 'saveDocument:', keyEquivalent: 's')
         addItemWithTitle('FILE:REVERT'.localized, action: 'revertDocumentToSaved:', keyEquivalent: '')
         addItem(NSMenuItem.separatorItem)
         addItemWithTitle('FILE:SETUP'.localized, action: 'runPageLayout:', keyEquivalent: 'P')
         addItemWithTitle('FILE:PRINT'.localized, action: 'printDocument:', keyEquivalent: 'p')
      end
      
      findMenu = createMenu('FIND:MENU'.localized) do  # Edit submenu
         addItemWithTitle('FIND:FIND'.localized, action: 'performFindPanelAction:', keyEquivalent: 'f')
                         .tag = 1
         addItemWithTitle('FIND:NEXT'.localized, action: 'performFindPanelAction:', keyEquivalent: 'g')
                         .tag = 2
         addItemWithTitle('FIND:PREVIOUS'.localized, action: 'performFindPanelAction:', keyEquivalent: 'G')
                         .tag = 3
         addItemWithTitle('FIND:SELECTION'.localized, action: 'performFindPanelAction:', keyEquivalent: 'e')
                         .tag = 7
         addItemWithTitle('FIND:JUMP'.localized, action: 'centerSelectionInVisibleArea:', keyEquivalent: 'j')
      end

      spelling_and_grammar_menu = createMenu('SPELL:MENU'.localized) do  # Edit submenu
         addItemWithTitle('SPELL:SHOW'.localized, action: 'showGuessPanel:', keyEquivalent: ':')
         addItemWithTitle('SPELL:DOCUMENT'.localized, action: 'checkSpelling:', keyEquivalent: ';')
         addItem(NSMenuItem.separatorItem)
         addItemWithTitle('SPELL:SPELLING'.localized, action: 'toggleContinuousSpellChecking:', keyEquivalent: '')
         addItemWithTitle('SPELL:GRAMMAR'.localized, action: 'toggleGrammarChecking:', keyEquivalent: '')
         addItemWithTitle('SPELL:CORRECT'.localized, action: 'toggleAutomaticSpellingCorrection:', keyEquivalent: '')
      end

      substitutions_menu = createMenu('SUBS:MENU'.localized) do  # Edit submenu
         addItemWithTitle('SUBS:SHOW'.localized, action: 'orderFrontSubstitutionsPanel:', keyEquivalent: 'f')
         addItem(NSMenuItem.separatorItem)
         addItemWithTitle('SUBS:COPY'.localized, action: 'toggleSmartInsertDelete:', keyEquivalent: 'f')
         addItemWithTitle('SUBS:QUOTES'.localized, action: 'toggleAutomaticQuoteSubstitution:', keyEquivalent: 'g')
         addItemWithTitle('SUBS:DASHES'.localized, action: 'toggleAutomaticDashSubstitution:', keyEquivalent: '')
         addItemWithTitle('SUBS:LINKS'.localized, action: 'toggleAutomaticLinkDetection:', keyEquivalent: 'G')
         addItemWithTitle('SUBS:REPLACE'.localized, action: 'toggleAutomaticTextReplacement:', keyEquivalent: '')
      end

      transformationsMenu = createMenu('TRANS:MENU'.localized) do  # Edit submenu
         addItemWithTitle('TRANS:UPPER'.localized, action: 'uppercaseWord:', keyEquivalent: '')
         addItemWithTitle('TRANS:LOWER'.localized, action: 'lowercaseWord:', keyEquivalent: '')
         addItemWithTitle('TRANS:CAPS'.localized, action: 'capitalizeWord:', keyEquivalent: '')
      end

      speechMenu = createMenu('SPEECH:MENU'.localized) do  # Edit submenu
         addItemWithTitle('SPEECH:START'.localized, action: 'startSpeaking:', keyEquivalent: '')
         addItemWithTitle('SPEECH:STOP'.localized, action: 'stopSpeaking:', keyEquivalent: '')
      end

      editMenu = addMenu('EDIT:MENU'.localized) do
         addItemWithTitle('EDIT:UNDO'.localized, action: 'undo:', keyEquivalent: 'z')
         addItemWithTitle('EDIT:REDO'.localized, action: 'redo:', keyEquivalent: 'Z')
         addItem(NSMenuItem.separatorItem)
         addItemWithTitle('EDIT:CUT'.localized, action: 'cut:', keyEquivalent: 'x')
         addItemWithTitle('EDIT:COPY'.localized, action: 'copy:', keyEquivalent: 'c')
         addItemWithTitle('EDIT:PASTE'.localized, action: 'paste:', keyEquivalent: 'v')
         addItemWithTitle('EDIT:MATCH'.localized, action: 'pasteAsPlainText:', keyEquivalent: 'V')
                         .keyEquivalentModifierMask = NSCommandKeyMask | NSAlternateKeyMask
         addItemWithTitle('EDIT:DELETE'.localized, action: 'delete:', keyEquivalent: '')
         addItemWithTitle('EDIT:SELECT'.localized, action: 'selectAll:', keyEquivalent: 'a')
         addItem(NSMenuItem.separatorItem)
         addItem(findMenu)
         addItem(spelling_and_grammar_menu)
         addItem(substitutions_menu)
         addItem(transformationsMenu)
         addItem(speechMenu)
      end

      textMenu = createMenu('TEXT:MENU'.localized) do  # Format submenu
         addItemWithTitle('TEXT:LEFT'.localized, action: 'alignLeft:', keyEquivalent: '{')
         addItemWithTitle('TEXT:CENTER'.localized, action: 'alignCenter:', keyEquivalent: '|')
         addItemWithTitle('TEXT:JUSTIFY'.localized, action: 'alignJustified:', keyEquivalent: '')
         addItemWithTitle('TEXT:RIGHT'.localized, action: 'alignRight:', keyEquivalent: '}')
         addItem(NSMenuItem.separatorItem)
         addItemWithTitle('TEXT:SHOW'.localized, action: 'toggleRuler:', keyEquivalent: '')
         addItemWithTitle('TEXT:COPY'.localized, action: 'copyRuler:', keyEquivalent: 'c')
                         .keyEquivalentModifierMask = NSCommandKeyMask | NSControlKeyMask
         addItemWithTitle('TEXT:PASTE'.localized, action: 'pasteRuler:', keyEquivalent: 'v')
                         .keyEquivalentModifierMask = NSCommandKeyMask | NSControlKeyMask
      end

      formatMenu = addMenu('FORMAT:MENU'.localized) do
         addItemWithTitle('FONT:MENU'.localized, action: nil, keyEquivalent: '')
                         .submenu = NSFontManager.sharedFontManager.fontMenu(true)  # use system font menu
         addItem(textMenu)
      end
      
      addMenu('VIEW:MENU'.localized) do
         addItemWithTitle('VIEW:SHOW'.localized, action: 'toggleToolbarShown:', keyEquivalent: 't')
                         .keyEquivalentModifierMask = NSCommandKeyMask | NSAlternateKeyMask
         addItemWithTitle('VIEW:CUSTOMIZE'.localized, action: 'runToolbarCustomizationPalette:', keyEquivalent: '')
      end

      NSApp.windowsMenu = addMenu('WINDOW:MENU'.localized) do
         addItemWithTitle('WINDOW:MINIMIZE'.localized, action: 'performMiniaturize:', keyEquivalent: 'm')
         addItemWithTitle('WINDOW:ZOOM'.localized, action: 'performZoom:', keyEquivalent: '')
         addItem(NSMenuItem.separatorItem)
         addItemWithTitle('WINDOW:FRONT'.localized, action: 'arrangeInFront:', keyEquivalent: '')
         # system adds any window names after a separator
      end.submenu
      
      NSApp.helpMenu = addMenu('HELP:MENU'.localized) do
         addItemWithTitle("#{appName} #{'HELP:HELP'.localized}", action: 'showHelp:', keyEquivalent: '?')
      end.submenu

      NSApp.mainMenu = @mainMenu
      
   end


   ##################################################
   #  ―――― Private/Protected Methods ――――
   ##################################################

   private

   def addMenu(title, &block)
      createMenu(title, &block).tap do |item|
         @mainMenu.addItem item
      end
   end
   
   
   def createMenu(title, &block)
      menu = NSMenu.alloc.initWithTitle(title)
      menu.instance_eval(&block) if block
      NSMenuItem.alloc.initWithTitle(title, action: nil, keyEquivalent: '').tap do |item|
         item.submenu = menu
      end
   end

end

