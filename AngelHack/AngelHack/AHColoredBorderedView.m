//
//  AHBorderedView.m
//  AngelHack
//
//  Created by Marcelo Toledo on 6/8/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import "AHColoredBorderedView.h"

@implementation AHColoredBorderedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBorder];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setBorder];
}

- (void)setBorder
{
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.layer.borderColor = self.borderColor.CGColor;
}

@end
