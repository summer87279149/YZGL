//
//  SerachResultTableViewController.h
//  cheongsam
//
//  Created by Admin on 17/1/13.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SerachResultTableViewController : UITableViewController<UISearchResultsUpdating>
@property (nonatomic, copy) NSString *searchKeyword;
@property (nonatomic, copy) NSMutableArray *cellArray;
@end
