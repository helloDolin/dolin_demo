# dolin_demo
此项目启动起因：
* 一些常用功能的封装或者觉得酷炫的东东都会放到这个demo中，算是练习、学习、总结吧
* 大家拿去看一下，相信也会有所帮助的！
* 后续准备出一个swift版本
* PS：采用CocoaPods集成第三方开源库！请正确打开项目!

***

### 目录树大概讲解
新目录树（time： 2016年11月28日15:25:48）
![目录树_new](https://github.com/liaoshaolim/dolin_demo/raw/master/Screen/project_tree_new.png)

![目录树_old](https://github.com/liaoshaolim/dolin_demo/raw/master/Screen/project_tree_old.png)

* base文件夹：               放一些公用的东东
* assets，resource：      资源文件
* launch：                      项目启动
* DolinMacro+Constant ：宏定义与常量定义都在这边
* DolinUtility ：                 一些很棒的分类和一些自己封装的工具类
* Dolin1、2、3、4    ：     对应tabBarController的4个viewController

### 下面着重说一些两个viewController
（1）Dolin4ViewController ：仿网易新闻标题效果
顶部标题颜色，下划线高度等的设置我提供了三种方式：
* 实例化对象后为属性赋值
* 实现代理（苹果大部分控件的设计思想）
* 通过block设置（这种方式见得不多，但是感觉这样设计对于调用者来说也挺简单）

（2）Dolin2ViewController：仿网易云音乐
使用这个可以免费下载音乐哈！！！
配置：如图，将id设置为你的网易云音乐id即可

![配置id](https://github.com/liaoshaolim/dolin_demo/raw/master/Screen/music_config.png)

***
### APP效果图：
![效果图](https://github.com/liaoshaolim/dolin_demo/raw/master/Screen/dolin_demo.gif)
