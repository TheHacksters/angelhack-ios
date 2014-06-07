//
//  AHUtils.m
//  AngelHack
//
//  Created by Marcelo Toledo on 6/7/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import "AHUtils.h"
#import <QuartzCore/QuartzCore.h>

@implementation AHUtils

+ (UIImage *)imageFromView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    
    return viewImage;
}

@end
