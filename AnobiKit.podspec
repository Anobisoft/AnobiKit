
Pod::Spec.new do |s|

  s.name             = 'AnobiKit'
  s.version          = '0.6.0'
  s.summary          = 'AnobiKit - utilities collection useful to Objective-C iOS Developer.'

  s.description      = <<-DESC
  AnobiKit - utilities collection useful to Objective-C iOS Developer.
  ---
DESC

  s.homepage     = 'https://github.com/Anobisoft/AnobiKit'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { 'Stanislav Pletnev' => 'anobisoft@gmail.com' }
  s.social_media_url   = 'https://twitter.com/Anobisoft'

  s.platform     = :ios, '8.3'
  s.source       = { :git => 'https://github.com/Anobisoft/AnobiKit.git', :tag => 'v#{s.version}' }
  s.source_files  = 'AnobiKit/**/*.{h,m}'
  
  s.subspec 'AKDesign' do |ss|
      ss.source_files = 'AKDesign/**/*.{h,m,mm}'
      ss.public_header_files = 'AKDesign/*.h'
  end
  
  s.subspec 'AKDeepCopying' do |ss|
      ss.source_files = 'AKDeepCopying/**/*.{h,m,mm}'
      ss.public_header_files = 'AKDeepCopying/*.h'
  end
  
  s.subspec 'AKApplication' do |ss|
      ss.source_files = 'AKApplication/**/*.{h,m,mm}'
      ss.public_header_files = 'AKApplication/*.h'
  end
  
  s.subspec 'AKCoding' do |ss|
      ss.dependency 'AnobiKit/AKDeepCopying'
      ss.source_files = 'AKCoding/**/*.{h,m,mm}'
      ss.public_header_files = 'AKCoding/*.h'
  end
  
  s.subspec 'AKLocation' do |ss|
      ss.source_files = 'AKLocation/**/*.{h,m,mm}'
      ss.public_header_files = 'AKLocation/*.h'
      ss.private_header_files = 'AKLocation/Private/*.h'
      ss.frameworks = 'CoreLocation'
  end
  
  s.subspec 'AKCoreData' do |ss|
      ss.source_files = 'AKCoreData/**/*.{h,m,mm}'
      ss.public_header_files = 'AKCoreData/*.h'
  end
  
  s.subspec 'AKStrings' do |ss|
      ss.source_files = 'AKStrings/**/*.{h,m,mm}'
      ss.public_header_files = 'AKStrings/*.h'
  end
  
  s.subspec 'AKFormatters' do |ss|
      ss.source_files = 'AKFormatters/**/*.{h,m,mm}'
      ss.public_header_files = 'AKFormatters/*.h'
  end
  
  s.frameworks = 'Foundation'
  s.requires_arc = true

end
