//
//  AHColoredPlaceholderTextField.m
//  AngelHack
//
//  Created by Marcelo Toledo on 6/8/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import "AHColoredPlaceholderTextField.h"

@implementation AHColoredPlaceholderTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setPlaceholderColor];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setPlaceholderColor];
    if (self.placeholderFontName && self.placeholderFontSize) {
        [self setPlaceholderFont];
    }
}

- (void)setPlaceholderColor
{
    NSString *placeholder = self.attributedPlaceholder.string;
    
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:self.placeholderStringColor}];
}

- (void)setPlaceholderFont
{
    [self setValue:[UIFont fontWithName:self.placeholderFontName size:self.placeholderFontSize] forKeyPath:@"_placeholderLabel.font"];
}

@end
