//
//  FontCell.m
//  ChangeFontDemo
//
//  Created by hl on 17/2/14.
//  Copyright © 2017年 ay. All rights reserved.
//

#import "FontCell.h"
#import "AYBaseLabel.h"

@interface FontCell()

@property (weak, nonatomic) IBOutlet AYBaseLabel *titleTextLabel;

@property (weak, nonatomic) IBOutlet AYBaseLabel *detailTiltleLabel;

@end

@implementation FontCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.detailTiltleLabel.fontSize = 14;
}


-(void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
    self.titleTextLabel.text = titleText;
}


-(void)setDetailTitleText:(NSString *)detailTitleText {
    _detailTitleText = detailTitleText;
    self.detailTiltleLabel.text = detailTitleText;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
