//
//  PoperListView.m
//  SKPopverView
//
//  Created by shavekevin on 15/11/3.
//  Copyright © 2015年 shaveKevin. All rights reserved.
//

#define kArrowHeight 10.f
#define kArrowCurvature 6.f
#define kCellSpace 40.0f
#define SPACE 2.f
#define ROW_HEIGHT 44.f
#define TITLE_FONT [UIFont systemFontOfSize:16]
#define RGB(r, g, b)    [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]

#define UIColorFromRGB2(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#import "PoperListView.h"



@interface PoperListView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic) CGRect rect;

@property (nonatomic, strong) UIView *handerView;
@property (nonatomic, strong) UIButton *belowHandlerView;
@property (nonatomic, strong) UIButton *upHandlerView;

@end

@implementation MenuListItems

@end
@implementation MenuCells

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
   
    }
    return self;
}

- (void)redner {
    
    CGFloat height = 20;
    CGRect rect = CGRectMake(10, 12, height, height);
    _imageViews = [[UIImageView alloc]initWithFrame:rect];
    [self.contentView addSubview:_imageViews];
    _titles = [[UILabel alloc]initWithFrame:CGRectMake(rect.origin.x + rect.size.width + 10, 2 , self.bounds.size.height - 4, self.bounds.size.height - 4)];
    UIFont *font = [UIFont fontWithName:@"Arial" size:13];
    _titles.textAlignment = NSTextAlignmentCenter;
    _titles.font = font;
    [_titles setTextColor:UIColorFromRGB(0x333333)];
    [self.contentView addSubview:_titles];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.1;
    [self.contentView addSubview:view];
}

@end

@implementation PoperListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.borderColor = RGB(0, 0, 0);
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame MenuItems:(NSArray *)menuItems{
    self = [super init];
    if (self) {
        
        self.frame = frame;
        self.menuItems = menuItems;
        _tableview = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.scrollEnabled = NO;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = [UIColor clearColor];
        [self addSubview:self.tableview];
    }
    return self;
}



-(void)show
{
    //根据顺序添加
    self.handerView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //window 大的视图
    [_handerView setBackgroundColor:[UIColor clearColor]];
    //黑色背景
    _belowHandlerView = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect rect = CGRectMake(0, 64 , [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    [_belowHandlerView setFrame:rect];
    [_belowHandlerView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.2]];
    [_belowHandlerView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_handerView addSubview:_belowHandlerView];
    //window 大的button
    self.upHandlerView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_upHandlerView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [_upHandlerView setBackgroundColor:[UIColor clearColor]];
    [_upHandlerView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_handerView addSubview:_upHandlerView];
    [_handerView addSubview:self];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:_handerView];
    //加动画
    self.layer.anchorPoint = CGPointMake(0.5,0.5);
    self.alpha = 0.f;
    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.08f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
}

-(void)dismiss
{
    [self dismiss:NO];
}

-(void)dismiss:(BOOL)animate
{
    if (!animate) {
        [_handerView removeFromSuperview];
        return;
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [_handerView removeFromSuperview];
    }];
    
}

#pragma mark - UITableView  datasource & delegate -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    
    return _menuItems.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    MenuCells *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        
        cell = [[MenuCells alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    MenuListItems *items = [_menuItems objectAtIndex:indexPath.row];
    [cell redner];
    [cell.imageViews  setImage:items.image];
    [cell.titles setText:items.title];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuListItems *item = [_menuItems objectAtIndex:indexPath.row];
    if (self.selectRowAtIndex) {
        self.selectRowAtIndex(item);
    }
    [self dismiss:YES];
    
}


- (void)drawRect:(CGRect)rect
{
    [self.borderColor set]; //设置线条颜色
    CGRect frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - kArrowHeight);
    float xMin = CGRectGetMinX(frame);
    float yMin = CGRectGetMinY(frame);
    
    float xMax = CGRectGetMaxX(frame);
    float yMax = CGRectGetMaxY(frame);
    
    //CGPoint arrowPoint = [self convertPoint:self.showPoint fromView:_handerView];
    
    UIBezierPath *popoverPath = [UIBezierPath bezierPath];
    [popoverPath moveToPoint:CGPointMake(xMin, yMin)];//左上角
    [popoverPath addLineToPoint:CGPointMake(xMax, yMin)];//右上角
    [popoverPath addLineToPoint:CGPointMake(xMax, yMax)];//右下角
    [popoverPath addLineToPoint:CGPointMake(xMin, yMax)];//左下角
    
    //填充颜色
    [RGB(0, 0, 0) setFill];
    [popoverPath fill];
    [popoverPath closePath];
    [popoverPath stroke];
}


@end
