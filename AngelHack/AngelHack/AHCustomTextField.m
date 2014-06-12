//
//  AHCustomTextField.m
//  Mingle
//
//  Created by Marcelo Toledo on 6/12/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import "AHCustomTextField.h"

#define PLACEHOLDER_FONT_SIZE 14.0f
#define PLACEHOLDER_FONT_NAME @"HelveticaNeue-LightItalic"

@implementation AHCustomTextField

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
    self.placeholderFontSize = PLACEHOLDER_FONT_SIZE;
    self.placeholderFontName = PLACEHOLDER_FONT_NAME;
    [super awakeFromNib];
}

@end
