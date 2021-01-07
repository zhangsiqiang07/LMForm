//
//  LMFormSelectorCell.m
//  LMForm
//
//  Created by Zhang on 2019/4/30.
//  Copyright © 2019 Maricle. All rights reserved.
//

#import "LMFormSelectorCell.h"
#import "LMPopupView.h"
#import "LMDefaultPickerView.h"
#import "UIImage+Bundle.h"

@interface LMFormSelectorCell ()

@property (nonatomic, strong) UIImageView *arrowImgView;

@end

@implementation LMFormSelectorCell

- (void)createUI
{
    [super createUI];
    
    [self.contentView addSubview:self.arrowImgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelectedAction)];
    [self.contentView addGestureRecognizer:tap];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.centerY = self.contentView.height / 2 - LM_XX_6(10);
    self.textField.frame = CGRectMake(LM_ObjDefault(self.model.margin, LM_DefautMargin) , LM_XX_6(30), LM_Screen_Width - 2 * LM_ObjDefault(self.model.margin, LM_DefautMargin), LM_XX_6(40));
    self.textField.textAlignment = NSTextAlignmentLeft;
    self.arrowImgView.frame = CGRectMake(LM_Screen_Width - LM_ObjDefault(self.model.margin, LM_DefautMargin) - LM_RightArrowWidth, 0, LM_RightArrowWidth, LM_RightArrowWidth);
    self.arrowImgView.centerY = self.textField.centerY;
}

#pragma mark - Responce

- (void)tapSelectedAction
{
    LMDefaultPickerView *pickView = [[LMDefaultPickerView alloc] initWithDataArray:self.model.selectList];
    @weakify(self)
    [LMPopupView showPopupViewWithPickView:pickView title:self.model.placeholder confirmBlock:^{
        @strongify(self)
        NSString *text = self.model.selectList[pickView.selectIndex];
        self.model.value = text;
        self.textField.text = text;
        if (self.model.valueDidChangedBlock)
        {
            self.model.valueDidChangedBlock(text);
        }
    } cancelBlock:^{
        
    }];
}

#pragma mark - Setter/Getter

- (UIImageView *)arrowImgView
{
    if (!_arrowImgView)
    {
        _arrowImgView = [[UIImageView alloc] initWithImage:[UIImage bundleImageWithNamed:@"lm_common_arrow"]];
    }
    return _arrowImgView;
}

@end
