//
//  CEStudyDefinition.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEStudyDefinition.h>
#import <ChartEssentials/CETools.h>

@implementation CEStudyDefinition
{
    NSString *_studyId;
}

- (instancetype)initWithId:(NSString *)studyId
{
    CEAlwaysAssert(studyId != nil);
    
    if (self = [super init])
    {
        _studyId = [studyId copy];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        // TODO: decode object contents
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    // TODO: encode object contents
}


#pragma mark - Properties

@synthesize studyId = _studyId;


@end
