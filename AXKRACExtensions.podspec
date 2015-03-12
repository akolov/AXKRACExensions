Pod::Spec.new do |s|
  s.name            = 'AXKRACExtensions'
  s.version         = '1.0.5'
  s.summary         = 'ReactiveCocoa extensions'
  s.homepage        = 'https://github.com/silverity/AXKRACExensions'
  s.license         = 'MIT'
  s.author          = { 'Alexander Kolov' => 'me@alexkolov.com' }
  s.source          = { :git => 'https://github.com/silverity/AXKRACExensions.git', :tag => s.version.to_s }
  s.platform        = :ios
  s.requires_arc    = true
  s.ios.deployment_target = '7.0'

  s.default_subspec = 'Core'
  s.dependency 'ReactiveCocoa'

  # Subspecs

  s.subspec 'Core' do |cs|
    cs.source_files = 'Classes/NSNotificationCenter+AXKRACExtensions.h'
    cs.public_header_files 'Classes/NSNotificationCenter+AXKRACExtensions.h'
    cs.requires_arc = true
  end

  s.subspec 'AFNetworking' do |afn|
    afn.source_files = 'Classes/AF*'
    afn.public_header_files = 'Classes/AF*.h'
    afn.requires_arc = true
    afn.dependency 'AFNetworking', '~> 1.0'
  end

  s.subspec 'RestKit' do |rk|
    rk.source_files = 'Classes/RK*'
    rk.public_header_files = 'Classes/RK*.h'
    rk.requires_arc = true
    rk.dependency 'RestKit'
  end

  s.prefix_header_contents = <<-EOS
@import Darwin.Availability;
@import Security;
@import SystemConfiguration;
@import MobileCoreServices;
EOS

end
