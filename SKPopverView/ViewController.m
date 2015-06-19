//
//  ViewController.m
//  SKPopverView
//
//  Created by shaveKevin on 15/6/18.
//  Copyright (c) 2015年 shaveKevin. All rights reserved.
//

#import "ViewController.h"
#import "PopoverView.h"
@interface ViewController (){
    PopoverView *m_pop;
    NSMutableArray *m_menus;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     m_menus = [[NSMutableArray alloc]initWithCapacity:3];
    [self setupMenus];
    [self showTabBarItem];
    self.title = @"弹出菜单";
}
#pragma mark -菜单
//弹出菜单
-(void)showTabBarItem{
    //自定义一个右侧的button
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    rightBarButton.frame = CGRectMake(0, 0, 30, 30);
    [rightBarButton addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBarButton];
    //这个是为了解决自定义的button不靠右的问题，width 可以设置改变其位置
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[nagetiveSpacer, rightBarButtonItem];
}
//弹出菜单
-(void)showMenu{
    [self setPopoverMenu];
    [m_pop show];
}

//自定义菜单的数量
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
