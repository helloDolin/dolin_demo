//
//  GetContactsVC.m
//  dolin_demo
//
//  Created by dolin on 17/1/13.
//  Copyright © 2017年 shaolin. All rights reserved.
//

#import "GetContactsVC.h"
#import <AddressBookUI/AddressBookUI.h> //iOS8
#import <ContactsUI/ContactsUI.h>  //iOS9
#import "SVProgressHUD.h"

@interface GetContactsVC ()<CNContactPickerDelegate,ABPeoplePickerNavigationControllerDelegate>

@property (nonatomic, strong) UILabel *phoneNumLbl;
@property (nonatomic, strong) UIButton *getContactsBtn;

@end

@implementation GetContactsVC

#pragma mark - life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - method
- (void)layoutUI {
    [self.view addSubview:self.phoneNumLbl];
    [self.view addSubview:self.getContactsBtn];
    
    [self.getContactsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(104));
        make.left.equalTo(@(20));
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    [self.phoneNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_getContactsBtn.mas_right).offset(20);
        make.top.bottom.equalTo(self->_getContactsBtn);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
}
#pragma mark - event
- (void)getContactsBtnAction{
    if([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)  {
        
        // 让用户给权限,没有的话会被拒
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (status == CNAuthorizationStatusNotDetermined) {
            CNContactStore *store = [[CNContactStore alloc] init];
            [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (error) {
                    
                }else
                {
                    
                    CNContactPickerViewController * picker = [CNContactPickerViewController new];
                    picker.delegate = self;
                    picker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];//只显示手机号
                    [self presentViewController: picker  animated:YES completion:nil];
                }
            }];
        }
        
        if (status == CNAuthorizationStatusAuthorized) {//有权限时
            CNContactPickerViewController * picker = [CNContactPickerViewController new];
            picker.delegate = self;
            picker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
            [self presentViewController: picker  animated:YES completion:nil];
        }
        else {
            [SVProgressHUD showInfoWithStatus:@"您未开启通讯录权限,请前往设置中心开启"];
        }
        
    }
    else {
        __weak typeof(self)weakSelf = self;
        ABAddressBookRef bookref = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        /*kABAuthorizationStatusNotDetermined = 0,    // 未进行授权选择
         kABAuthorizationStatusRestricted,           // 未授权，且用户无法更新，如家长控制情况下
         kABAuthorizationStatusDenied,               // 用户拒绝App使用
         kABAuthorizationStatusAuthorized            // 已授权，可使用*/
        if (status == kABAuthorizationStatusNotDetermined) {
            ABAddressBookRequestAccessWithCompletion(bookref, ^(bool granted, CFErrorRef error) {
                if (error) {
                    
                }
                if (granted) {
                    NSLog(@"授权成功");
                    ABPeoplePickerNavigationController *peosonVC = [[ABPeoplePickerNavigationController alloc] init];
                    peosonVC.peoplePickerDelegate = weakSelf;
                    peosonVC.displayedProperties = @[[NSNumber numberWithInt:kABPersonPhoneProperty]];
                    [weakSelf presentViewController:peosonVC animated:YES completion:nil];
                }
            });
        }
        if (status == kABAuthorizationStatusAuthorized) {
            ABPeoplePickerNavigationController *peosonVC = [[ABPeoplePickerNavigationController alloc] init];
            peosonVC.peoplePickerDelegate = weakSelf;
            peosonVC.displayedProperties = @[[NSNumber numberWithInt:kABPersonPhoneProperty]];
            [weakSelf presentViewController:peosonVC animated:YES completion:nil];
        }
        else {
            [SVProgressHUD showInfoWithStatus:@"您未开启通讯录权限,请前往设置中心开启"];
        }
    }
}
#pragma mark - delegate
#pragma mark - 点击某个联系人的某个属性（property）时触发并返回该联系人属性（contactProperty）。  iOS 9 以后写法
//只实现该方法时，可以进入到联系人详情页面（如果predicateForSelectionOfProperty属性没被设置或符合筛选条件，如不符合会触发默认操作，即打电话，发邮件等）。
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
    NSLog(@"%@",contactProperty);
    CNContact *contact = contactProperty.contact;
    NSLog(@"givenName: %@, familyName: %@", contact.givenName, contact.familyName);
    
    if (![contactProperty.value isKindOfClass:[CNPhoneNumber class]]) {
        [SVProgressHUD showInfoWithStatus:@"请选择11位手机号"];
        return;
    }
    CNPhoneNumber *phoneNumber = contactProperty.value;
    NSString * Str = phoneNumber.stringValue;
    NSCharacterSet *setToRemove = [[ NSCharacterSet characterSetWithCharactersInString:@"0123456789"]invertedSet];
    NSString *phoneStr = [[Str componentsSeparatedByCharactersInSet:setToRemove]componentsJoinedByString:@""];
    if (phoneStr.length != 11) {
        
        [SVProgressHUD showInfoWithStatus:@"请选择11位手机号"];
        
        return;
    }
    NSLog(@"-=-=%@",phoneStr);
    
    //号码处理用于展示
    NSMutableString * str = [[NSMutableString alloc ] initWithString:phoneStr];
    [str insertString:@"-" atIndex:3];
    [str insertString:@"-" atIndex:8];
    phoneStr = str;
    
    self.phoneNumLbl.text = phoneStr ;
}
#pragma mark - ios8 选中联系人的某个属性的时候调用  7.0以下 不做考虑
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    // 获取该联系人多重属性--电话号
    ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    // 获取该联系人的名字，简单属性，只需ABRecordCopyValue取一次值
    ABMutableMultiValueRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
    NSString *name = (__bridge NSString *)(firstName);
#pragma clang diagnostic pop
    
    
    
    // 点击某个联系人电话后dismiss联系人控制器，并回调点击的数据
    [self dismissViewControllerAnimated:YES completion:^{
        // 从多重属性——电话号中取值，参数2是取点击的索引
        NSString *aPhone =  (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phoneMulti, ABMultiValueGetIndexForIdentifier(phoneMulti,identifier)) ;
        // 去掉电话号中的 "-"
        aPhone = [aPhone stringByReplacingOccurrencesOfString:@"-" withString:@"" ];
        if (aPhone.length != 11) {
            
            [SVProgressHUD showInfoWithStatus:@"请选择11位手机号"];
            
            return;
        }
        //号码赋值用于提交后台
        
        //号码处理用于展示
        NSMutableString * str = [[NSMutableString alloc ] initWithString:aPhone];
        [str insertString:@"-" atIndex:3];
        [str insertString:@"-" atIndex:8];
        aPhone = str;
        
        self.phoneNumLbl.text = aPhone;
    }];
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - getter && setter
- (UILabel*)phoneNumLbl {
    if (!_phoneNumLbl) {
        _phoneNumLbl = [[UILabel alloc]init];
        _phoneNumLbl.text = @"手机号码";
    }
    return _phoneNumLbl;
}

- (UIButton*)getContactsBtn {
    if (!_getContactsBtn) {
        _getContactsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getContactsBtn addTarget:self action:@selector(getContactsBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_getContactsBtn setTitle:@"打开通讯录" forState:UIControlStateNormal];
        _getContactsBtn.backgroundColor = RANDOM_UICOLOR;
        [_getContactsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _getContactsBtn;
}
#pragma mark - API

#pragma mark - override

@end
