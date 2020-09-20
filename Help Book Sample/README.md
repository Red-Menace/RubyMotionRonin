## Application Help Book Sample

After much Googling, cussing, application bundle spelunking, restarts, more cussing, more Googling, fighting the markdown editor, and straightening out my keyboard after finding all the scattered keys, I managed to figure out a lot of this stuff.  It doesn't help that every application does it differently, and every other article out there that says "this is wrong" - is wrong.

It also doesn't help that there can be multiple locations for help book resources (local, common, internet, etc) and many ways to implement it (including multimedia and scripting resources) - this example just uses a simple local help book bundle.  Apple really needs to get rid of all those circular references and fill in the missing blanks - you know, clean up their documentation (and in some cases, just provide some).

This help book sample uses a generic structure and includes some example files, here are the steps that were used to create it:

<ul>
<li>
Create a folder structure for the help book and add some content:  
    
<pre>
AppName/ [1]
   Contents/
      Info.plist [2]
      Resources/
         Shared/ [3]
            help.css [4]
            help-icon.png [4]
         en.lproj/ [5]
            help.helpindex [8]
            index.html[6]
            page01.html [7]
            page02.html [7]
</pre>
</li>

<ol>
<li>
Use whatever name you want. After everything is done, you will be giving it a <code>.help</code> extension to change the folder into a help book bundle - in the sample, I've used a pipe as a placeholder for the extension period.
</li>

<li>
This property list file contains keys that define stuff used by the help system:

<pre>
&lt;!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
&lt;plist version="1.0">
   &lt;dict>
      &lt;key>CFBundleDevelopmentRegion&lt;/key>    &lt;? the base language localization ?>
      &lt;string>en&lt;/string>
      &lt;key>CFBundleIdentifier&lt;/key>           &lt;? the identifier for your help book ?>
      &lt;string>com.your-company.appname.help&lt;/string>
      &lt;key>CFBundleInfoDictionaryVersion&lt;/key>
      &lt;string>6.0&lt;/string>
      &lt;key>CFBundlePackageType&lt;/key>
      &lt;string>BNDL&lt;/string>
      &lt;key>CFBundleShortVersionString&lt;/key>   &lt;? a version number for the help book ?>
      &lt;string>1.0.0&lt;/string>
      &lt;key>CFBundleSignature&lt;/key>
      &lt;string>hbwr&lt;/string>
      &lt;key>CFBundleVersion&lt;/key>              &lt;? a build number for the help book ?>
      &lt;string>1.000&lt;/string>
      &lt;key>HPDBookAccessPath&lt;/key>            &lt;? the name of the main/landing page in .lproj ?>
      &lt;string>index.html&lt;/string>
      &lt;key>HPDBookIconPath&lt;/key>              &lt;? the icon file path relative to Resources ?>
      &lt;string>Shared/help-icon.png&lt;/string>
      &lt;key>HPDBookIndexPath&lt;/key>             &lt;? the name of the index file in .lproj ?>
      &lt;string>help.helpindex&lt;/string>
      &lt;key>HPDBookTitle&lt;/key>                 &lt;? the title of the help book ?>
      &lt;string>AppName Help&lt;/string>
      &lt;key>HPDBookType&lt;/key>
      &lt;string>3&lt;/string>
   &lt;/dict>
&lt;/plist>
</pre>

</li>

<li>
Add a shared folder for common resources that won't need localizing.
</li>

<li>
Include shared resources such as style sheets and image files as needed.
</li>

<li>
Add folders for the various localizations you are providing.  The ISO 639-1 codes for some of the most spoken languages are:

<pre>
    English     en
    Chinese     zh
    Hindi       hi
    Spanish     es
    Arabic      ar
    Indonesian  id
    Russian     ru
    Bengali     bn
    Portugese   pt
    French      fr
    German      de
    Japanese    ja
</pre>

<li>
The main/landing page as specified in the <strong>Info.plist</strong> - for the sample I am using <code>index.html</code> (HTML 4.01 - HTML5)
</li>

<li>
Additional pages as desired (HTML 4.01 - HTML5)
</li>

<li>
Once the help pages are built, use <code>hiutil</code> or the <strong>Help Indexer</strong> application (from the <strong>Xcode Additional Tools</strong> download) to generate an index file.  You can leave it with the default name (the localization folder) or give it a name of your choosing, just use the same name as the one set in the <strong>Info.plist</strong> - for the sample I have renamed the index file to <code>help.helpindex</code>.
</li>
</ol>

<li>
Move a copy of the help folder into your project resources folder, make any last minute tweaks, and give the folder name a <code>.help</code> extension (for the sample, replace the pipe with a period). The icon will change to that of a help book, and it can be double-clicked to be displayed using the system <strong>Help Viewer</strong>.  The bundle can still be accessed by using "Show Package Contents".
</li>

<li>
To include the help book in your project, place it into the <strong>Resources</strong> folder and add keys to the application <strong>Info.plist</strong> for it in your project <strong>Rakefile</strong>:

<pre>
app.info_plist['CFBundleHelpBookFolder'] = 'AppName.help'  # the name of the help package
app.info_plist['CFBundleHelpBookName'] = 'com.your-company.appname.help'  # the help bundle ID
</pre>
</li>

<li>
Cross your fingers
</li>
</ul>

Note that the help books are cached, so after making any changes, you should update the version number(s) to get the system to notice and reload your book  - hopefully you won't have to nuke the **helpd** and **helpviewer** caches.


Remember that page titles and descriptions from your help book pages can show up in a search from any application that uses the help system (Help Viewer, help menu, etc), so choose appropriate text.

[Apple Help Programming Guide](https://developer.apple.com/library/archive/documentation/Carbon/Conceptual/ProvidingUserAssitAppleHelp/user_help_intro/user_assistance_intro.html)


