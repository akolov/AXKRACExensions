Pod::Spec.new do |s|
  s.name            = 'AXKRACExtensions'
  s.version         = '1.0.0'
  s.summary         = 'ReactiveCocoa extensions'
  s.homepage        = 'https://github.com/silverity/AXKRACExtensions'
  s.license         = 'MIT'
  s.author          = { 'Alexander Kolov' => 'me@alexkolov.com' }
  s.source          = { :git => 'https://github/com/silverity/AXKRACExtensions', :tag => s.version.to_s }
  s.platform        = :ios
  s.requires_arc    = true
  
  # Exclude optional modules

  s.default_subspec = 'Core'
  s.dependency 'ReactiveCocoa'

  # Subspecs

  s.subspec 'Core' do |cs|
    cs.source_files = 'Core'
  end

  s.subspec 'AFNetworking' do |afn|
    afn.source_files = 'AFNetworking'
    afn.dependency 'AFNetworking'
  end
  
  s.subspec 'RestKit' do |rk|
    rk.source_files = 'RestKit'
    rk.dependency 'RestKit'
  end
end
