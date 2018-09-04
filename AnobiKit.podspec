
Pod::Spec.new do |s|

  s.name             = 'AnobiKit'
  s.version          = '0.5.3'
  s.summary          = 'AnobiKit - utilities collection useful to Objective-C iOS Developer.'

  s.description      = <<-DESC
  AnobiKit - utilities collection useful to Objective-C iOS Developer.
  ---
  AKBundle
  AKConfigManager
  AKFileManager
  AKMultipleInheritance
  AKReachability
  AKThread
  AKUUID
  AKVersion
  ---
  AKCodableObject
  AKCoreData
  AKDate
  AKDeepCopying
  AKDesign
  AKFormatters
  AKLocationManager
  AKObjectMapping
  AKSound
  AKStrings
DESC

  s.homepage     = "https://github.com/Anobisoft/AnobiKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Stanislav Pletnev" => "anobisoft@gmail.com" }
  s.social_media_url   = "https://twitter.com/Anobisoft"

  s.platform     = :ios, "8.3"
  s.source       = { :git => "https://github.com/Anobisoft/AnobiKit.git", :tag => "v#{s.version}" }
  s.source_files  = "AnobiKit/**/*.{h,m}"
  s.private_header_files = "AnobiKit/_Private/*.h"

  s.framework  = "Foundation"
  s.requires_arc = true
# s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

end
