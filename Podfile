# Uncomment the next line to define a global platform for your project
platform :osx, '10.14'
inhibit_all_warnings!

target 'Queen' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'SnapKit', '~> 5.0.0'
  pod 'LeanCloud'
  pod 'Yaml'
  pod 'TKFoundationModule', :path => '/Users/niezi/Documents/framework/TKFoundationModule'
#  pod 'SavannaKit'
  pod 'Moya'
  pod 'Sparkle'
  pod 'LetsMove'

  target 'QueueTest' do
    inhibit_all_warnings
    inherit! : search_path

  end

end
