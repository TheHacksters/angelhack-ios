//
//  AHBorderedColorButton.m
//  AngelHack
//
//  Created by Marcelo Toledo on 6/8/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import "AHBorderedColorButton.h"
#import "AHUtils.h"

@implementation AHBorderedColorButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.cornerRadius = self.frame.size.height / 2;
    
    if (self.hasBorder && self.layer.borderWidth > 0) {
        self.layer.borderColor = self.borderColor.CGColor;
    }
}

- (void)setNormalStateColor:(UIColor *)normalStateColor
{
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.frame];
    backgroundView.backgroundColor = normalStateColor;
    UIImage *background = [AHUtils imageFromView:backgroundView];
    [self setBackgroundImage:background forState:UIControlStateNormal];
}

@end
