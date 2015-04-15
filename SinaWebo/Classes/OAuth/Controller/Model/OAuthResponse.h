//
//  OAuthResponse.h
//  SinaWebo
//
//  Created by Pink Elephant on 15/4/15.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface OAuthResponse : NSObject
@property (strong, nonatomic) Account *account;
@end
