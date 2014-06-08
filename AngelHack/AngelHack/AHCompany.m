//
//  AHCompany.m
//  AngelHack
//
//  Created by Joao Victor Chencci Marques on 07/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import <Parse/PFObject+Subclass.h>
#import "AHCompany.h"

@implementation AHCompany

@synthesize count;

#pragma mark - Parse
+ (NSString *)parseClassName
{
    return @"Company";
}

#pragma mark - Init
- (AHCompany *)initWithName:(NSString *)name andAdmin:(AHUser *)admin
{
    AHCompany *response = [[AHCompany alloc] init];
    
    [response setName:name];
    [response setAdmin:admin];
    
    [response saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(!succeeded) {
            NSLog(@"ERROR %@", error);
        } else {
            AHUser *me = [AHUser currentUser];
            [me addCompany:response];
        }
    }];
    
    return response;
}

#pragma mark - Getters
- (NSString *)getName
{
    return self[@"name"];
}

- (AHUser *)getAdmin
{
    return (AHUser *)[self objectForKey:@"admin"];
}

- (NSInteger)memberCount
{
    NSArray *members = (NSArray *)self[@"members"];
    
    return [members count];
}

#pragma mark - Setters
- (void)setName:(NSString *)name
{
    self[@"name"]=name;
}

- (void)setAdmin:(AHUser *)admin
{
    self[@"admin"]=admin;
}

@end