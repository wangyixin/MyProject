//
//  PhotosView.m
//  SinaWebo
//
//  Created by 亦心 on 15/4/3.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "PhotosView.h"
#import "PhotoView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "Photo.h"

@implementation PhotosView
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    if ([super initWithCoder:coder]) {
        [self initView];
    }
    return self;
}

-(void)initView{
    //只显示9张图片
    for (int index=0; index<9; index++) {
        PhotoView *photoView=[[PhotoView alloc]init];
        photoView.userInteractionEnabled=YES;
        photoView.tag=index;
        [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)]];
        [self addSubview:photoView];
    }
}

-(void)photoTap:(UITapGestureRecognizer *)recognizer{
    int count = (int)self.photos.count;
    
    // 1.封装图片数据
    NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        
        // 一个MJPhoto对应一张显示的图片
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        
        mjphoto.srcImageView = self.subviews[i]; // 来源于哪个UIImageView
        
        Photo *iwphoto = self.photos[i];
        NSString *photoUrl = [iwphoto.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjphoto.url = [NSURL URLWithString:photoUrl]; // 图片路径
        
        [myphotos addObject:mjphoto];
    
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = recognizer.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = myphotos; // 设置所有的图片
    [browser show];
}

-(void)setPhotos:(NSArray *)photos{
    _photos=photos;
    for (int index=0; index<9; index++) {
        PhotoView *photoView=self.subviews[index];
        if(index<photos.count){
            photoView.hidden=NO;
            //传递模型数据
            photoView.photo=photos[index];
            //设置控件的frame
            //计算最多有几列
            int maxCount=(photos.count==4)?2:3;
            int col=index%maxCount;
            int row=index/maxCount;
            CGFloat photoX=col*(kPhotoW+kMargin);
            CGFloat photoY=row*(kPhotoH+kMargin);
            photoView.frame=CGRectMake(photoX, photoY, kPhotoW, kPhotoH);
            
            if (photos.count==1) {
                // Aspect : 按照图片的原来宽高比进行缩
                // UIViewContentModeScaleAspectFit : 按照图片的原来宽高比进行缩放(一定要看到整张图片)
                // UIViewContentModeScaleAspectFill :  按照图片的原来宽高比进行缩放(只能图片最中间的内容)
                // UIViewContentModeScaleToFill : 直接拉伸图片至填充整个imageView
                photoView.contentMode=UIViewContentModeScaleAspectFit;
                photoView.clipsToBounds=NO;
            }else{
                photoView.contentMode=UIViewContentModeScaleAspectFill;
                //photoView.contentMode=UIViewContentModeScaleAspectFit;
                photoView.clipsToBounds=YES;
            }
        }else{
            photoView.hidden=YES;
        }
    }
}

+ (CGSize)photosViewSizeWithPhotosCount:(int)count{
    // 一行最多有3列
    int maxColumns = (count == 4) ? 2 : 3;
    
    //  总行数
    int rows = (count + maxColumns - 1) / maxColumns;
    // 高度
    CGFloat photosH = rows * kPhotoH + (rows - 1) * kMargin;
    
    // 总列数
    int cols = (count >= maxColumns) ? maxColumns : count;
    // 宽度
    CGFloat photosW = cols * kPhotoW + (cols - 1) * kMargin;
    
    return CGSizeMake(photosW, photosH);
    /**
     一共60条数据 == count
     一页10条 == size
     总页数 == pages
     pages = (count + size - 1)/size;
     */
}


@end
