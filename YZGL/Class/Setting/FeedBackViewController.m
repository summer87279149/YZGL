//
//  FeedBackViewController.m
//  YZGL
//
//  Created by Admin on 17/3/20.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()<UITextViewDelegate>
{
    UITextView *contenText;
    UIButton *submitBtn;
    UIView *contenView;
    UILabel *wordCount;
}


@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    contenView = [[UIView alloc]init];
    contenView.backgroundColor = [UIColor jk_colorWithHexString:@"E5E5E5"];
    [self.view addSubview:contenView];
    
    contenText = [[UITextView alloc]init];
    contenText.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    contenText.layer.borderWidth = 1;
    contenText.layer.borderColor = [UIColor lightGrayColor].CGColor;
    contenText.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [contenText setScrollEnabled:YES];
    contenText.userInteractionEnabled = YES;
    contenText.showsVerticalScrollIndicator = YES;
    contenText.font = [UIFont systemFontOfSize:15];
    CGSize size = CGSizeMake(kScreenWidth, 100.0f);
    [contenText setContentSize:size];
    [contenView addSubview:contenText];
    
    wordCount = [[UILabel alloc]init];
    wordCount.font = [UIFont systemFontOfSize:12];
    [contenView addSubview:wordCount];
    
    self.navigationItem.rightBarButtonItem = [self rightButton];
    
    [contenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(kScreenHeight/2);
    }];
    
    [contenText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contenView).offset(25);
        make.left.right.bottom.mas_equalTo(contenView).offset(10);
    }];

    [wordCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contenView);
        make.centerX.mas_equalTo(contenView);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(25);
    }];
}
- (UIBarButtonItem *)rightButton
{
    CGRect buttonFrame = CGRectMake(0, 0,35, 35);
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    [button addTarget:self action:@selector(submitBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
}
- (void)submitBtnPress
{
    if(contenText.text.length==0||contenText.text==nil){
        [MBProgressHUD showError:@"请输入意见"];
    }else{
//        SHOWHUD
//        WS(weakSelf)
//        [SomeOtherRequest feedBackWithUserID:[YCUserModel userId] andSuggestion:contenText.text success:^(id response) {
//            [MBProgressHUD showSuccess:@"提交成功，感谢反馈"];
//            HIDEHUDWeakSelf
//            [weakSelf.navigationController popViewControllerAnimated:YES];
//        } error:^(id response) {
//            [MBProgressHUD showSuccess:@"提交失败，请检查网络"];
//            HIDEHUDWeakSelf
//        }];
    }
    
    
    
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if(range.location > 60){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"输入的自字符数不能超过60"
                                                       delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        return NO;
    }else{
        NSLog(@"%lu",(unsigned long)contenText.text.length);
        return YES;
    }
}


- (void)textViewDidChange:(UITextView *)textView{
    int count;
    count = 60.0 - contenText.text.length;
    [wordCount setText:[NSString stringWithFormat:@"剩余输入%d字", count]];  //_wordCount是一个显示剩余可输入数字的label
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    [UIMenuController sharedMenuController].menuVisible = NO;  //donot display the menu
    [contenText resignFirstResponder];                     //do not allow the user to selected anything
    return NO;
    
}


@end
