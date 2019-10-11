flutter_application_path = './flutter_module/'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

platform :ios, '9.0'

target 'dolin_demo' do
  # Comment the next line if you don't want to use dynamic frameworks
  # use_frameworks! 个别需要用到它，比如reactiveCocoa
  
  # Flutter module
  install_all_flutter_pods(flutter_application_path)
  
  # Pods for
  pod 'AFNetworking', '~> 3.0'
  pod 'SDWebImage','~> 4.0'
  pod 'Masonry','~> 1.1.0'
  pod 'YYText', '~> 1.0.7'
  pod 'SVProgressHUD', '~> 2.2.5'
  pod 'FMDB','~> 2.7.5'
  pod 'MJRefresh', '~> 3.1.15.7'
  pod 'MJExtension', '~> 3.0.15.1'
  pod 'DLUtils', '~> 0.0.7'
  pod 'FDFullscreenPopGesture', '~> 1.1'
  pod 'YYModel'
  pod 'FreeStreamer', '~> 3.9.3'
  pod 'IQKeyboardManager'
  pod 'LYEmptyView'
  # DoraemonKit
  pod 'DoraemonKit/Core', '~> 1.1.7', :configurations => ['Debug']
  pod 'DoraemonKit/WithLogger', '~> 1.1.7', :configurations => ['Debug']
  pod 'DoraemonKit/WithGPS', '~> 1.1.7', :configurations => ['Debug']
  pod 'DoraemonKit/WithLoad', '~> 1.1.7', :configurations => ['Debug']
end

target 'TableKit' do
  # Comment the next line if you don't want to use dynamic frameworks
  # use_frameworks!

  # Pods for TableKit

end

target 'TodayWidget' do
  # Comment the next line if you don't want to use dynamic frameworks
  # use_frameworks!

  # Pods for TodayWidget

end
