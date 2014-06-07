//
//  AHUser.m
//  AngelHack
//
//  Created by Joao Victor Chencci Marques on 07/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import "AHUser.h"

@implementation AHUser

#pragma mark - Init
- (AHUser *)initWithUsername:(NSString *)username andPassword:(NSString *)password
{
    AHUser *response = [[AHUser alloc] init];
    [response setUsername:username];
    [response setEmail:username];
    [response setPassword:password];
    
    return response;
}

@end
