//
//  AYFontManager.m
//  ChangeFontDemo
//
//  Created by hl on 17/2/14.
//  Copyright © 2017年 ay. All rights reserved.
//

#import "AYFontManager.h"

@implementation AYFontManager

+ (instancetype)sharedManager {
    static AYFontManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_instance) {
            _instance = [[AYFontManager alloc] init];
        }
    });
    return _instance;
}


- (float)size {
    if (!_size) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Mode"]) {
            self.size = [[[NSUserDefaults standardUserDefaults] objectForKey:@"Mode"] floatValue];
            
        } else {
            self.size = 1;
        }
    }
    return _size;
}



@end
