//
//  DLInterviewVC.m
//  dolin_demo
//
//  Created by 廖少林 on 2023/1/12.
//  Copyright © 2023 shaolin. All rights reserved.
//

#import "DLInterviewVC.h"

#import "DLIndexTableView.h"

/// 自定义 view 修改响应范围
@interface CustomBottomView : UIView

@property (nonatomic, strong) UIButton *btn;

@end

@implementation CustomBottomView

// override
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    // 转换 btn 坐标到 CustomView
    CGPoint btnPoint = [self.btn convertPoint:point fromView:self];
    if ([self.btn pointInside:btnPoint withEvent:event]) {
        return self.btn;
    }
    return [super hitTest:point withEvent:event];
}

@end


/// 自定义按钮，实现圆形区域交互
@interface CustomBtn : UIButton

@end

@implementation CustomBtn

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    if ([self isHidden] ||
//        self.alpha < 0.01 ||
//        !self.userInteractionEnabled) {
//        return nil;
//    }
//    if ([self pointInside:point withEvent:event]) {
//        __block UIView *hit = nil;
//        // 注意这里是倒序
//        [self.subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            CGPoint converPoint = [self convertPoint:point toView:obj];
//            hit = [obj hitTest:converPoint withEvent:event];
//            if (hit) {
//                *stop = YES;
//            }
//        }];
//        if (hit) {
//            return hit;
//        }
//        return self;
//    }
//    return nil;
//}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGFloat x1 = point.x;
    CGFloat y1 = point.y;
    
    CGFloat x2 = self.frame.size.width / 2;
    CGFloat y2 = self.frame.size.height / 2;
    
    double dis = sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
    return dis <= self.frame.size.width / 2;
}

@end

@interface DLInterviewVC ()<UITableViewDataSource,UITableViewDelegate,IndexedTableViewDataSource>

@property (nonatomic, strong) DLIndexTableView *tableView;
@property (nonatomic, strong) CustomBottomView *bottomContainerView;
@property (nonatomic, strong) CustomBtn *circleBtn;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation DLInterviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomContainerView];
    [self.bottomContainerView addSubview:self.circleBtn];
    self.bottomContainerView.btn = self.circleBtn;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.bottom.equalTo(self.bottomContainerView.mas_top).offset(0);
    }];
    
    [self.bottomContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.height.mas_offset(50);
    }];
    
    [self.circleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bottomContainerView);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.centerY.equalTo(self.bottomContainerView.mas_top);
    }];
}

- (void)buttonTap {
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indentifier = @"reuseId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    cell.textLabel.text = [[self.dataSource objectAtIndex:indexPath.row] stringValue];
    return cell;
}

- (NSArray<NSString *> *)indexTitlesForIndexTableView:(UITableView *)tableView {
    static BOOL change = NO;
    change = !change;
    if (change) {
        return @[@"A",@"B",@"C",@"D",@"E",@"F"];
    } else {
        return @[@"A",@"B",@"C"];
    }
}

- (DLIndexTableView *)tableView {
    if (!_tableView) {
        _tableView = [[DLIndexTableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 40;
        _tableView.indexedDataSource = self;
    }
    return _tableView;
}

- (CustomBtn *)circleBtn {
    if (!_circleBtn) {
        _circleBtn = [CustomBtn buttonWithType:UIButtonTypeCustom];
        [_circleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _circleBtn.backgroundColor = [UIColor systemTealColor];
        _circleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_circleBtn setTitle:@"reset" forState:UIControlStateNormal];
        [_circleBtn addTarget:self action:@selector(buttonTap) forControlEvents:UIControlEventTouchUpInside];
        _circleBtn.layer.cornerRadius = 30;
        _circleBtn.layer.masksToBounds = YES;
     }
    return _circleBtn;
}


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
        for (int i = 0;i < 100; i++) {
            [_dataSource addObject:@(i + 1)];
        }
    }
    return _dataSource;
}

- (CustomBottomView *)bottomContainerView {
    if (!_bottomContainerView) {
        _bottomContainerView = [[CustomBottomView alloc] init];
        _bottomContainerView.backgroundColor = [UIColor systemGreenColor];
    }
    return _bottomContainerView;
}

@end
