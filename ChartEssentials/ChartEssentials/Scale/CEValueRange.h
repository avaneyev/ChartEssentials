//
//  CEValueRange.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <CoreGraphics/CoreGraphics.h>
#include <math.h>

#ifndef CEValueRange_h
#define CEValueRange_h

class CEValueRange
{
private:
    CGFloat _high, _low;
    
public:
    CEValueRange(const CGFloat high, const CGFloat low) : _high(high), _low(low) {}
    CEValueRange() : _high(NAN), _low(NAN) {}
    
    inline CGFloat high() const { return _high; }
    inline CGFloat low() const { return _low; }
    
    inline bool isEmpty() const { return isnan(_high); }
    
    void addValue(CGFloat value);
    void addLowValue(CGFloat value);
    void addHighValue(CGFloat value);
    
    void addValues(const CGFloat * values, unsigned int count);
    void addLowValues(const CGFloat * values, unsigned int count);
    void addHighValues(const CGFloat * values, unsigned int count);
};


#endif /* CEValueRange_h */
