Pod::Spec.new do |s|
  s.name             = 'PinKit.swift'
  s.module_name      = 'PinKit'
  s.version          = '1.0'
  s.summary          = 'Pin components'

  s.homepage         = 'https://github.com/horizontalsystems/component-kit-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Horizontal Systems' => 'hsdao@protonmail.ch' }
  s.source           = { git: 'https://github.com/horizontalsystems/component-kit-ios.git', tag: "#{s.version}" }
  s.social_media_url = 'http://horizontalsystems.io/'

  s.ios.deployment_target = '13.0'
  s.swift_version = '5'

  s.source_files = 'PinKit/Classes/**/*'
  s.resource_bundle = { 'PinKit' => ['PinKit/Assets/*.xcassets', 'PinKit/Assets/*.lproj/*.strings'] }

  s.dependency 'UIExtensions.swift', '~> 1.1'
  s.dependency 'ThemeKit.swift', '~> 1.0'
  s.dependency 'LanguageKit.swift', '~> 1.0'
  s.dependency 'ComponentKit.swift', '~> 1.0'
  s.dependency 'StorageKit.swift', '~> 1.0'
  s.dependency 'RxSwift'
end
