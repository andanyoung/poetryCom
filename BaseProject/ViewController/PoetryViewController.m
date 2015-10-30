//
//  PoetryViewController.m
//  BaseProject
//
//  Created by tarena on 15/10/29.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "PoetryViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface PoeryDetailCell : UITableViewCell
@property (nonatomic,strong)UILabel *lable;
@end

@implementation PoeryDetailCell

- (UILabel *)lable{
    if (!_lable) {
        _lable = [UILabel new];
        _lable.font = [UIFont systemFontOfSize:18];
        //自动换行
        _lable.numberOfLines = 0;
    }
    return _lable;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.lable];
        [self.lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 10, 10));
        }];
    }
    return self;
}

@end

@interface PoetryViewController ()<UITableViewDelegate,UITableViewDataSource,AVSpeechSynthesizerDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIBarButtonItem *readItem;
@property (nonatomic,strong) AVSpeechSynthesizer *speed;
@end

@implementation PoetryViewController

- (UIBarButtonItem *)readItem{
    if (!_readItem) {
        _readItem = [[UIBarButtonItem alloc]bk_initWithTitle:@"朗读" style:UIBarButtonItemStyleDone handler:^(id sender) {
            if(self.speed.speaking){
                [self.speed stopSpeakingAtBoundary:AVSpeechBoundaryWord];
                return ;
            }
            AVSpeechUtterance *utt = [AVSpeechUtterance speechUtteranceWithString:_shi];
            utt.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh_CN"];
            [self.speed speakUtterance:utt];
            
        }];
    }
    return _readItem;
}

-(AVSpeechSynthesizer *)speed{
    if (!_speed) {
        _speed = [AVSpeechSynthesizer new];
        _speed.delegate = self;
    }
    return _speed;
}

- (instancetype)initWithShi:(NSString *)shi intro:(NSString *)shiIntro{
    if (self = [super init]) {
        self.shi = shi;
        self.shiIntro = shiIntro;
    }
    return self;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[PoeryDetailCell class] forCellReuseIdentifier:@"DetailCell"];
        _tableView.allowsSelection = NO;//不让点击
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.navigationItem.rightBarButtonItem = self.readItem;
    
}
#pragma mark - AVSpeechSynthesizerDelegate
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.speed stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}


- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance{
    self.readItem.title = @"停止";
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{
    self.readItem.title = @"朗读";
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance{
    self.readItem.title = @"朗读";
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @[@"诗词赏析",@"注解"][section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PoeryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" ];
    cell.lable.text = @[_shi,_shiIntro][indexPath.section];
    return cell;
}

//iOS新加入的协议
/**
 面试问题：如何提高tableView的加载速度
 协议：HeightForRow和cellForRow 执行顺序
 在执行cellForRow之前 ，table中如果有100行，那么会执行heightForRow，计算table的内容总高度，为了让右侧滚动条显示准确
 当实现estimatedHeightForRow协议以后， heightForRow方法只会当加载cell加载时才，运行
 */
//下方协议，也是通过autoLayout 实现cell高度自动匹配的关键点
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
