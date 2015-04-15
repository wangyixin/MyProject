//
//  StatusViewCell.h
//  SinaWebo
//
//  Created by 亦心 on 15/3/15.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StatusFrame;

@interface StatusViewCell : UITableViewCell
@property (nonatomic, strong) StatusFrame *statusFrame;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
