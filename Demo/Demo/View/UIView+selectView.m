//
//  UIView+selectView.m
//  Demo
//
//  Created by hukezhu on 16/5/11.
//  Copyright © 2016年 hukezhu. All rights reserved.
//

#import "UIView+selectView.h"

@implementation UIView (selectView)

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
