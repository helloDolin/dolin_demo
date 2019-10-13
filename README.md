# dolin_demo
### APP效果图：
![首页](https://github.com/liaoshaolim/dolin_demo/raw/master/Screen/index.png)
![音乐](https://github.com/liaoshaolim/dolin_demo/raw/master/Screen/music.png)

### 业务介绍
![音乐](https://github.com/liaoshaolim/dolin_demo/raw/master/Screen/introduce.png)

## 项目中目录大概介绍
### Utilities
 * 宏定义
 * 常量定义
 * Category
 * 转场动画工具类
 * 权限请求管理工具类

### Resource
资源文件

### ThirdLibs
第三方的一些东东
如：JSPatch（这个响亮的名字以后可能就要暗淡了）

### update date：2019年10月13日20:00:10
将 

DLAnimateTransition（转场动画工具类）

DLBlockAlertView （将系统delegate回调扩展为block形式）

DLSystemPermissionsManager （系统权限管理工具类）

DolinUsefulMacros （常用的宏，与简书基本同步）

封装成私有库 DLUtils 并上传到 CocoaPod

项目工具类依赖，通过pod处理 pod 'DLUtils', '~> 0.0.5'