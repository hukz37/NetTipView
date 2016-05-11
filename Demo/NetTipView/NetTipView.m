//
//  NetTipView.m
//  Demo
//
//  Created by hukezhu on 16/5/10.
//  Copyright © 2016年 hukezhu. All rights reserved.
//

#import "NetTipView.h"

@implementation NetTipView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (UILabel *)txtLabel
{
    if (!_txtLabel) {
        _txtLabel = [[UILabel alloc] init];
        _txtLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 38);
        _txtLabel.backgroundColor = [UIColor clearColor];
        _txtLabel.textColor = [UIColor lightGrayColor];
        _txtLabel.text = descText;
        _txtLabel.textAlignment = NSTextAlignmentCenter;
        _txtLabel.font = [UIFont systemFontOfSize:15];
    }
    return _txtLabel;
}

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0, 143, 38);
        _button.backgroundColor = [UIColor clearColor];
        UIColor* color = [UIColor colorWithRed: 0.937 green: 0.537 blue: 0.2 alpha: 1];
        //[color setFill];
        [_button setBackgroundColor:color];
        [_button setTitle:buttontitle forState:UIControlStateNormal];
        [_button.layer setMasksToBounds:YES];
        [_button.layer setCornerRadius:16.0];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:17];
        [_button addTarget:self
                    action:@selector(btnClick:)
          forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat contentHeight = self.txtLabel.frame.size.height+10+self.button.frame.size.height;
    
    //view在屏幕的位置(距离顶部位置)
    CGFloat topMargin = (self.bounds.size.height-contentHeight)/2 - 10;
    
    self.txtLabel.frame = CGRectMake((self.bounds.size.width-self.txtLabel.frame.size.width)/2, topMargin, self.txtLabel.frame.size.width, self.txtLabel.frame.size.height);
    self.button.frame = CGRectMake((self.bounds.size.width-self.button.frame.size.width)/2, self.txtLabel.frame.origin.y + self.txtLabel.frame.size.height+10, self.button.frame.size.width, self.button.frame.size.height);
    [self addSubview:self.txtLabel];
    [self addSubview:self.button];
}

- (void)btnClick:(UIButton *)sender
{
    if (_toDoBlock) {
        _toDoBlock();
    }
}

@end




@implementation UIView (NetworkError)


- (NetTipView *)getNetTipView
{
    UIView *view = [self getViewWithTag:kNetTipViewTag];
    
    if (view && [view isKindOfClass:[NetTipView class]]){
        
        return (NetTipView *)view;
    }
    else
    {
        return nil;
    }
}

- (void)showNetTipViewWithToDoBlock:(NetTipBlock)block
{
    NetTipView *view = [self getNetTipView];
    
    if (!view) {
        view = [[NetTipView alloc] initWithFrame:self.bounds];
        view.tag = kNetTipViewTag;
        view.toDoBlock = block;
        [self addSubview:view];
    }
}

- (void)hideNetTipView
{
    NetTipView *view = [self getNetTipView];
    
    if (view) {
        [view removeFromSuperview];
    }
}

- (BOOL)isShowingNetTipView
{
    return [self getNetTipView]?YES:NO;
}

- (UIView *)getViewWithTag:(NSInteger)tag
{
    for (UIView *view in self.subviews)
    {
        if (view.tag == tag) {
            return view;
            break;
        }
    }
    return nil;
}


@end
