# Uncomment the next line to define a global platform for your project
platform :osx, '10.14'
inhibit_all_warnings!

target 'Queen' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'SnapKit', '~> 5.0.0'
  pod 'LeanCloud'
  pod 'Yaml'
#  pod 'TKFoundationModule', :path => '/Users/niezi/Documents/framework/TKFoundationModule'
pod 'TKFoundationModule'
#  pod 'SavannaKit'
  pod 'Moya'
  pod 'Sparkle'
  pod 'LetsMove'
  pod 'ColorizeSwift'
  pod 'ObjectMapper'
  pod 'Ansi', :git => 'https://github.com/zhuamaodeyu/Ansi.git'

  target 'QueenTests' do
    inherit! :search_paths

  end


  post_install do |installer|
    installer.pods_project.targets.each do |target|
      swift_version = '4.0'
      if swift_version
        target.build_configurations.each do |config|
          config.build_settings['SWIFT_VERSION'] = swift_version
        end
      end
    end
  end
end
