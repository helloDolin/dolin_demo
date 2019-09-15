（最新）react-native bundle --entry-file index.js --bundle-output ./ios/bundle/index.ios.jsbundle --platform ios --assets-dest ./ios/bundle --dev false


打包bundle
react-native bundle --entry-file index.ios.js --bundle-output ./output/ios.jsbundle --platform ios --assets-dest ./output --dev true

react-native bundle --entry-file /Users/shaolin/Desktop/dolin_demo/ReactComponent/index.ios.js --bundle-output ./output/ios.jsbundle --platform ios --assets-dest ./output --dev true


react-native bundle [参数]
构建 js 离线包 

Options:

-h, --help                   输出如何使用的信息
--entry-file <path>          RN入口文件的路径, 绝对路径或相对路径
--platform [string]          ios 或 andorid
--transformer [string]       Specify a custom transformer to be used
--dev [boolean]              如果为false, 警告会不显示并且打出的包的大小会变小
--prepack                    当通过时, 打包输出将使用Prepack格式化
--bridge-config [string]     使用Prepack的一个json格式的文件__fbBatchedBridgeConfig 例如: ./bridgeconfig.json
--bundle-output <string>     打包后的文件输出目录, 例: /tmp/groups.bundle
--bundle-encoding [string]   打离线包的格式 可参考链接https://nodejs.org/api/buffer.html#buffer_buffer.
--sourcemap-output [string]  生成Source Map，但0.14之后不再自动生成source map，需要手动指定这个参数。例: /tmp/groups.map
--assets-dest [string]       打包时图片资源的存储路径
--verbose                    显示打包过程
--reset-cache                移除缓存文件
--config [string]            命令行的配置文件路径
