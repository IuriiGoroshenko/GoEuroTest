//
//  CDIssue.h
//  JiraGo
//
//  Created by Yurii Goroshenko on 2/29/16.
//  Copyright © 2016 Yurii Goroshenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CDComment, CDProject;

@interface CDIssue : NSObject

@property (strong, nonatomic) NSNumber *serverId;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *descriptionText;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *summary;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *projectName;

@property (strong, nonatomic) NSString *reporterAvatar;
@property (strong, nonatomic) NSString *assigneeAvatar;
@property (strong, nonatomic) NSString *reporterName;
@property (strong, nonatomic) NSString *assigneeName;


@property (assign, nonatomic) NSInteger progressTotal;
@property (assign, nonatomic) NSInteger progressProgress;
@property (assign, nonatomic) NSInteger progressPercent;

@property (strong, nonatomic) NSSet<CDComment *> *comments;
@property (strong, nonatomic) CDProject *project;

- (void)addCommentsObject:(CDComment *)value;
- (void)removeCommentsObject:(CDComment *)value;

@end
