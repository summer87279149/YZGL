//
//  SearchView.m
//  YZGL
//
//  Created by Admin on 17/2/27.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        MyLinearLayout *layout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Horz];
        layout.frame = CGRectMake(0, 0, kScreenWidth, frame.size.height);
        layout.gravity = MyMarginGravity_Vert_Center;
        layout.backgroundColor =RGBA(37, 37, 37, 0.5);
        [self addSubview:layout];
        UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:frame];
        searchBar.myLeftMargin = 15;
        searchBar.myHeight = 40;
        searchBar.myWidth = kScreenWidth - 75;
//        searchBar.barTintColor = [UIColor clearColor];
        searchBar.translucent = YES;
        searchBar.searchBarStyle = UISearchBarStyleMinimal;
        searchBar.barStyle = UIBarStyleBlack;
        searchBar.placeholder = @"证件名称/印章名称/签字码搜索";
        [layout addSubview:searchBar];
        UIImageView *image = [[UIImageView alloc]init];
        image.userInteractionEnabled = YES;
        image.myRightMargin = 15;
        image.myWidth = image.myHeight = 40;
        image.image = [UIImage imageNamed:@"QRCode"];
        [layout addSubview:image];
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    
}


@end
