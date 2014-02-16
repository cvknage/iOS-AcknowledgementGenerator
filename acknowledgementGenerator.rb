#!/usr/bin/env ruby
=begin

Preconditions:
In order to use this 'AcknowledgementGenerator' you must have the 'CFPropertyList' gem installed.
https://rubygems.org/gems/CFPropertyList

Setup: (Default - Customize as you see fit)
1. Navigate to the directory that contains your Settings.bundle
2. Put this script into that directory
3. Create a 'licenses' directory
4. Put each license into that directory, one per file, with filenames that end .license
5. Perform any necessary reformatting on the licenses. (eg. remove extra spaces at the beginning of lines, ensure that there are no line breaks mid-paragraph). There should be a blank line in-between each paragraph
6. Edit your settings bundle Root.plist to include a child section called 'Acknowledgements'

Usage:
1. Open Terminal.app and navigate to the directory this script is placed in
2. In Terminal.app execute: ruby acknowledgementGenerator.rb

License:
"THE BEER-WARE LICENSE" (Revision 42):
<http://www.knage.net> wrote this file. As long as you retain this notice you
can do whatever you want with this stuff. If we meet some day, and you think
this stuff is worth it, you can buy me a beer in return Christophe Vallinas Knage.

Acknowledgements:
Thanks to JosephH @ stackoverflow.
The idea for this scripe, and the setup instructions above comes from his post:
http://stackoverflow.com/questions/6428353/best-way-to-add-license-section-to-ios-settings-bundle/6453507#6453507

=end

require 'CFPropertyList'

# License
ACKNOWLEDGEMENT_GENERATOR_LICENSE = '"THE BEER-WARE LICENSE" (Revision 42):' +
'
' +
'<http://www.knage.net> wrote this file. As long as you retain this notice you ' +
'can do whatever you want with this stuff. If we meet some day, and you think ' +
'this stuff is worth it, you can buy me a beer in return Christophe Vallinas Knage.'

# Constants
SETTINGS_BUNDLE = "Settings.bundle"
LICENSE_FILE_DIR_PATH = "licenses/"
LICENSE_FILE_EXTENSION = ".license"

class AcknowledgementGenerator
    def createAcknowledgement(name, content)
        # Create a arbitrary data structure of basic data types
        acknowledgement = {
          'StringsTable' => 'ThirdPartyLicenses',
          'PreferenceSpecifiers' => [{
            'Type' => 'PSGroupSpecifier',
            'FooterText' => content
            }]
        }

        # Generate name for acknowledgement plist
        acknowledgementName = "Acknowledgement-" + name

        # Generate item for acknowledgement list
        acknowledgementListItem = {
                'Type' => 'PSChildPaneSpecifier',
                'Title' => name,
                'File' => acknowledgementName
            }

        # Create plist file
        plist = CFPropertyList::List.new
        plist.value = CFPropertyList.guess(acknowledgement)
        plist.save(SETTINGS_BUNDLE + "/" + acknowledgementName + ".plist", CFPropertyList::List::FORMAT_XML)

        # return
        acknowledgementListItem
    end

    def createAcknowledgementList(acknowledgementListItems)
        # Create a arbitrary data structure of basic data types
        acknowledgementList = {
          'StringsTable' => 'ThirdPartyLicenses',
          'PreferenceSpecifiers' => acknowledgementListItems
        }

        # Create plist file
        plist = CFPropertyList::List.new
        plist.value = CFPropertyList.guess(acknowledgementList)
        plist.save(SETTINGS_BUNDLE + "/Acknowledgements.plist", CFPropertyList::List::FORMAT_XML)
    end
end

if __FILE__ == $PROGRAM_NAME
    acknowledgementGenerator = AcknowledgementGenerator.new

    # Iterate all license files and generate coresponding acknowledgement plists
    acknowledgementListItems = Array.new
    Dir.glob(LICENSE_FILE_DIR_PATH + '*' + LICENSE_FILE_EXTENSION) do |file|
        print "Parsing: #{file.split('/').last}..."

        # Extract name
        licenseFileName = File.basename(file)
        projectName = licenseFileName.split('.').first

        # Extract license
        licenseFile = File.open(file)
        projectLicense = licenseFile.read

        # Create Acknowledgement- plist
        acknowledgementListItem = acknowledgementGenerator.createAcknowledgement(projectName, projectLicense)
        licenseFile.close
        acknowledgementListItems.push(acknowledgementListItem)

        puts "   DONE"
    end

    # Push AcknowledgementGenerator License
    acknowledgementGeneratorLicenseListItem = acknowledgementGenerator.createAcknowledgement("AcknowledgementGenerator", ACKNOWLEDGEMENT_GENERATOR_LICENSE)
    acknowledgementListItems.push(acknowledgementGeneratorLicenseListItem)
    sortedAcknowledgementListItems = acknowledgementListItems.sort_by { |item| item["Title"].downcase }

    # Create Acknowledgements plist
    print "Adding acknowledgements to " + SETTINGS_BUNDLE + "..."
    acknowledgementGenerator.createAcknowledgementList(sortedAcknowledgementListItems)
    puts "   DONE"

    # All finished
    puts ""
    puts "Acknowledgement Generator Finished."
end
