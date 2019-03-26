# dolin_demo



update date：2019年03月26日20:19:32

将 

DLAnimateTransition（转场动画工具类）

DLBlockAlertView （将系统delegate回调扩展为block形式）

DLSystemPermissionsManager （系统权限管理工具类）

DolinUsefulMacros （常用的宏，与简书基本同步）

封装成 DLUtils 并上传到 CocoaPod

项目工具类依赖，通过pod处理 pod 'DLUtils', '~> 0.0.5'



Dolin2ViewController 

原本是仿网易的播放器，由于接口的调整，很多歌听不了，现直接修改为 模仿 猫弄

***

demo 内容

* 平时写的一些测试demo，感觉不错的会整合进来
* 一些常用功能的封装或者觉得酷炫的东东也会放到这个demo中
* 算是学习、练习、总结吧
* 分享给大家，也希望大神给出建议（代码风格、逻辑处理、框架搭建等等）

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
