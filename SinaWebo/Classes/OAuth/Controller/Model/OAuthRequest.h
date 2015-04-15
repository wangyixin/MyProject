//
//  OAuthRequest.h
//  SinaWebo
//
//  Created by Pink Elephant on 15/4/15.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"

@interface OAuthRequest : BaseRequest
@property (copy, nonatomic) NSString *client_id;
@property (copy, nonatomic) NSString *client_secret;
@property (copy, nonatomic) NSString *grant_type;
@property (copy, nonatomic) NSString *code;
@property (copy, nonatomic) NSString *redirect_uri;
@end
