# Uncomment this line to define a global platform for your project
platform :ios, '9.0'

inhibit_all_warnings!
use_frameworks!

target 'Dog' do
  pod 'Alamofire', '~> 4.7'
  pod 'ReactiveCocoa', '~> 7.0'
  pod 'PinLayout'
  pod 'SDWebImage', '~> 4.0'

  target 'DogTests' do
    inherit! :search_paths
    pod 'Quick', '~> 1.2.0'
    pod 'Nimble', '~> 7.0.2'
  end
end