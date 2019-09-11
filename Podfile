# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'CoreData_Storage' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  pod 'Spring', :git => 'https://github.com/MengTo/Spring.git'
  pod 'IQKeyboardManagerSwift'
  pod 'RSKPlaceholderTextView'
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|   
    if ['IQKeyboardManagerSwift','RSKPlaceholderTextView','CropViewController'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.2'
        
      end
    end
  end
end
