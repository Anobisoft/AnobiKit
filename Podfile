
use_frameworks!


def shared_pods
  pod 'AnobiKit', :path => './'
end

target 'AnobiKit_iOS' do
  platform :ios, '9.3'
  shared_pods
  target 'AnobiKit_Tests_iOS' do
      inherit! :search_paths
  end
end

target 'AnobiKit_watchOS' do
  platform :watchos, '3.0'
  shared_pods
end

target 'AnobiKit_watchOS_Extension' do
  platform :watchos, '3.0'
  shared_pods
end

target 'AnobiKit_tvOS' do
  platform :tvos, '9.0'
  shared_pods
  target 'AnobiKit_Tests_tvOS' do
    inherit! :search_paths
  end
end

target 'AnobiKit_macOS' do
  platform :macos, '10.12'
  shared_pods
  target 'AnobiKit_Tests_macOS' do
    inherit! :search_paths
  end
end



