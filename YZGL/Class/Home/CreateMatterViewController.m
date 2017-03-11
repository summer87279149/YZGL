//
//  CreateMatterViewController.m
//  YZGL
//
//  Created by Admin on 17/3/7.
//  Copyright © 2017年 Admin. All rights reserved.
//


#import "LGAudioKit.h"
#import "VoiceView.h"
#import "TZImagePickerController.h"
#import "CreateMatterViewController.h"
#import "UIViewController+CameraAndPhoto.h"
#define SOUND_RECORD_LIMIT 60
#define DocumentPath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@interface CreateMatterViewController ()<TZImagePickerControllerDelegate,LGSoundRecorderDelegate,LGAudioPlayerDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) RETextItem *matterTitle;
@property (nonatomic, strong) RELongTextItem *content;
@property (strong, readwrite, nonatomic) RERadioItem *uploadPic;
@property (strong, readwrite, nonatomic) RERadioItem *uploadVoice;
@property (nonatomic, strong) REBoolItem *needSignature;

@property (nonatomic, strong) VoiceView *voiceView;
@property (nonatomic, strong) UIButton *completeBtn;
@property (nonatomic, strong) UIButton *voiceBtn;

@property (nonatomic, strong) NSMutableArray *selectedPhotos;

//录音
@property (nonatomic, strong) UIButton    *recordButton;
@property (nonatomic, weak) NSTimer *timerOf60Second;

@end

@implementation CreateMatterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布确定事项";
    [self setupview];

//    [self addVoiceView];
}
-(void)addVoiceView{
    [self.view addSubview:self.voiceView];
}
-(void)setupview{
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableview];
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Test"];
    section.headerHeight = 0;
    [self.manager addSection:section];
    //名称
    self.matterTitle = [RETextItem itemWithTitle:@"事项标题" value:nil placeholder:@"简述事项标题"];
    self.content = [RELongTextItem itemWithTitle:nil value:nil placeholder:@" 输入事项详细内容"];
    WS(weakSelf)
    self.uploadPic = [RERadioItem itemWithTitle:@"上传图片" value:@"未选择" selectionHandler:^(RERadioItem *item) {
        [weakSelf.uploadPic deselectRowAnimated:YES];
        [weakSelf addPhoto];
    }];
    self.uploadVoice = [RERadioItem itemWithTitle:@"上传语音" value:@"未选择" selectionHandler:^(RERadioItem *item) {
        [weakSelf.uploadVoice deselectRowAnimated:YES];
        [self showVoiceView];
    }];
//    self.uploadVoice = [RERadioItem itemWithTitle:@"上传语音" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
//        [weakSelf.uploadVoice deselectRowAnimated:YES];
//    }];
    
    self.voiceBtn = [self createBtnWithTag:30];
    self.uploadVoice.accessoryView = self.voiceBtn;
    self.needSignature = [REBoolItem itemWithTitle:@"需要签字" value:NO];
    [section addItem:self.matterTitle];
    [section addItem:self.content];
    [section addItem:self.uploadPic];
//    [section addItem:self.uploadVoice];
    [section addItem:self.needSignature];
    [self.view addSubview:self.completeBtn];
    self.completeBtn.frame = CGRectMake(20, CGRectGetMaxY(self.tableview.frame), kScreenWidth-40, 40);
    self.completeBtn.layer.cornerRadius = 3;
}
-(void)addPhoto{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    imagePickerVc.allowTakePicture = YES;
    imagePickerVc.allowPickingVideo = NO;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        for (UIImage *image in photos) {
            [self.selectedPhotos addObject:image];
        }
        self.uploadPic.value = [NSString stringWithFormat:@"%lu张",(unsigned long)photos.count];
        [self.uploadPic reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
-(void)completeClicked{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 录音
-(void)showVoiceView{
    self.voiceView.hidden = NO;
}
-(void)hideVoiceView{
    self.voiceView.hidden = YES;
}
-(VoiceView *)voiceView{
    if(!_voiceView){
        _voiceView = [[VoiceView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _voiceView.backgroundColor = [UIColor grayColor];
        _voiceView.start = [RACSubject subject];
        _voiceView.cancel = [RACSubject subject];
        _voiceView.confirm = [RACSubject subject];
        _voiceView.updateCancel = [RACSubject subject];
        _voiceView.updateContinue = [RACSubject subject];
        @weakify(self)
        [_voiceView.start subscribeNext:^(id x) {
            @strongify(self)
            [self startRecordVoice];
        }];
        [_voiceView.cancel subscribeNext:^(id x) {
            @strongify(self)
            [self cancelRecordVoice];
        }];
        [_voiceView.confirm subscribeNext:^(id x) {
            @strongify(self)
            [self confirmRecordVoice];
        }];
        [_voiceView.updateCancel subscribeNext:^(id x) {
            @strongify(self)
            [self updateCancelRecordVoice];
        }];
        [_voiceView.updateContinue subscribeNext:^(id x) {
            @strongify(self)
            [self updateContinueRecordVoice];
        }];
        
    }
    return _voiceView;
}
//Private Methods

/**
 *  开始录音
 */
- (void)startRecordVoice{
    __block BOOL isAllow = 0;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                isAllow = 1;
            } else {
                isAllow = 0;
            }
        }];
    }
    if (isAllow) {
        //		//停止播放
        [[LGAudioPlayer sharePlayer] stopAudioPlayer];
        //		//开始录音
        [[LGSoundRecorder shareInstance] startSoundRecord:self.view recordPath:[self recordPath]];
        //开启定时器
        if (_timerOf60Second) {
            [_timerOf60Second invalidate];
            _timerOf60Second = nil;
        }
        _timerOf60Second = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(sixtyTimeStopAndSendVedio) userInfo:nil repeats:YES];
    } else {
        
    }
}

/**
 *  录音结束
 */
- (void)confirmRecordVoice {
    if ([[LGSoundRecorder shareInstance] soundRecordTime] == 0) {
        [self cancelRecordVoice];
        return;//60s自动发送后，松开手走这里
    }
    if ([[LGSoundRecorder shareInstance] soundRecordTime] < 1.0f) {
        if (_timerOf60Second) {
            [_timerOf60Second invalidate];
            _timerOf60Second = nil;
        }
        [self showShotTimeSign];
        return;
    }
    
    [self sendSound];
    [[LGSoundRecorder shareInstance] stopSoundRecord:self.view];
    
    if (_timerOf60Second) {
        [_timerOf60Second invalidate];
        _timerOf60Second = nil;
    }
}

/**
 *  更新录音显示状态,手指向上滑动后 提示松开取消录音
 */
- (void)updateCancelRecordVoice {
    [[LGSoundRecorder shareInstance] readyCancelSound];
}

/**
 *  更新录音状态,手指重新滑动到范围内,提示向上取消录音
 */
- (void)updateContinueRecordVoice {
    [[LGSoundRecorder shareInstance] resetNormalRecord];
}

/**
 *  取消录音
 */
- (void)cancelRecordVoice {
    [[LGSoundRecorder shareInstance] soundRecordFailed:self.view];
}

/**
 *  录音时间短
 */
- (void)showShotTimeSign {
    [[LGSoundRecorder shareInstance] showShotTimeSign:self.view];
}

- (void)sixtyTimeStopAndSendVedio {
    int countDown = SOUND_RECORD_LIMIT - [[LGSoundRecorder shareInstance] soundRecordTime];
    NSLog(@"countDown is %d soundRecordTime is %f",countDown,[[LGSoundRecorder shareInstance] soundRecordTime]);
    if (countDown <= 10) {
        [[LGSoundRecorder shareInstance] showCountdown:countDown];
    }
    if ([[LGSoundRecorder shareInstance] soundRecordTime] >= SOUND_RECORD_LIMIT && [[LGSoundRecorder shareInstance] soundRecordTime] <= SOUND_RECORD_LIMIT + 1) {
        
        if (_timerOf60Second) {
            [_timerOf60Second invalidate];
            _timerOf60Second = nil;
        }
        [self.recordButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

/**
 *  语音文件存储路径
 *
 *  @return 路径
 */
- (NSString *)recordPath {
    NSString *filePath = [DocumentPath stringByAppendingPathComponent:@"SoundFile"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:&error];
        if (error) {
            NSLog(@"%@", error);
        }
    }
    return filePath;
}

- (void)sendSound {
   
}

// - LGSoundRecorderDelegate

- (void)showSoundRecordFailed{
    //	[[SoundRecorder shareInstance] soundRecordFailed:self];
    if (_timerOf60Second) {
        [_timerOf60Second invalidate];
        _timerOf60Second = nil;
    }
}

- (void)didStopSoundRecord {
    
}

// mark - LGAudioPlayerDelegate

- (void)audioPlayerStateDidChanged:(LGAudioPlayerState)audioPlayerState forIndex:(NSUInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
  
    
}
#pragma mark ------分割线--------
-(NSMutableArray*)selectedPhotos{
    if(!_selectedPhotos){
        _selectedPhotos = [NSMutableArray array];
    }
    return _selectedPhotos;
}
-(UIButton*)createBtnWithTag:(NSInteger)tag{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [btn setTitle:@"验证码" forState:UIControlStateNormal];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    btn.layer.cornerRadius = 5;
    btn.tag = tag;
    btn.titleLabel.font = [UIFont systemFontOfSize:11];
    btn.tintColor = [UIColor blackColor];
    [btn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(voiceBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.showsTouchWhenHighlighted = YES;
    return btn;
}
-(UIButton*)completeBtn{
    if(!_completeBtn){
        _completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _completeBtn.backgroundColor = [UIColor jk_colorWithHexString:@"#dd534c"];
        [_completeBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_completeBtn addTarget:self action:@selector(completeClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _completeBtn;
}
#pragma mark - tableview
-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, kScreenWidth,250) style:UITableViewStylePlain];
        _tableview.tableFooterView = [UIView new];
        [self.view addSubview:_tableview];
    }
    return _tableview;
}


@end
