
Pod::Spec.new do |s|

  s.name             = 'AnobiKit'
  s.version          = '0.14.2'
  s.summary          = 'AnobiKit - collection of tools and extesions.'

  s.description      = <<-DESC
  AnobiKit - collection of tools and extesions.
  ---
DESC

  s.homepage     = 'https://github.com/Anobisoft/AnobiKit'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { 'Stanislav Pletnev' => 'anobisoft@gmail.com' }
  s.social_media_url   = 'https://twitter.com/Anobisoft'

  s.ios.deployment_target     = '8.3'
  s.osx.deployment_target     = '10.12'
  s.watchos.deployment_target = '3.0'
  s.tvos.deployment_target    = '9.0'
  
  s.source       = { :git => 'https://github.com/Anobisoft/AnobiKit.git', :tag => s.version.to_s }
  s.source_files  = 'AnobiKit/AnobiKit.h'
  
  s.subspec 'AKFoundation' do |ss|
      ss.source_files = 'AnobiKit/AKFoundation/**/*.{h,m,mm}'
      ss.public_header_files = 'AnobiKit/AKFoundation/**/*.h'
  end

  s.subspec 'UIKit' do |ss|
      ss.ios.deployment_target     = '8.3'
      ss.watchos.deployment_target = '3.0'
      ss.tvos.deployment_target    = '9.0'
      ss.dependency 'AnobiKit/AKFoundation'
      ss.source_files = 'AnobiKit/UIKit/*.{h,m,mm}'
      ss.public_header_files = 'AnobiKit/UIKit/*.h'
  end
  
  s.subspec 'AKCoding' do |ss|
      ss.dependency 'AnobiKit/AKFoundation'
      ss.source_files = 'AnobiKit/AKCoding/**/*.{h,m,mm}'
      ss.public_header_files = 'AnobiKit/AKCoding/*.h'
  end
  
  s.subspec 'AKList' do |ss|
      ss.dependency 'AnobiKit/AKFoundation'
      ss.source_files = 'AnobiKit/AKList/**/*.{h,m,mm}'
      ss.public_header_files = 'AnobiKit/AKList/*.h'
  end
  
  s.subspec 'AKReachability' do |ss|
      ss.source_files = 'AnobiKit/AKReachability/**/*.{h,m,mm}'
      ss.public_header_files = 'AnobiKit/AKReachability/*.h'
  end
  
  s.subspec 'AKLocation' do |ss|
      ss.ios.deployment_target     = '8.3'
      ss.watchos.deployment_target = '3.0'
      ss.osx.deployment_target     = '10.12'
      ss.dependency 'AnobiKit/AKFoundation'
      ss.source_files = 'AnobiKit/AKLocation/**/*.{h,m,mm}'
      ss.public_header_files = 'AnobiKit/AKLocation/*.h'
      ss.private_header_files = 'AnobiKit/AKLocation/Private/*.h'
      ss.frameworks = 'CoreLocation'
  end
  
  s.subspec 'AKStrings' do |ss|
      ss.dependency 'AnobiKit/AKFoundation'
      ss.source_files = 'AnobiKit/AKStrings/**/*.{h,m,mm}'
      ss.public_header_files = 'AnobiKit/AKStrings/*.h'
  end
  
  s.subspec 'AKFormatters' do |ss|
      ss.source_files = 'AnobiKit/AKFormatters/**/*.{h,m,mm}'
      ss.public_header_files = 'AnobiKit/AKFormatters/*.h'
  end
  
  s.subspec 'AKCoreData' do |ss|
      ss.source_files = 'AnobiKit/AKCoreData/**/*.{h,m,mm}'
      ss.public_header_files = 'AnobiKit/AKCoreData/*.h'
  end
  
  
  s.frameworks = 'Foundation'
  s.requires_arc = true
  
#  s.test_spec 'Tests' do |test_spec|
#      test_spec.source_files = 'Tests/*.{h,m}'
#  end

end
