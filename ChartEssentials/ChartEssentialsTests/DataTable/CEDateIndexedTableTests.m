//
//  CEDateIndexedTableTests.m
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <XCTest/XCTest.h>
#import <ChartEssentials/CEDateColumn.h>
#import <ChartEssentials/CEDateIndexedTable.h>
#import <ChartEssentials/CEValueColumn.h>

@interface CEDateIndexedTableTests : XCTestCase
@end

@implementation CEDateIndexedTableTests

- (void)testDateIndexedTableBasicStructure
{
    CEDateColumn *dateColumn = [[CEDateColumn alloc] init];
    CEValueColumn *open = [[CEValueColumn alloc] init];
    CEValueColumn *high = [[CEValueColumn alloc] init];
    CEValueColumn *low = [[CEValueColumn alloc] init];
    CEValueColumn *close = [[CEValueColumn alloc] init];

    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = 2016;
    components.month = 11;
    components.day = 15;
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSTimeInterval hour = 60 * 60;
    
    NSDate *currentDate = [calendar dateFromComponents:components];

    for (NSUInteger i = 0; i < 355; ++i)
    {
        [dateColumn addObject:currentDate];
        CGFloat openValue = arc4random_uniform(50) + 100;
        [open addValue:openValue];
        [high addValue:openValue + arc4random_uniform(30)];
        [low addValue:openValue - arc4random_uniform(10)];
        [close addValue:openValue + arc4random_uniform(20)];
        
        currentDate = [currentDate dateByAddingTimeInterval:hour];
    }
    
    NSDictionary<NSString *, CEValueColumn *> *columns = @{
                                                           @"open" : open,
                                                           @"high" : high,
                                                           @"low" : low,
                                                           @"close" : close
                                                           };
    CEDateIndexedTable *dateIndexedTable = [[CEDateIndexedTable alloc] initWithDateColumn:dateColumn valueColumns:columns];
    
    XCTAssertEqual(dateIndexedTable.dateColumn, dateColumn);
    XCTAssertEqual([dateIndexedTable columnForName:@"open"], open);
    XCTAssertEqual([dateIndexedTable columnForName:@"high"], high);
    XCTAssertEqual([dateIndexedTable columnForName:@"low"], low);
    XCTAssertEqual([dateIndexedTable columnForName:@"close"], close);
}

@end
