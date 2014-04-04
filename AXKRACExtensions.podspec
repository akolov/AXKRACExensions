Pod::Spec.new do |s|
  s.name            = 'AXKRACExtensions'
  s.version         = '1.0.0'
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
    cs.source_files = 'Core'
    cs.requires_arc = true
  end

  s.subspec 'AFNetworking' do |afn|
    afn.source_files = 'AFNetworking'
    afn.requires_arc = true
    afn.dependency 'AFNetworking'
  end
  
  s.subspec 'RestKit' do |rk|
    rk.source_files = 'RestKit'
    rk.requires_arc = true
    rk.dependency 'RestKit'
  end
end
