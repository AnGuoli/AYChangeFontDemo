//
//  AYBaseLabel.m
//  ChangeFontDemo
//
//  Created by hl on 17/2/14.
//  Copyright © 2017年 ay. All rights reserved.
//

#import "AYBaseLabel.h"
#import "AYFontManager.h"

@implementation AYBaseLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    if (!_fontSize) {
        _fontSize = 18;
    }
    float sizeScale = [AYFontManager sharedManager].size;
    self.font = [UIFont systemFontOfSize:sizeScale * _fontSize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFont:) name:@"changeFont" object:nil];
    
}

- (void)setFontSize:(float)fontSize {
    _fontSize = fontSize;
    float sizeScale = [AYFontManager sharedManager].size;
    
    if (_fontSize > 30) {
        self.font = [UIFont boldSystemFontOfSize:sizeScale * (_fontSize - 30)];
    }else {
        self.font = [UIFont systemFontOfSize:sizeScale * _fontSize];
    }
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setNeedsLayout];
}

- (void)changeFont:(NSNotification *)notification{
    float sizeScale = [AYFontManager sharedManager].size;
    if (_fontSize > 30) {
        self.font = [UIFont boldSystemFontOfSize:sizeScale * (_fontSize - 30)];
    }else {
        self.font = [UIFont systemFontOfSize:sizeScale * _fontSize];
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeFont" object:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
