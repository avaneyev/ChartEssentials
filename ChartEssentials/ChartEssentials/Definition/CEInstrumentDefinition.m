//
//  CEInstrumentDefinition.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEInstrumentDefinition.h>
#import <ChartEssentials/CETools.h>

@implementation CEInstrumentDefinition
{
    NSString *_instrumentId;
    NSString *_caption;
}

- (instancetype)initWithId:(NSString *)identifier
{
    CEAlwaysAssert(identifier != nil);
    
    if (self = [super init])
    {
        _instrumentId = [identifier copy];
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

@synthesize instrumentId = _instrumentId;
@synthesize caption = _caption;

@end
