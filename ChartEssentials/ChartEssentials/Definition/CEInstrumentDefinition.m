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
    NSString *_identifier;
    NSString *_caption;
}

- (instancetype)initWithId:(NSString *)identifier
{
    CEAssert(identifier != nil);
    
    if (self = [super init])
    {
        _identifier = [identifier copy];
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

@synthesize identifier = _identifier;
@synthesize caption = _caption;

@end
