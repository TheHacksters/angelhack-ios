//
//  AHBorderedColorButton.h
//  AngelHack
//
//  Created by Marcelo Toledo on 6/8/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AHBorderedColorButton : UIButton

@property (strong, nonatomic) UIColor *normalStateColor;
@property (assign, nonatomic) BOOL hasBorder;
@property (strong, nonatomic) UIColor *borderColor;

@end
