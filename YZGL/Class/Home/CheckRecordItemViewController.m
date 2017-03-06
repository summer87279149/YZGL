//
//  CheckRecordItemViewController.m
//  YZGL
//
//  Created by Admin on 17/3/3.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "CheckRecordItemCell.h"
#import "CheckRecordItemViewController.h"

@interface CheckRecordItemViewController ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@end

@implementation CheckRecordItemViewController
- (instancetype)initWithType:(CheongsamBrand)CheongsamBrandType
{
    self = [super init];
    if (self) {
        self.cheongsamBrandType = CheongsamBrandType;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
}
-(void)requestData{
    switch (self.cheongsamBrandType) {
            
        case CheongsamBrandAll:{
           
        }
            break;
        case CheongsamBrandRecommand:{
            
        }
            break;
        case CheongsamBrandDomestic:{
            
        }
            break;
        case CheongsamBrandInternational:{
            
        }
            break;
    }
}
#pragma mark - tableview
-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [_tableview registerNib:[UINib nibWithNibName:@"CheckRecordItemCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CheckRecordItemCellID"];
        _tableview.tableFooterView = [UIView new];
        _tableview.emptyDataSetSource = self;
        _tableview.emptyDataSetDelegate = self;
        _tableview.estimatedRowHeight = 145;
        _tableview.rowHeight = UITableViewAutomaticDimension;
        [self.view addSubview:_tableview];
    }
    return _tableview;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CheckRecordItemCell*cell = [tableView dequeueReusableCellWithIdentifier:@"CheckRecordItemCellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - DZNEmptyDataSetSource
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *text = @"没有数据";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"此处没有更多数据了";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    
    NSString *imageName = [@"placeholder_appstore" lowercaseString];
    return [UIImage imageNamed:imageName];
    
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    NSLog(@"点击了空数据");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
