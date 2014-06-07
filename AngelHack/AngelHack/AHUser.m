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
- (AHUser *)initWithUsername:(NSString *)username andPassword:(NSString *)password andName: (NSString *)name andBirthday: (NSString *)birthday
{
    AHUser *response = [[AHUser alloc] init];
    [response setUsername:username];
    [response setEmail:username];
    [response setPassword:password];
    [response setName:name];
    [response setBirthday:birthday];
    
    return response;
}

#pragma mark - Getters
- (NSString *)getObjectId
{
    return self[@"objectId"];
}

- (NSString *)getName
{
    return self[@"name"];
}

- (NSString *)getEmail
{
    return self[@"email"];
}

- (NSDate *)getBirthday
{
    return self[@"birthDay"];
}

- (NSArray *)getCompanies
{
    return self[@"companies"];
}

- (BOOL)isEmailVerified
{
    return [self[@"emailVerified"] boolValue];
}

#pragma mark - Setters
- (void)setName:(NSString *)name
{
    self[@"name"]=name;
}

- (void)setBirthday:(NSString *)birthday
{
    self[@"birthday"]=birthday;
}

@end
