Pod::Spec.new do |s|
  s.name             = 'ModuleKit.swift'
  s.module_name      = 'ModuleKit'
  s.version          = '1.0'
  s.summary          = 'UI modules'

  s.homepage         = 'https://github.com/horizontalsystems/component-kit-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Horizontal Systems' => 'hsdao@protonmail.ch' }
  s.source           = { git: 'https://github.com/horizontalsystems/component-kit-ios.git', tag: "module-kit-#{s.version}" }
  s.social_media_url = 'http://horizontalsystems.io/'

  s.ios.deployment_target = '13.0'
  s.swift_version = '5'

  s.source_files = 'ModuleKit/Classes/**/*'
  s.resource_bundle = { 'ModuleKit' => ['ModuleKit/Assets/*.xcassets', 'ModuleKit/Assets/*.lproj/*.strings'] }

  s.dependency 'UIExtensions.swift', '~> 1.1'
  s.dependency 'SectionsTableView.swift', '~> 1.1'
  s.dependency 'ComponentKit.swift', '~> 1.0'
  s.dependency 'LanguageKit.swift', '~> 1.0'
end
