iOS-AcknowledgementGenerator
============================

Acknowledgement Generator is a small Ruby script for generating an Acknowledgement section in iOS Apps Settings.bundle.

**Preconditions:**  
In order to use this 'AcknowledgementGenerator' you must have the 'CFPropertyList' gem installed.  
https://rubygems.org/gems/CFPropertyList

**Setup: (Default - Customize as you see fit)**  
1. Navigate to the directory that contains your Settings.bundle  
2. Put this script into that directory  
3. Create a 'licenses' directory  
4. Put each license into that directory, one per file, with filenames that end .license  
5. Perform any necessary reformatting on the licenses. (eg. remove extra spaces at the beginning of lines, ensure that there are no line breaks mid-paragraph). There should be a blank line in-between each paragraph  
6. Run the script (ruby acknowledgementGenerator.rb)  
7. Edit your settings bundle Root.plist to include a child section called 'Acknowledgements'  

**Usage:**  
1. Open Terminal.app and navigate to the directory this script is placed in  
2. In Terminal.app execute: ruby acknowledgementGenerator.rb  
