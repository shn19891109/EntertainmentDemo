//
//  SHNRecomendCategoryCell.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/2/28.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNRecomendCategoryCell.h"

#import "SHNRecomendCatogory.h"
@interface SHNRecomendCategoryCell ()
/** 选中时显示的指示器控件 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation SHNRecomendCategoryCell

- (void)awakeFromNib {
    // Initialization code
    
    self.backgroundColor = SHNRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = SHNRGBColor(219, 21, 26);
    
    // 当cell的selection为None时, cell被选中时, 内部的子控件就不会进入高亮状态
}

- (void)setCategory:(SHNRecomendCatogory *)category {
    _category = category;
    self.textLabel.text = category.name;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 重新调整内部textLabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}
/**
 *  可以在
 */

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : SHNRGBColor(78, 78, 78);
}

@end
