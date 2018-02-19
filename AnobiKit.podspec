
Pod::Spec.new do |s|

  s.name             = 'AnobiKit'
  s.version          = '0.2.7'
  s.summary          = 'AnobiKit - collection of various independent classes and categories useful to Objective-C iOS Developer.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
Description should be longer than summary.
more longer
much more longer...
                       DESC

  s.homepage     = "https://github.com/Anobisoft/AnobiKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Stanislav Pletnev" => "anobisoft@gmail.com" }
  s.social_media_url   = "https://twitter.com/Anobisoft"

#  s.platform     = :ios, "8.3"
#  When using multiple platforms
  s.ios.deployment_target = "8.3"
# s.osx.deployment_target = "10.7"
# s.watchos.deployment_target = "2.0"
# s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/Anobisoft/AnobiKit.git", :tag => "v#{s.version}" }
  s.source_files  = "AnobiKit/Classes/**/*.{h,m}"
  s.resources = "AnobiKit/Resources/*.plist"
# s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  s.framework  = "Foundation"
# s.frameworks = "SomeFramework", "AnotherFramework", "CoreData", "CoreLocation"

  s.requires_arc = true
# s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

end
