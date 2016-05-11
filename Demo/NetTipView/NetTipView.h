//
//  NetTipView.h
//
//
//  Created by hukezhu on 16/5/10.
//  Copyright © 2016年 hukezhu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *
 *  直接使用这个tag值可能会有问题.因为这里是根据tag值去查找当前view中是否包含本view,如果项目中之前使用了相同的tag值,则会产生错误,
 *  所以使用之前建议在项目中全局搜索这个tag值,如果没有,直接跳过;如果有相同的可以修改这个tag值(与本项目中的不相同即可)
 */
#define kNetTipViewTag        0xeef


#define descText  @"当前网络不可用,请检查您的网络"
#define buttontitle  @"点击刷新"



typedef void (^NetTipBlock)(void);
@interface NetTipView : UIView

/**< 文字说明 */
@property (nonatomic, strong) UILabel *txtLabel;

/**< 点击的按钮 */
@property (nonatomic, strong) UIButton *button;

/**< 点击按钮的回调 */
@property (nonatomic, copy)   NetTipBlock toDoBlock;

@end


@interface UIView (NetworkError)

- (void)showNetTipViewWithToDoBlock:(NetTipBlock)block;
- (void)hideNetTipView;


@end