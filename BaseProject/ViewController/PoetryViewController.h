//
//  PoetryViewController.h
//  BaseProject
//
//  Created by tarena on 15/10/29.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PoetryViewController : UIViewController

- (instancetype)initWithShi:(NSString *)shi intro:(NSString *)shiIntro;

@property (nonatomic,strong) NSString *shi;
@property (nonatomic,strong) NSString *shiIntro;
@end
