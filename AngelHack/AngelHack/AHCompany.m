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

#pragma mark - Setters
- (void)setName:(NSString *)name
{
    self[@"name"]=name;
}

- (void)setAdmin:(AHUser *)admin
{
    self[@"admin"]=admin;
}

#pragma mark - Relation Methods
- (void)addMember:(AHUser *)user
{
    [self addObject:user forKey:@"members"];
    [self save];
}

- (void)batchInvite:(NSArray *)emailList
{
    NSMutableArray *queries = [[NSMutableArray alloc] init];
    
    for (NSString *email in emailList) {
        PFQuery *query = [PFQuery queryWithClassName:@"_User"];
        [query whereKey:@"email" equalTo:email];
        [queries addObject:query];
    }
    
    PFQuery *mainQuery = [PFQuery orQueryWithSubqueries:queries];
    NSArray *users = [mainQuery findObjects];
    
    for (AHUser *user in users) {
        [user addCompany:self];
    }
}

@end