//
//  CEDrawingDefinition.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEDrawingDefinition.h>
#import <ChartEssentials/CETools.h>

@implementation CEDrawingDefinition
{
    NSString *_drawingId;
}

- (instancetype)initWithId:(NSString *)drawingId studyId:(nonnull NSString *)studyId
{
    CEAlwaysAssert(drawingId != nil);
    CEAlwaysAssert(studyId != nil);
    
    if (self = [super init])
    {
        _drawingId = [drawingId copy];
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

@synthesize drawingId = _drawingId;
@synthesize studyId = _studyId;

@end
