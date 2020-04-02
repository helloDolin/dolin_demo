# dolin_demo
## APP效果图：
![](https://github.com/liaoshaolim/dolin_demo/raw/master/Screen/dolin1vc.png)
![](https://github.com/liaoshaolim/dolin_demo/raw/master/Screen/dolin2vc.png)
![](https://github.com/liaoshaolim/dolin_demo/raw/master/Screen/dolin3vc.png)
![](https://github.com/liaoshaolim/dolin_demo/raw/master/Screen/dolin4vc.png)
![](https://github.com/liaoshaolim/dolin_demo/raw/master/Screen/flutter_bubble.png)

## 如何启动？
1. 切换到 /dolin_demo/my_flutter 目录下执行
        ```
        flutter packages get
        ```
2.  切换到 /dolin_demo 目录下执行
        ```
        pod insatll
        ```

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
已删除（2020年04月02日）

### update date：2019年10月13日20:00:10
将 

DLAnimateTransition（转场动画工具类）

DLBlockAlertView （将系统delegate回调扩展为block形式）

DLSystemPermissionsManager （系统权限管理工具类）

DolinUsefulMacros （常用的宏，与简书基本同步）

封装成私有库 DLUtils 并上传到 CocoaPod

项目工具类依赖，通过pod处理 pod 'DLUtils', '~> 0.0.7'

### update date：2020年04月02日
