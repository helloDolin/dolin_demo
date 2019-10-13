# dolin_demo

### update date：2019年10月13日20:00:10

将 

DLAnimateTransition（转场动画工具类）

DLBlockAlertView （将系统delegate回调扩展为block形式）

DLSystemPermissionsManager （系统权限管理工具类）

DolinUsefulMacros （常用的宏，与简书基本同步）

封装成私有库 DLUtils 并上传到 CocoaPod

项目工具类依赖，通过pod处理 pod 'DLUtils', '~> 0.0.5'



Dolin2ViewController 

网易音乐播放器，API来自我喜欢的音乐收藏，UI 模仿猫弄

***


***

### 目录树大概讲解
新目录树（time： 2016年11月28日15:25:48）
![目录树_new](https://github.com/liaoshaolim/dolin_demo/raw/master/Screen/project_tree_new.jpeg)

### APP
* base文件夹：放一些公用的东东（目前封装了UIViewController的基类）
* Dolin1、2、3、4 ：对应tabBarController的4个UIViewController（这边的命名相对来说有点随意了）
* launch：封装了启动VC（LaunchViewController）
* DolinTabBarController

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

***
### APP效果图：
![效果图](https://github.com/liaoshaolim/dolin_demo/raw/master/Screen/dolin_demo.gif)
