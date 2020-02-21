platform :ios, '13.2'

inhibit_all_warnings!
use_frameworks!

def shared_pods
  pod 'Alamofire'
  pod 'Firebase/Analytics'
  pod 'Fabric'
  pod 'Crashlytics'
end

target 'GeekShop' do
  shared_pods
end

target 'GeekShopUnitTests' do
  inherit! :search_paths
  shared_pods
end
