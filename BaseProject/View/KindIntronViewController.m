//
//  KindIntronViewController.m
//  BaseProject
//
//  Created by tarena on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "KindIntronViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface KindIntronViewController ()<AVSpeechSynthesizerDelegate>
//多行编辑器，用于
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) AVSpeechSynthesizer *speed;
@property (nonatomic,strong) UIBarButtonItem *readItem;
@end

@implementation KindIntronViewController

- (UIBarButtonItem *)readItem{
    if (!_readItem) {
        _readItem = [[UIBarButtonItem alloc]bk_initWithTitle:@"朗读" style:UIBarButtonItemStyleDone handler:^(id sender) {
            if(self.speed.speaking){
                [self.speed stopSpeakingAtBoundary:AVSpeechBoundaryWord];
                return ;
            }
            AVSpeechUtterance *utt = [AVSpeechUtterance speechUtteranceWithString:_intronKind];
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

- (UITextView *)textView{
    if(!_textView){
        _textView = [UITextView new];
        _textView.font = [UIFont systemFontOfSize:18];
        //不可编辑
        _textView.editable = NO;
    }
    return _textView;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.speed stopSpeakingAtBoundary:1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.textView.text = self.intronKind;
    self.textView.contentOffset = CGPointMake(0, 0);
    
    self.navigationItem.rightBarButtonItem = self.readItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AVSpeechSynthesizerDelegate
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance{
    self.readItem.title = @"停止";
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{
    self.readItem.title = @"朗读";
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance{
    self.readItem.title = @"朗读";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
