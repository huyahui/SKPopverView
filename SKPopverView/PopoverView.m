//
//  PopoverView.m
//  ArrowView
//
//  Created by guojiang on 4/9/14.
//  Copyright (c) 2014年 LINAICAI. All rights reserved.
//



#import "PopoverView.h"


#define kArrowHeight 10.f
#define kArrowCurvature 6.f
#define kCellSpace 40.0f
#define SPACE 2.f
#define ROW_HEIGHT 44.f
#define TITLE_FONT [UIFont systemFontOfSize:16]
#define RGB(r, g, b)    [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]

#define UIColorFromRGB2(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface PopoverView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic) CGPoint showPoint;

@property (nonatomic, strong) UIView *handerView;
@property (nonatomic, strong) UIButton *belowHandlerView;
@property (nonatomic, strong) UIButton *upHandlerView;

@end

@implementation MenuItem

@end

@implementation MenuCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat height = 50;
        //CGRect rect = CGRectMake(10, 5, self.contentView.frame.size.width - 20, self.contentView.frame.size.width - 20);
        CGRect rect = CGRectMake((self.contentView.frame.size.width - height)/2, 15, height, height);
        _imageView = [[UIImageView alloc]initWithFrame:rect];
        [self.contentView addSubview:_imageView];
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageView.frame.origin.y + _imageView.frame.size.height + 8, self.contentView.frame.size.width, 16)];
        UIFont *font = [UIFont fontWithName:@"Arial" size:13];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = font;
        [_title setTextColor:UIColorFromRGB(0x333333)];
        [self.contentView addSubview:_title];
    }
    return self;
}

@end
@implementation PopoverView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.borderColor = RGB(200, 199, 204);
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

-(id)initWithPoint:(CGPoint)point MenuItems:(NSArray *)menuItems{
    self = [super init];
    if (self) {
        self.showPoint = point;
        self.menuItems = menuItems;
        m_perLineMenuNumber = 2;
        self.frame = [self getViewFrame];
        [self addSubview:self.collectionView];
        
    }
    return self;
}

-(id)initWithPoint:(CGPoint)point MenuItems:(NSArray *)menuItems perLineNumber:(NSInteger)perLineNumber{
    self = [super init];
    if (self) {
        self.showPoint = point;
        self.menuItems = menuItems;
        m_perLineMenuNumber = perLineNumber;
        self.frame = [self getViewFrame];
        [self addSubview:self.collectionView];
        
    }
    return self;
}

-(CGRect)getViewFrame
{
    CGRect frame = CGRectZero;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    m_cellWidth = (screenRect.size.width-(kCellSpace * 2)) / m_perLineMenuNumber;
    m_cellHeight  = m_cellWidth + 5;
    //一行显示多少
    NSInteger lineNum = [self.menuItems count] / m_perLineMenuNumber;
    if ([self.menuItems count] % m_perLineMenuNumber != 0) {
        lineNum = lineNum + 1;
    }
    frame.size.height = lineNum * m_cellHeight + 10;
    frame.size.width = screenRect.size.width;
    
    frame.origin.x = 0;
    frame.origin.y = self.showPoint.y;
    
    
    return frame;
}


-(void)show
{
    //CGRect menuRect = [self getViewFrame];
    self.handerView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_handerView setBackgroundColor:[UIColor clearColor]];
    
    _belowHandlerView = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect rect = CGRectMake(0, self.showPoint.y , [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.showPoint.y);
    [_belowHandlerView setFrame:rect];
    [_belowHandlerView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.65]];
    [_belowHandlerView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_handerView addSubview:_belowHandlerView];
    
    self.upHandlerView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_upHandlerView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.showPoint.y)];
    [_upHandlerView setBackgroundColor:[UIColor clearColor]];
    [_upHandlerView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_handerView addSubview:_upHandlerView];
    
    [_handerView addSubview:self];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:_handerView];
    
    //CGPoint arrowPoint = [self convertPoint:self.showPoint fromView:_handerView];
    self.layer.anchorPoint = CGPointMake(1,0);
    self.frame = [self getViewFrame];
    
    self.alpha = 0.f;
    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
        self.alpha = 1.f;
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


#pragma mark - UITableView

-(UICollectionView *)collectionView
{
    if (_collectionView != nil) {
        return _collectionView;
    }
    
    CGRect rect = self.frame;
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    // 2.设置每个格子的尺寸
    flowLayout.itemSize = CGSizeMake(m_cellWidth, m_cellHeight);
    // 3.设置整个collectionView的内边距
    CGFloat paddingY = 0;
    // 4.设置每一行之间的间距
    flowLayout.minimumLineSpacing = paddingY;

    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(rect.origin.x, 0, rect.size.width, rect.size.height) collectionViewLayout:flowLayout];

    _collectionView.delegate = self;
    _collectionView.dataSource = self;

    [_collectionView registerClass:[MenuCell class] forCellWithReuseIdentifier:@"menuCell"];

    _collectionView.backgroundColor = [UIColor whiteColor];
    return _collectionView;
}

#pragma mark - UICollectionView DataSource


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_menuItems count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CellIdentifier = @"menuCell";
    MenuCell * cell = (MenuCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    MenuItem *item = [_menuItems objectAtIndex:indexPath.row];
    [cell.imageView setImage:item.image];
    [cell.title setText:item.title];
    //[cell setBackgroundColor:[UIColor blueColor]];
    return cell;
}



#pragma mark - UICollectionView Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MenuItem *item = [_menuItems objectAtIndex:indexPath.row];
    if (self.selectRowAtIndex) {
        self.selectRowAtIndex(item);
    }
    
    [self dismiss:YES];
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
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
    [RGB(245, 245, 245) setFill];
    [popoverPath fill];
    [popoverPath closePath];
    [popoverPath stroke];
}


@end
