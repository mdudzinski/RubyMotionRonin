
############################################################
#  ――― Application Delegate ―――  
############################################################

class AppDelegate

   ############################################################
   #  ――― Menu Creation Methods ―――  
   ############################################################

   def buildMenu
      @mainMenu = NSMenu.new

      appName = NSBundle.mainBundle.infoDictionary['CFBundleName']

      find_menu = createMenu('Find') do
         addItemWithTitle('Find...', action: 'performFindPanelAction:', keyEquivalent: 'f').tag = 1
         addItemWithTitle('Find Next', action: 'performFindPanelAction:', keyEquivalent: 'g').tag = 2
         addItemWithTitle('Find Previous', action: 'performFindPanelAction:', keyEquivalent: 'G').tag = 3
         addItemWithTitle('Use Selection for Find', action: 'performFindPanelAction:', keyEquivalent: 'e').tag = 7
         addItemWithTitle('Jump to Selection', action: 'centerSelectionInVisibleArea:', keyEquivalent: 'j')
      end

      spelling_and_grammar_menu = createMenu('Spelling and Grammar') do
         addItemWithTitle('Show Spelling and Grammar', action: 'showGuessPanel:', keyEquivalent: ':')
         addItemWithTitle('Check Document Now', action: 'checkSpelling:', keyEquivalent: ';')
         addItem(NSMenuItem.separatorItem)
         addItemWithTitle('Check Spelling While Typing', action: 'toggleContinuousSpellChecking:', keyEquivalent: '')
         addItemWithTitle('Check Grammar With Spelling', action: 'toggleGrammarChecking:', keyEquivalent: '')
         addItemWithTitle('Correct Spelling Automatically', action: 'toggleAutomaticSpellingCorrection:', keyEquivalent: '')
      end

      substitutions_menu = createMenu('Substitutions') do
         addItemWithTitle('Show Substitutions', action: 'orderFrontSubstitutionsPanel:', keyEquivalent: 'f')
         addItem(NSMenuItem.separatorItem)
         addItemWithTitle('Smart Copy/Paste', action: 'toggleSmartInsertDelete:', keyEquivalent: 'f')
         addItemWithTitle('Smart Quotes', action: 'toggleAutomaticQuoteSubstitution:', keyEquivalent: 'g')
         addItemWithTitle('Smart Dashes', action: 'toggleAutomaticDashSubstitution:', keyEquivalent: '')
         addItemWithTitle('Smart Links', action: 'toggleAutomaticLinkDetection:', keyEquivalent: 'G')
         addItemWithTitle('Text Replacement', action: 'toggleAutomaticTextReplacement:', keyEquivalent: '')
      end

      transformations_menu = createMenu('Transformations') do
         addItemWithTitle('Make Upper Case', action: 'uppercaseWord:', keyEquivalent: '')
         addItemWithTitle('Make Lower Case', action: 'lowercaseWord:', keyEquivalent: '')
         addItemWithTitle('Capitalize', action: 'capitalizeWord:', keyEquivalent: '')
      end

      speech_menu = createMenu('Speech') do
         addItemWithTitle('Start Speaking', action: 'startSpeaking:', keyEquivalent: '')
         addItemWithTitle('Stop Speaking', action: 'stopSpeaking:', keyEquivalent: '')
      end

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
         addItem(NSMenuItem.separatorItem)
         addItem(find_menu)
         addItem(spelling_and_grammar_menu)
         addItem(substitutions_menu)
         addItem(transformations_menu)
         addItem(speech_menu)
      end

      textMenu = createMenu('Text') do
         addItemWithTitle('Align Left', action: 'alignLeft:', keyEquivalent: '{')
         addItemWithTitle('Center', action: 'alignCenter:', keyEquivalent: '|')
         addItemWithTitle('Justify', action: 'alignJustified:', keyEquivalent: '')
         addItemWithTitle('Align Right', action: 'alignRight:', keyEquivalent: '}')
         addItem(NSMenuItem.separatorItem)
         addItemWithTitle('Show Ruler', action: 'toggleRuler:', keyEquivalent: '')
         item = addItemWithTitle('Copy Ruler', action: 'copyRuler:', keyEquivalent: 'c')
         item.keyEquivalentModifierMask = NSCommandKeyMask | NSControlKeyMask
         item = addItemWithTitle('Paste Ruler', action: 'pasteRuler:', keyEquivalent: 'v')
         item.keyEquivalentModifierMask = NSCommandKeyMask | NSControlKeyMask
      end

      addMenu('Format') do
         item = addItemWithTitle('Font', action: nil, keyEquivalent: '')
         item.submenu = NSFontManager.sharedFontManager.fontMenu(true)
         addItem textMenu
      end

      addMenu('View') do
         item = addItemWithTitle('Show Toolbar', action: 'toggleToolbarShown:', keyEquivalent: 't')
         item.keyEquivalentModifierMask = NSCommandKeyMask | NSAlternateKeyMask
         addItemWithTitle('Customize Toolbar…', action: 'runToolbarCustomizationPalette:', keyEquivalent: '')
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
