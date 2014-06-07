//
//  AHEvent.m
//  AngelHack
//
//  Created by Joao Victor Chencci Marques on 07/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import <Parse/PFObject+Subclass.h>
#import "AHEvent.h"

@implementation AHEvent

#pragma mark - Parse
+ (NSString *)parseClassName
{
    return @"Event";
}

@end
