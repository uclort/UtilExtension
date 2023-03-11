#
# Be sure to run `pod lib lint UtilExtension.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UtilExtension'
  s.version          = '1.0.0'
  s.summary          = 'A short description of UtilExtension.'
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  
  s.description      = <<-DESC
  TODO: Add long description of the pod here.
  DESC
  
  s.homepage         = 'https://github.com/uclort/UtilExtension'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Uclort' => 'uclort@gmail.com' }
  s.source           = { :git => 'https://github.com/uclort/UtilExtension.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/iuclort'
  s.swift_version = '5.0'
  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '11.0'
  
  s.subspec "A_AlertController" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_AlertController/**/*'
  end
  
  s.subspec "A_Application" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_Application/**/*'
  end
  
  s.subspec "A_Array" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_Array/**/*'
  end
  
  s.subspec "A_AttributedString" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_AttributedString/**/*'
  end
  
  s.subspec "A_BarItem" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_BarItem/**/*'
  end
  
  s.subspec "A_Bundle" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_Bundle/**/*'
  end
  
  s.subspec "A_Button" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_Button/**/*'
  end
  
  s.subspec "A_Character" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_Character/**/*'
  end
  
  s.subspec "A_Codable" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_Codable/**/*'
  end
  
  s.subspec "A_Collection" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_Collection/**/*'
  end
  
  s.subspec "A_CollectionView" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_CollectionView/**/*'
  end
  
  s.subspec "A_Color" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_Color/**/*'
  end
  
  s.subspec "A_Data" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_Data/**/*'
  end
  
  s.subspec "A_Date" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_Date/**/*'
  end
  
  s.subspec "A_Device" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_Device/**/*'
  end
  
  s.subspec "A_Dictionary" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_Dictionary/**/*'
  end
  
  s.subspec "A_EdgeInsets" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_EdgeInsets/**/*'
  end
  
  s.subspec "A_Error" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_Error/**/*'
  end
  
  s.subspec "A_Font" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_Font/**/*'
  end
  
  s.subspec "A_ImageView" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_ImageView/**/*'
  end
  
  s.subspec "A_Image" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_Image/**/*'
  end
  
  s.subspec "A_Label" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_Label/**/*'
  end
  
  s.subspec "A_Location" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_Location/**/*'
  end
  
  s.subspec "A_NameSpace" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_NameSpace/*'
  end
  
  s.subspec "A_NavigationBar" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_NavigationBar/**/*'
  end
  
  s.subspec "A_NavigationController" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_NavigationController/**/*'
  end
  
  s.subspec "A_Number" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_Number/**/*'
  end
  
  s.subspec "A_Object" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_Object/**/*'
  end
  
  s.subspec "A_Optional" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_Optional/**/*'
  end
  
  s.subspec "A_Screen" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_Screen/**/*'
  end
  
  s.subspec "A_SearchBar" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_SearchBar/**/*'
  end
  
  s.subspec "A_StackView" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_StackView/**/*'
  end
  
  s.subspec "A_Storyboard" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_Storyboard/**/*'
  end
  
  s.subspec "A_String" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_String/**/*'
  end
  
  s.subspec "A_TableView" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_TableView/**/*'
  end
  
  s.subspec "A_TextField" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_TextField/**/*'
  end
  
  s.subspec "A_URL" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_URL/**/*'
  end
  
  s.subspec "A_View" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_View/**/*'
  end
  
  s.subspec "A_ViewController" do |sub|
    sub.source_files = 'UtilExtension/Classes/A_ViewController/**/*'
  end
  
  s.subspec "A_Resources" do |sub|
    sub.resource_bundles = {
      'UtilExtensionResources' => ['UtilExtension/Assets/*']
    }
  end
end
