//
//  AHColoredPlaceholderTextField.h
//  AngelHack
//
//  Created by Marcelo Toledo on 6/8/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AHColoredPlaceholderTextField : UITextField

@property (strong, nonatomic) UIColor *placeholderStringColor;
@property (strong, nonatomic) NSString *placeholderFontName;
@property (assign, nonatomic) CGFloat placeholderFontSize;

@end
