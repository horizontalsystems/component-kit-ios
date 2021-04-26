Pod::Spec.new do |s|
  s.name             = 'CurrencyKit.swift'
  s.module_name      = 'CurrencyKit'
  s.version          = '1.0'
  s.summary          = 'Currency management'

  s.homepage         = 'https://github.com/horizontalsystems/component-kit-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Horizontal Systems' => 'hsdao@protonmail.ch' }
  s.source           = { git: 'https://github.com/horizontalsystems/component-kit-ios.git', tag: "language-kit-#{s.version}" }
  s.social_media_url = 'http://horizontalsystems.io/'

  s.ios.deployment_target = '13.0'
  s.swift_version = '5'

  s.source_files = 'CurrencyKit/Classes/**/*'
  s.resource_bundle = { 'CurrencyKit' => ['CurrencyKit/Assets/*.xcassets'] }

  s.dependency 'StorageKit.swift', '~> 1.0'
  s.dependency 'RxSwift', '~> 5.0'
end
