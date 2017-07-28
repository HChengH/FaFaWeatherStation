//
//  ContainerViewController.m
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-07-13.
//  Copyright © 2017 翯. All rights reserved.
//

#import "ContainerViewController.h"
#import "pageScrollViewController.h"

@interface ContainerViewController ()<UIScrollViewDelegate>
@property UIScrollView *mainScrollView;
@property NSMutableArray *cityPool;
@property NSMutableArray *controllerPool;
@property CGPoint oldScrollViewPoint;
@end

@implementation ContainerViewController

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    [scrollView setContentOffset:scrollView.contentOffset animated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // update city name
    self.navigationItem.title = [self.cityPool objectAtIndex:scrollView.contentOffset.x/self.view.frame.size.width];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"verticalScroll" object:nil];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.oldScrollViewPoint = scrollView.contentOffset;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
}

-(void) customeDragging:(UIScrollView *)scrollView willDecelerate:(BOOL) decelerate{
        int newIndex = self.oldScrollViewPoint.x/self.view.frame.size.width;
    
        if(decelerate){
            CGFloat rate = scrollView.decelerationRate;
            NSLog(@"%f", rate);
        }
    
        // 25% left drag
        if(scrollView.contentOffset.x > self.oldScrollViewPoint.x){
            CGFloat offset = scrollView.contentOffset.x - self.oldScrollViewPoint.x;
            if(offset > self.view.frame.size.width*0.25f){
                ++newIndex;
            }
    
            if(newIndex > self.cityPool.count){
                return;
            }
    
            [UIView animateWithDuration:0.35 animations:^{
                scrollView.contentOffset = CGPointMake(newIndex*self.view.frame.size.width, 0);
            } completion:^(BOOL finished) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"verticalScroll" object:nil];
            }];
        }
        // 75% right drag
        else{
            CGFloat offset = self.oldScrollViewPoint.x - scrollView.contentOffset.x;
            if(offset > self.view.frame.size.width*0.25){
                --newIndex;
            }
    
            if(newIndex < 0){
                return;
            }
    
            [UIView animateWithDuration:0.35 animations:^{
                scrollView.contentOffset = CGPointMake(newIndex*self.view.frame.size.width, 0);
            } completion:^(BOOL finished) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"verticalScroll" object:nil];
            }];
        }
    
}

-(void)updateCity:(NSString *)city{
    if([[city substringFromIndex:city.length -1] isEqualToString: @"市"]){
        city = [city substringToIndex:city.length-1];
    }
    if(![self.cityPool containsObject:city]){
        [self.cityPool addObject:city];
        self.navigationItem.title = city;
        self.mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width*self.cityPool.count, self.view.frame.size.height);
    }
}

-(void)didSearchNewCity:(NSString *)newCity{
    if(![self.cityPool containsObject:newCity]){
        [self.cityPool addObject:newCity];
        self.mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width*self.cityPool.count, self.view.frame.size.height);
        
        pageScrollViewController *newViewController = [[pageScrollViewController alloc]initWithStaticLocation:newCity];
        newViewController.mydelegate = self;
        
        [self.controllerPool addObject:newViewController];
        
        [self addChildViewController:newViewController];
        newViewController.view.frame = CGRectMake(self.view.frame.size.width*[self.cityPool indexOfObject:newCity], 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.mainScrollView addSubview:newViewController.view];
        [newViewController didMoveToParentViewController:self];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.mainScrollView.contentOffset = CGPointMake([self.cityPool indexOfObject:newCity]*self.view.frame.size.width, 0);
            
        } completion:^(BOOL finished) {
            self.navigationItem.title = newViewController.cityName;
        }];
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            self.mainScrollView.contentOffset = CGPointMake([self.cityPool indexOfObject:newCity]*self.view.frame.size.width, 0);
            
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cityPool = [NSMutableArray array];
    self.controllerPool = [NSMutableArray array];
    
    pageScrollViewController *defaultViewController = [[pageScrollViewController alloc]init];
    defaultViewController.mydelegate = self;
    [self.controllerPool addObject:defaultViewController];
    
    [self.navigationController.toolbar setHidden:NO];//
    self.navigationController.toolbar.translucent = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.hidden = NO;
    
    self.mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.mainScrollView.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1];
    self.mainScrollView.delegate = self;
    
    //
    self.mainScrollView.pagingEnabled = YES;
    
    [self.view addSubview:self.mainScrollView];
    
    
    [self addChildViewController:defaultViewController];
    defaultViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.navigationItem.title = defaultViewController.cityName;
    
    [self.mainScrollView addSubview:defaultViewController.view];
    
    [defaultViewController didMoveToParentViewController:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
