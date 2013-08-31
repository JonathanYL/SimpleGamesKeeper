//
//  SGKNavView.h
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-07-27.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SGKNavViewDelegate <NSObject>
- (void)backButtonPressed;
@end

@interface SGKNavView : UIView

@property (nonatomic, strong) UIButton *_backButton;
@property (nonatomic, strong) UILabel *_systemName;
@property (nonatomic, strong) id <SGKNavViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame andIndex:(int)index;

@end

