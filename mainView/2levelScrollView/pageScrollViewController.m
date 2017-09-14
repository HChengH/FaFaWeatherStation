//
//  pageScrollViewController.m
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-07-05.
//  Copyright © 2017 翯. All rights reserved.
//

#import "pageScrollViewController.h"
#import "pageScrollView.h"
#import "AFNetworking.h"
#import "weather.h"
#import "location.h"
#import "loadingAnimationView.h"
#import "weatherMainTableViewModel.h"

#define maxoffset 70

@interface pageScrollViewController () <UIScrollViewDelegate, requestWeather, updateFields, searchCity>
@property pageScrollView *mainView;
@property loadingAnimationView *animation;
@property NSTimer *repeatUpdate;

// network Request module
@property weather *weatherManager;
@property location *locationManager;
@property BOOL staticLocation;
@end

@implementation pageScrollViewController

-(id)initWithStaticLocation:(NSString *)location{
    if(self = [super init]){
        self.staticLocation = YES;
        self.cityName = location;
    }
    return self;
}

-(id)init{
    if(self = [super init]){
        self.staticLocation = NO;
    }
    return self;
}

-(void) preDelete{
    self.weatherManager.mydelegate = nil;
    self.locationManager.mydelegate = nil;
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [scrollView setContentOffset:scrollView.contentOffset animated:YES];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if([scrollView isKindOfClass:[todayView class]]){
        CGFloat valueNum = scrollView.contentSize.height - scrollView.frame.size.height;
        if(offsetY-valueNum >= 0){
//            [self pausUpdate];
//            [self update];
            [self gotoNextPage:scrollView];
        }
        [UIView animateWithDuration:0.5 animations:^{
            scrollView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
        }];
    }
    else{
        CGFloat valueNum = scrollView.contentSize.height - scrollView.frame.size.height;
        if(offsetY <0 && offsetY+maxoffset <= 0){
            [self gotoPrevPage:scrollView];
        }
        // scrollView.contentOffset = CGPointMake(0, 0);
    }
}

-(void)gotoNextPage:(UIScrollView *)view{
    [UIView animateWithDuration:0.5 animations:^{
        self.mainView.frame = CGRectMake(0, -self.mainView.frame.size.height/2, self.mainView.frame.size.width, self.mainView.frame.size.height);
        
    } completion:^(BOOL finished) {
        view.contentOffset = CGPointMake(0, 0);
    }];
}

-(void)gotoPrevPage:(UIScrollView *)view{
    [UIView animateWithDuration:0.5 animations:^{
        self.mainView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        
    } completion:^(BOOL finished) {
        view.contentOffset = CGPointMake(0, 0);
    }];
}

-(void)requestWithNewCity:(NSString *)city{
    [self.mydelegate didSearchNewCity:city];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    self.animation = [[loadingAnimationView alloc]init];
    [self.animation setModelwithSize:self.view.frame.size.width/4.6875f];
    self.animation.center = CGPointMake(self.navigationController.view.frame.size.width/2, self.navigationController.view.frame.size.height/2);
    
    [self.repeatUpdate fire];
}

-(void)requestData{
    [self.animation startAnimation];
    [self.navigationController.view addSubview: self.animation];
    if(!self.staticLocation){
         [self.locationManager requestLocation];
    }
    else{
        [self requestWeather:self.cityName];
    }
}

// recall from location
-(void)requestWeather:(NSString *)location{
    [self.mydelegate updateCity:location];
    self.weatherManager = [[weather alloc]initWithLocation:location];
    self.weatherManager.mydelegate = self;
    [self.weatherManager requestWeather];
}

// recall from NetRequest module
-(void)updateFields:(weatherMainTableViewModel *)model{
    [self.animation removeFromSuperview];
    [self.animation endAnimation];
    self.cityName = model.city;
    self.navigationItem.title = self.cityName;
    [self.mainView setModel:model];
    self.mainView.userInteractionEnabled = YES;
}

-(void)update{
    self.repeatUpdate = [NSTimer scheduledTimerWithTimeInterval:180 target:self selector:@selector(requestData) userInfo:nil repeats:YES];
    self.mainView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
    
    [self.repeatUpdate fire];
}

-(void)pausUpdate{
    [self.repeatUpdate invalidate];
}

-(void)resetOffset{
    [UIView animateWithDuration:0.3 animations:^{
        self.mainView.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.toolbar.translucent = NO;
//    self.navigationController.navigationBar.hidden = NO;
//    self.navigationController.navigationBar.translucent = NO;
    
    self.mainView = [[pageScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height-64)*2) andOffset:maxoffset];
    self.mainView.userInteractionEnabled = NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.mainView.headerView.searchDelegate = self;
    self.mainView.headerView.scrollDelegate = self;
    
    self.mainView.weatherController.mydelegate = self;
    
    self.locationManager = [[location alloc]init];
    self.locationManager.mydelegate = self;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(update) name:@"requestUpdate" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pausUpdate) name:@"pauseUpdate" object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resetOffset) name:@"verticalScroll" object:nil];
    
    self.repeatUpdate = [NSTimer scheduledTimerWithTimeInterval:180 target:self selector:@selector(requestData) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mainView];
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
