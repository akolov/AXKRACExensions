Pod::Spec.new do |s|
  s.name            = 'AXKRACExtensions'
  s.version         = '1.0.7'
  s.summary         = 'ReactiveCocoa extensions'
  s.homepage        = 'https://github.com/silverity/AXKRACExensions'
  s.license         = 'MIT'
  s.author          = { 'Alexander Kolov' => 'me@alexkolov.com' }
  s.source          = { :git => 'https://github.com/silverity/AXKRACExensions.git', :tag => s.version.to_s }
  s.platform        = :ios
  s.requires_arc    = true
  s.ios.deployment_target = '7.0'

  s.dependency 'ReactiveCocoa'
  s.dependency 'AFNetworking', '~> 1.0'
  s.dependency 'RestKit'

  s.source_files = 'Classes/*'
  s.public_header_files = 'Classes/*.h'

  s.prefix_header_contents = <<-EOS
@import Darwin.Availability;
@import Security;
@import SystemConfiguration;
@import MobileCoreServices;
EOS

end
