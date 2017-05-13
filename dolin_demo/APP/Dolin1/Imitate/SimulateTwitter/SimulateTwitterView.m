//
//  SimulateTwitterView.m
//  dolin_demo
//
//  Created by shaolin on 16/7/11.
//  Copyright © 2016年 shaolin. All rights reserved.
//

#import "SimulateTwitterView.h"

static CGFloat const offset_HeaderStop = 40.0;
static CGFloat const offset_B_LabelHeader = 95.0;
static CGFloat const distance_W_LabelHeader = 35.0;

static NSString* const kKeyPathName = @"contentOffset";

@interface SimulateTwitterView()

@property (strong, nonatomic) UIView *header;
@property (strong, nonatomic) UIImageView *avatarImage;
@property (strong, nonatomic) UILabel *headerLabel;
@property (strong, nonatomic) UIImageView *headerImageView;

@end

@implementation SimulateTwitterView

- (void)dealloc {
    NSLog(@"%s",__func__);
    [self.tableView removeObserver:self forKeyPath:kKeyPathName];
}

- (SimulateTwitterView *)initTableViewWithBackgound:(UIImage*)backgroundImage
                                        avatarImage:(UIImage *)avatarImage
                                        titleString:(NSString *)titleString
                                     subtitleString:(NSString *)subtitleString {
    self = [[SimulateTwitterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self setupView:backgroundImage avatarImage:avatarImage titleString:titleString subtitleString:subtitleString];
    [self.tableView addObserver:self forKeyPath:kKeyPathName options:NSKeyValueObservingOptionNew context:nil];
    return self;
}

- (void)setupView:(UIImage*)backgroundImage avatarImage:(UIImage *)avatarImage titleString:(NSString *)titleString subtitleString:(NSString *)subtitleString  {
    
    self.header = [[UIView alloc] initWithFrame:CGRectMake(self.x, self.y, self.width, 107)];
    self.header.backgroundColor = [UIColor redColor];
    [self addSubview:self.header];
    
    self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.x, self.header.height - 5, self.width, 25)];
    self.headerLabel.textAlignment = NSTextAlignmentCenter;
    self.headerLabel.text = titleString;
    self.headerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
    self.headerLabel.textColor = [UIColor whiteColor];
    [self.header addSubview:self.headerLabel];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.frame];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(self.x, self.y, self.width, self.header.height + 100)];
    [self addSubview:self.tableView];
    
    self.avatarImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 79, 69, 69)];
    self.avatarImage.image = avatarImage;
    self.avatarImage.layer.cornerRadius = 10;
    self.avatarImage.layer.borderWidth = 3;
    self.avatarImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.avatarImage.clipsToBounds = YES;

    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 156, 250, 25)];
    titleLabel.text = titleString;
    
    UILabel * subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 177, 250, 25)];
    subtitleLabel.text = subtitleString;
    subtitleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12];
    subtitleLabel.textColor = [UIColor lightGrayColor];

    [self.tableView addSubview:self.avatarImage];
    [self.tableView addSubview:titleLabel];
    [self.tableView addSubview:subtitleLabel];
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:self.header.frame];
    self.headerImageView.image = backgroundImage;
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.header insertSubview:self.headerImageView aboveSubview:self.headerLabel];
    self.header.clipsToBounds = YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:kKeyPathName]) {
        CGFloat offset = self.tableView.contentOffset.y;
        [self animationForScroll:offset];
    }
}

- (void) animationForScroll:(CGFloat) offset {
    
    CATransform3D headerTransform = CATransform3DIdentity;
    CATransform3D avatarTransform = CATransform3DIdentity;
    
    // 下拉
    if (offset < 0) {
        CGFloat headerScaleFactor = -(offset) / self.header.bounds.size.height;
        CGFloat headerSizevariation = -(offset)/2.0;
        headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0);
        headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0);
        self.header.layer.transform = headerTransform;
    }
    
    // 上拉
    else {
        // Header
        headerTransform = CATransform3DTranslate(headerTransform, 0, MAX( -offset_HeaderStop, -offset), 0);
        
        // Label
        CATransform3D labelTransform = CATransform3DMakeTranslation(0, MAX(-distance_W_LabelHeader, offset_B_LabelHeader - offset), 0);
        self.headerLabel.layer.transform = labelTransform;
        self.headerLabel.layer.zPosition = 2;
        
        // Avatar
        // Slow down the animation
        CGFloat avatarScaleFactor = (MIN(offset_HeaderStop, offset)) / self.avatarImage.bounds.size.height / 1.4;
        CGFloat avatarSizeVariation = ((self.avatarImage.bounds.size.height * (1.0 + avatarScaleFactor)) - self.avatarImage.bounds.size.height) / 2.0;
        avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0);
        avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0);
        
        if (offset <= offset_HeaderStop) {
            if (self.avatarImage.layer.zPosition <= self.headerImageView.layer.zPosition) {
                self.header.layer.zPosition = 0;
            }
        }
        else {
            if (self.avatarImage.layer.zPosition >= self.headerImageView.layer.zPosition) {
                self.header.layer.zPosition = 2;
            }
        }
    }

    self.header.layer.transform = headerTransform;
    self.avatarImage.layer.transform = avatarTransform;
}

@end
