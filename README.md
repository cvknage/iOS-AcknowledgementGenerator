iOS-AcknowledgementGenerator
============================

Acknowledgement Generator is a small Ruby script for generating an Acknowledgement section in iOS Apps Settings.bundle.

**Preconditions:**  
In order to use this 'AcknowledgementGenerator' you must have the 'CFPropertyList' gem installed.  
https://rubygems.org/gems/CFPropertyList

**Setup: (Default - Customize as you see fit)**  
1. Create a 'licenses' directory  
2. Put each license into that directory, one per file, with filenames that end .license  
3. Perform any necessary reformatting on the licenses. (eg. remove extra spaces at the beginning of lines, ensure that there are no line breaks mid-paragraph). There should be a blank line in-between each paragraph  
4. Edit your settings bundle Root.plist to include a child section called 'Acknowledgements'  

**Usage:**  
1. Open Terminal.app and navigate to the directory this script is placed in  
2. In Terminal.app execute:  

```
./acknowledgementGenerator.rb "path/to/Settings.bundle" "path/to/licenses"
```

**Execute Script At Build Time**  
If you want this script to run whenever you build your project, you can add a build phase to your target.  

1. Select your project file
2. Select the target application
3. Click the 'Build Phases' tab
4. Now from the menu select: Editor > Add Build Phase > Add Run Script Build Phase
5. Enter something like the folowing script: (modefy to suit your needs) 

```
if gem list CFPropertyList -i; then
ruby path/to/acknowledgementGenerator.rb "path/to/Settings.bundle" "path/to/licenses"
fi
```

After you have finished that, you should drag the Run Script build phase to sooner in the build process. You'll want to move it up before Compile Sources so that the updates to your Settings Bundle get compiled and copied over.


# Screenshots from the Sample App:
![Screenshot from the Sample App](https://raw.github.com/cvknage/iOS-AcknowledgementGenerator/master/SampleProject/SampleProject.png)


# Acknowledgements:
Thanks to JosephH @ stackoverflow.  
The idea for this scripe, and the setup instructions above comes from his post:  
http://stackoverflow.com/questions/6428353/best-way-to-add-license-section-to-ios-settings-bundle/6453507#6453507

# License:
Released under the BEER License. See the
[LICENSE](https://github.com/cvknage/iOS-AcknowledgementGenerator/blob/master/LICENSE)
file for more information.
