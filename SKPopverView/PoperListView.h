//
//  PoperListView.h
//  SKPopverView
//
//  Created by shavekevin on 15/11/3.
//  Copyright © 2015年 shaveKevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuListItems : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,assign)NSInteger menuId;

@end


@interface MenuCells : UITableViewCell

@property(strong, nonatomic)UIImageView *imageViews;
@property(strong, nonatomic)UILabel *titles;

- (void)redner;

@end

@interface PoperListView : UIView

-(id)initWithFrame:(CGRect)frame MenuItems:(NSArray *)menuItems;
-(void)show;
-(void)dismiss;
-(void)dismiss:(BOOL)animated;

@property (nonatomic, copy) UIColor *borderColor;
@property (nonatomic, copy) void (^selectRowAtIndex)(MenuListItems *item);
@end
