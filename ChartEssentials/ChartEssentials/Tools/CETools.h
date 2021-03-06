//
//  CETools.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#ifndef ChartEssentials_WETools_h
#define ChartEssentials_WETools_h

#ifdef DEBUG
#   define CELog(fmt, ...) NSLog((@"%s |%d| " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define CELog(...)
#endif

#define THROW_ABSTRACT(info) @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%s is abstract!",  __PRETTY_FUNCTION__] userInfo:(info)]
#define THROW_NYI(info) @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%s is not yet implemented!",  __PRETTY_FUNCTION__] userInfo:(info)]
#define THROW_INCONSISTENCY(info) @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"Inconsistency in %s!",  __PRETTY_FUNCTION__] userInfo:(info)]
#define THROW_NOT_IMPLEMENTED(info) @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%s is not implemented!",  __PRETTY_FUNCTION__] userInfo:(info)]
#define THROW_INVALID_PARAMS(info) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s received invalid parameters!",  __PRETTY_FUNCTION__] userInfo:(info)]
#define THROW_INVALID_PARAM(param, info) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s received invalid %s",  __PRETTY_FUNCTION__, #param] userInfo:(info)]

#define CEAlwaysAssert(condition)                   \
do {                                                \
    BOOL conditionResult = (condition);             \
    if (!conditionResult) {                         \
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"Assertion failed in %s: %s!",  __PRETTY_FUNCTION__, #condition] userInfo:nil];   \
    }                                               \
} while (0)

#ifdef DEBUG
#define CEAssert(condition) CEAlwaysAssert(condition)
#else
#define CEAssert(condition)
#endif

#ifdef DEBUG
#define CEBug()                                     \
do {                                                \
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"BUG: unexpected operation in %s!",  __PRETTY_FUNCTION__] userInfo:nil];   \
} while (0)
#else
#define CEBug()
#endif

// Pair of macros to enter and leave the critical section
#define ENTER_CRITICAL_SECTION(object, mutex)       \
@try                                                \
{                                                   \
    pthread_mutex_lock(&(object->mutex));

#define LEAVE_CRITICAL_SECTION(object, mutex)       \
}                                                   \
@finally                                            \
{                                                   \
    pthread_mutex_unlock(&(object->mutex));         \
}

static inline BOOL _CEIsStringEqualToString(NSString *first, NSString *second)
{
    if (first == nil) return second == nil;
    return [first isEqualToString:second];
}


#endif
