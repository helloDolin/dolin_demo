//
//  AnimationStudyVC.m
//  dolin_demo
//
//  Created by dolin on 16/8/22.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "AnimationStudyVC.h"
#import "Masonry.h"
#import "UIView+LJC.h"
#import "MMPlaceHolder.h"

@interface AnimationStudyVC ()
{
    UIView* _testView;
}
@end

@implementation AnimationStudyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self masonryStudy];
    [self animationStudy];
}

- (void)animationStudy {
    _testView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    _testView.backgroundColor = RANDOM_UICOLOR;
    
    [self.view addSubview:_testView];
    
    [self setUpBottomView];
}

- (void)setUpBottomView {
    UIView* bottomView = [UIView new];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(@50);
    }];
   
    UIButton* btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.backgroundColor = RANDOM_UICOLOR;
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setTitle:[NSString stringWithFormat:@"hi1"] forState:UIControlStateNormal];
    btn1.tag = 200;
    [btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.backgroundColor = RANDOM_UICOLOR;
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setTitle:[NSString stringWithFormat:@"hi2"] forState:UIControlStateNormal];
    btn2.tag = 201;
    [btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.backgroundColor = RANDOM_UICOLOR;
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3 setTitle:[NSString stringWithFormat:@"hi3"] forState:UIControlStateNormal];
    btn3.tag = 202;
    [btn3 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomView addSubview:btn1];
    [bottomView addSubview:btn2];
    [bottomView addSubview:btn3];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@[btn2,btn3,bottomView]);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(btn1);
    }];
    
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(btn1);
    }];
    
    [bottomView distributeSpacingHorizontallyWith:@[btn1,btn2,btn3]];
    [bottomView showPlaceHolderWithAllSubviews];
    [bottomView hidePlaceHolder];
    
}

- (void)masonryStudy {
    UIView *sv = [UIView new];
    sv.backgroundColor = [UIColor blackColor];
    [self.view addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor whiteColor];
    [sv addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sv).with.insets(UIEdgeInsetsMake(5,5,5,5));
    }];
    
    UIView *container = [UIView new];
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    int count = 10;
    
    UIView *lastView = nil;
    
    for ( int i = 1 ; i <= count ; ++i )
    {
        UIView *subv = [UIView new];
        [container addSubview:subv];
        subv.backgroundColor = RANDOM_UICOLOR;
        
        [subv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(container);
            make.height.mas_equalTo(@(20*i));
            
            if ( lastView )
            {
                make.top.mas_equalTo(lastView.mas_bottom);
            }
            else
            {
                make.top.mas_equalTo(container.mas_top);
            }
        }];
        
        lastView = subv;
    }
    
    // container这个view起到了一个中间层的作用 能够自动的计算uiscrollView的contentSize
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];

}

- (void)animate0 {
    CABasicAnimation* ba = [CABasicAnimation animationWithKeyPath:@"position"];
    ba.fromValue = [NSValue valueWithCGPoint:CGPointMake(25, 25)];
    ba.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    ba.duration = 2;
    
    ba.autoreverses = YES; // 动画结束后是否自动回到原来位置；
    ba.removedOnCompletion = NO; //动画结束后是否移除
    
    //fillMode：动画结束后的显示模式；
    //kCAFillModeForwards 保留动画结束后的位置；
    //kCAFillModeBackwards：回到动画最开始的位置。
    //注意；使用fillMode的时候必须要将removedOnCompletion致为NO
    ba.fillMode = kCAFillModeForwards;
    [_testView.layer addAnimation:ba forKey:nil];
}

- (void)animate1 {
    CAKeyframeAnimation *frameAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue* value1 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue* value2 = [NSValue valueWithCGPoint:CGPointMake(100, 200)];
    NSValue* value3 = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    
    frameAni.values = @[value1,value2,value3];
    frameAni.duration = 2;
    frameAni.removedOnCompletion = NO;
    frameAni.fillMode = kCAFillModeForwards;
    [_testView.layer addAnimation:frameAni forKey:nil];
}

- (void)animate2 {
    CATransition* transition = [CATransition animation];
    transition.duration = 2;
    
    // timingFunction：一个过渡时间的函数，有线性，先快后慢，先慢后快等等；
    transition.timingFunction = UIViewAnimationCurveEaseInOut;
    
    // type ：动画类型
    // kCATransitionFade：交叉淡化过渡
    // kCATransitionMoveIn：移动覆盖原图；
    // kCATransitionPush：新视图将旧视图推出去；
    // kCATransitionReveal：底部显出来。
    transition.type = kCATransitionPush;
    
    // 子类型。其中的枚举类型看到英文就知道是什么意思了。
    transition.subtype = kCATransitionFromBottom;
    
    //CATransition不是CAAnimation的子类，所以没有animationWithKeyPath:这个构造方法，只有CAPropertyAnimation的子类才有这个构造方法！
    [_testView.layer addAnimation:transition forKey:nil];
}


- (void)btnAction:(UIButton*)btn {
    NSInteger tag = btn.tag - 200;
    switch (tag) {
        case 0:
            [self animate0];
            break;
        case 1:
            [self animate1];
            break;
        case 2:
            [self animate2];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
