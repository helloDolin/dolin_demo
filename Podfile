platform :ios, '8.0'
#use_frameworks!个别需要用到它，比如reactiveCocoa

target 'dolin_demo' do
  pod 'AFNetworking', '~> 3.0’
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
  pod 'IQKeyboardManager'
  # 取决于你的工程如何组织，你的node_modules文件夹可能会在别的地方。
  # 请将:path后面的内容修改为正确的路径（一定要确保正确～～）。
  pod 'yoga', :path => './ReactComponent/node_modules/react-native/ReactCommon/yoga'
  pod 'React', :path => './ReactComponent/node_modules/react-native',:subspecs => [
  'Core',
  'ART',
  'RCTActionSheet',
  'RCTGeolocation',
  'RCTImage',
  'RCTNetwork',
  'RCTPushNotification',
  'RCTSettings',
  'RCTText',
  'RCTVibration',
  'RCTWebSocket',
  'RCTLinkingIOS',
  'RCTAnimation',
  'BatchedBridge',
  'DevSupport'
  
  # 添加其他你想在工程中使用的依赖。
  ]
  pod 'lottie-ios', :path => './ReactComponent/node_modules/lottie-ios'
  pod 'lottie-react-native', :path => './ReactComponent/node_modules/lottie-react-native'
end
