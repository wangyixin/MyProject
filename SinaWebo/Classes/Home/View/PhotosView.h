//
//  PhotosView.h
//  SinaWebo
//
//  Created by 亦心 on 15/4/3.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosView : UIView
/**
 *  需要展示的图片(数组里面装的都是IWPhoto模型)
 */
@property (nonatomic, strong) NSArray *photos;
/**
 *  根据图片的个数返回相册的最终尺寸
 */
+ (CGSize)photosViewSizeWithPhotosCount:(int)count;

@end
