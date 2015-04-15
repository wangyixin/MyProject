//
//  HttpUtil.h
//  SinaWebo
//
//  Created by Pink Elephant on 15/4/14.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpUtil : NSObject
/**
 *  发送post请求
 *
 *  @param url    请求url
 *  @param params 请求参数
 */
+(void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *failure))failure;

/**
 *  发送get请求
 *
 *  @param url    请求url
 *  @param params 请求参数
 */
+(void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *failure))failure;

/**
 *  发送一个POST请求(上传文件数据)
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param formData  文件参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end

/**
 *  用来封装文件数据的模型
 */
@interface FormData : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;

@end
