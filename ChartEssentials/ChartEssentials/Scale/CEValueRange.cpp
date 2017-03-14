//
//  CEValueRange.cpp
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#include "CEValueRange.h"
#include <stdexcept>

void CEValueRange::addValue(CGFloat value)
{
    if (!isnan(value))
    {
        if (isnan(_high))
        {
            _high = _low = value;
        }
        else
        {
            if (value < _low)
            {
                _low = value;
            }
            else if (_high < value)
            {
                _high = value;
            }
        }
    }
}

void CEValueRange::addHighValue(CGFloat value)
{
    if (!isnan(value))
    {
        if (isnan(_high))
        {
            _high = _low = value;
        }
        else
        {
            if (_high < value) _high = value;
        }
    }
}

void CEValueRange::addLowValue(CGFloat value)
{
    if (!isnan(value))
    {
        if (isnan(_high))
        {
            _high = _low = value;
        }
        else
        {
            if (value < _low) _low = value;
        }
    }
}

void CEValueRange::addValues(const CGFloat *values, unsigned int count)
{
    if (values == NULL) throw std::invalid_argument("values");
    if (count == 0) return;
    
    while (isnan(_high) && (count > 0))
    {
        _high = _low = *values;
        values++;
        count--;
    }
    
    while (count > 0)
    {
        CGFloat value = *values;
        values++;
        count--;
        
        if (!isnan(value))
        {
            if (value < _low)
            {
                _low = value;
            }
            else if (_high < value)
            {
                _high = value;
            }
        }
    }
}

void CEValueRange::addHighValues(const CGFloat *values, unsigned int count)
{
    if (values == NULL) throw std::invalid_argument("values");
    if (count == 0) return;
    
    while (isnan(_high) && (count > 0))
    {
        _high = _low = *values;
        values++;
        count--;
    }
    
    while (count > 0)
    {
        CGFloat value = *values;
        values++;
        count--;
        if (!isnan(value) && _high < value)
        {
            _high = value;
        }
    }
}

void CEValueRange::addLowValues(const CGFloat *values, unsigned int count)
{
    if (values == NULL) throw std::invalid_argument("values");
    if (count == 0) return;
    
    while (isnan(_high) && (count > 0))
    {
        _high = _low = *values;
        values++;
        count--;
    }
    
    while (count > 0)
    {
        CGFloat value = *values;
        values++;
        count--;
        if (!isnan(value) && value < _low)
        {
            _low = value;
        }
    }
}
