//
//  AYFontManager.h
//  ChangeFontDemo
//
//  Created by hl on 17/2/14.
//  Copyright © 2017年 ay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AYFontManager : NSObject

//全局字体大小
@property(nonatomic, assign) float size;

+ (instancetype)sharedManager;

@end
