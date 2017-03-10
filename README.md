# dolin_demo
项目启动起因：
* 平时写的一些测试demo，感觉不错的也整合进来
* 一些常用功能的封装或者觉得酷炫的东东也会放到这个demo中
* 算是学习、练习、总结吧
* 分享给大家，也希望大神给出建议（代码风格、逻辑处理、框架搭建等等）

 PS：采用CocoaPods集成第三方开源库！请正确打开项目!

***

### 目录树大概讲解
新目录树（time： 2016年11月28日15:25:48）
![目录树_new](https://github.com/liaoshaolim/dolin_demo/raw/master/Screen/project_tree_new.png)
### APP下
* base文件夹：               放一些公用的东东
* launch：                      项目启动
* DolinMacro+Constant ：宏定义与常量定义都在这边
* DolinUtility ：                 一些很棒的分类和一些自己封装的工具类
* Dolin1、2、3、4    ：     对应tabBarController的4个viewController

（1）Dolin4ViewController ：仿网易新闻标题效果
顶部标题颜色，下划线高度等的设置我提供了三种方式：
* 实例化对象后为属性赋值
* 实现代理（苹果大部分控件的设计思想）
* 通过block设置（这种方式见得不多，但是感觉这样设计对于调用者来说也挺简单）

（2）Dolin2ViewController：仿网易云音乐
使用这个可以免费下载音乐哈！！！
需要自己配置自己网易的id（不会拿的联系我哈）

### Resource
资源文件

### ThirdLibs
第三方的一些东东
如：JSPatch（这个响亮的名字以后可能就要暗淡了）

### Utilities
实用工具类
如：常量与宏的声明、定义
   自定义AlertView
   Category
   一些漂亮的类
   转场动画等

***
### APP效果图：
![效果图](https://github.com/liaoshaolim/dolin_demo/raw/master/Screen/dolin_demo.gif)
