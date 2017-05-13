//
//  AddNoteViewController.m
//  dolin_demo
//
//  Created by dolin on 2017/5/13.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "AddNoteViewController.h"

@interface AddNoteViewController ()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *addBtn;
@end

@implementation AddNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
}

- (void)layoutUI {
    [self.view addSubview:self.textField];
    [self.view addSubview:self.addBtn];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@30);
        make.top.equalTo(self.view).offset(100);
    }];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textField.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 30));
        make.centerX.equalTo(self.view);
    }];
}

- (UITextField*)textField {
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField
    }
    return _textField;
}

- (void)addBtnAction {
    if (self.textField.text.length > 0) {
        
        NSArray *myNote = [[[NSUserDefaults alloc] initWithSuiteName:SUITE_NAME] valueForKey:@"MyNote"];
        NSMutableArray *note = [NSMutableArray arrayWithArray:myNote];
        if (!note) {
            note = [NSMutableArray arrayWithCapacity:0];
        }
        [note insertObject:self.textField.text atIndex:0];
        [[[NSUserDefaults alloc] initWithSuiteName:SUITE_NAME] setValue:note forKey:@"MyNote"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UIButton*)addBtn {
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _addBtn.backgroundColor = [UIColor orangeColor];
        [_addBtn setTitle:@"添加" forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

@end
