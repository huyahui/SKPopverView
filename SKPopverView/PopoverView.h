//
//  PopoverView.h
//  ArrowView
//
//  Created by guojiang on 4/9/14.
//  Copyright (c) 2014年 LINAICAI. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MenuItem : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,retain)UIImage *image;
@property(nonatomic,assign)NSInteger menuId;
@end
@interface MenuCell : UICollectionViewCell
@property(strong, nonatomic)UIImageView *imageView;
@property(strong, nonatomic)UILabel *title;
@end

@interface PopoverView : UIView{
    CGFloat m_cellHeight;
    CGFloat m_cellWidth;
    NSInteger m_perLineMenuNumber;
}

-(id)initWithPoint:(CGPoint)point MenuItems:(NSArray *)menuItems;
-(id)initWithPoint:(CGPoint)point MenuItems:(NSArray *)menuItems perLineNumber:(NSInteger)perLineNumber;
-(void)show;
-(void)dismiss;
-(void)dismiss:(BOOL)animated;

@property (nonatomic, copy) UIColor *borderColor;
@property (nonatomic, copy) void (^selectRowAtIndex)(MenuItem *item);
//@property (nonatomic,assign)NSInteger perLineMenuNumber;

@end
