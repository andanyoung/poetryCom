//
//  ShiListViewController.h
//  BaseProject
//
//  Created by tarena on 15/10/29.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShiListViewController : UIViewController
@property (nonatomic, strong) NSString *kind;
- (instancetype)initWithKind:(NSString *)kind;
@end

//以为UItableView 是基础风格，不带右侧详情
//变为共有，即被其他类引用，需要 .h文件中声明
@interface PoetryCell : UITableViewCell

@end

