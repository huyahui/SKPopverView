//
//  ViewController.m
//  SKPopverView
//
//  Created by shaveKevin on 15/6/18.
//  Copyright (c) 2015年 shaveKevin. All rights reserved.
//

#import "ViewController.h"
#import "PopoverView.h"
#import "PoperListView.h"

@interface ViewController (){
    PopoverView *m_pop;
    NSMutableArray *m_menus;
    PoperListView *n_pop;
    NSMutableArray *n_menus;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     m_menus = [[NSMutableArray alloc]initWithCapacity:3];
     n_menus = [[NSMutableArray alloc]initWithCapacity:3];
    [self setupMenus];
    [self setupListMenus];
    [self showTabBarItem];
    self.title = @"弹出菜单";
}

#pragma mark - 菜单
//弹出菜单
-(void)showTabBarItem{
    
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarButton setTitle:@"左" forState:UIControlStateNormal];
    leftBarButton.backgroundColor = [UIColor orangeColor];
    leftBarButton.layer.cornerRadius = 15.0f;
    leftBarButton.clipsToBounds = YES;
    leftBarButton.frame = CGRectMake(0, 0, 30, 30);
    [leftBarButton addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    //自定义一个右侧的button
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton setTitle:@"右" forState:UIControlStateNormal];
    rightBarButton.backgroundColor = [UIColor orangeColor];
    rightBarButton.layer.cornerRadius = 15.0f;
    rightBarButton.clipsToBounds = YES;
    rightBarButton.frame = CGRectMake(30, 0, 30, 30);
    [rightBarButton addTarget:self action:@selector(pressAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBarButton];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBarButton];
    //这个是为了解决自定义的button不靠右的问题，width 可以设置改变其位置
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[nagetiveSpacer,rightBarButtonItem, leftBarButtonItem];

}
#pragma mark   -  纵向  -

- (void)pressAction {
    [self setPopoverListMenu];
    [n_pop show];
    
}

-(void)setPopoverListMenu{
    
    __weak __typeof(self)weakSelf = self;
    //这个frame是相对于window 的
    n_pop = [[PoperListView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 200,70 , 195,n_menus.count *44) MenuItems:n_menus];
    n_pop.backgroundColor = [UIColor greenColor];
    n_pop.layer.cornerRadius = 2.0f;
    n_pop.clipsToBounds = YES;
    n_pop.selectRowAtIndex = ^(MenuListItems *item){
        [weakSelf pushMenuItems:item];
    };
    
}

//自定义菜单的数量  纵向的
-(void)setupListMenus {
    
    MenuListItems *item1 = [[MenuListItems alloc]init];
    item1.menuId = 0;
    item1.title = @"第一个";
    item1.image = [UIImage imageNamed:@"首页-右上弹出-4.png"];
    [n_menus addObject:item1];
    
    MenuListItems *item2 = [[MenuListItems alloc]init];
    item2.menuId = 1;
    item2.title = @"第二个";
    item2.image = [UIImage imageNamed:@"首页-右上弹出-5.png"];
    [n_menus addObject:item2];
    
    MenuListItems *item3 = [[MenuListItems alloc]init];
    item3.menuId = 2;
    item3.title = @"第三个";
    item3.image = [UIImage imageNamed:@"首页-右上弹出-6.png"];
    [n_menus addObject:item3];
    
}

- (void)pushMenuItems:(MenuListItems *)item {
    
    if(item.menuId == 0){
        //0。
        NSLog(@"第一");
        [self performSegueWithIdentifier:@"segueForOneViewControler" sender:nil];
        
    }else if (item.menuId == 1){
        //1.
        NSLog(@"第二");
        [self performSegueWithIdentifier:@"segueForTwoViewControler" sender:nil];
    }
    else if(item.menuId == 2){
        //2
        NSLog(@"第三");
        [self performSegueWithIdentifier:@"segueForThreeViewControler" sender:nil];
    }
    
    
}

#pragma mark  - 横向 -

//弹出菜单
-(void)showMenu{
    [self setPopoverMenu];
    [m_pop show];
}

//自定义菜单的数量 横向的
-(void)setupMenus {
    
    MenuItem *item1 = [[MenuItem alloc]init];
    item1.menuId = 0;
    item1.title = @"第一个";
    item1.image = [UIImage imageNamed:@"首页-右上弹出-4.png"];
    [m_menus addObject:item1];
    
    MenuItem *item2 = [[MenuItem alloc]init];
    item2.menuId = 1;
    item2.title = @"第二个";
    item2.image = [UIImage imageNamed:@"首页-右上弹出-5.png"];
    [m_menus addObject:item2];
    
    MenuItem *item3 = [[MenuItem alloc]init];
    item3.menuId = 2;
    item3.title = @"第三个";
    item3.image = [UIImage imageNamed:@"首页-右上弹出-6.png"];
    [m_menus addObject:item3];
    
}
-(void)setPopoverMenu{
    
    CGPoint point = CGPointMake(self.view.frame.origin.x, self.navigationController.navigationBar.frame.size.height + self.navigationController.navigationBar.frame.origin.y);
    __weak __typeof(self)weakSelf = self;
    m_pop = [[PopoverView alloc] initWithPoint:point MenuItems:m_menus perLineNumber:3];
    
    m_pop.selectRowAtIndex = ^(MenuItem *item){
        [weakSelf pushMenuItem:item];
    };
    
}

- (void)pushMenuItem:(MenuItem *)item {
    
    if(item.menuId == 0){
        //0。
        NSLog(@"第一");
        [self performSegueWithIdentifier:@"segueForOneViewControler" sender:nil];
        
    }else if (item.menuId == 1){
        //1.
        NSLog(@"第二");
        [self performSegueWithIdentifier:@"segueForTwoViewControler" sender:nil];
    }
    else if(item.menuId == 2){
        //2
        NSLog(@"第三");
        [self performSegueWithIdentifier:@"segueForThreeViewControler" sender:nil];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
