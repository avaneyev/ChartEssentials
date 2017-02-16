//
//  CEImageTools.h
//  ChartEssentials
//
//  Created by Anton Vaneev.
//  Copyright (c) 2017-present, Anton Vaneev. All rights reserved.
//
//  Distributed under BSD license. See LICENSE for details.
//

#import <ChartEssentials/CEPlatformDefinitions.h>

#if !defined CE_IMAGE_TOOLS_H
#define CE_IMAGE_TOOLS_H

CEImage *_CEMaskedImageWithOverlayColor(CEImage *mask, CEColor *color);

#endif
