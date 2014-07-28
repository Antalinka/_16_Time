//
//  AppDelegate.m
//  _16_Time
//
//  Created by Exo-terminal on 3/28/14.
//  Copyright (c) 2014 Evgenia. All rights reserved.
//

#import "AppDelegate.h"
#import "GRStudent.h"

@interface AppDelegate()
@property (assign, nonatomic) NSInteger il;
@property (strong, nonatomic) NSTimer* timer;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSMutableArray* studentsArray = [[NSMutableArray alloc]init];
    
    for (NSInteger i = 0; i<30; i++) {
        GRStudent* student = [[GRStudent alloc]init];
        
        student.age = arc4random()%35+16;
        
        NSDate * date = [NSDate date];
        NSCalendar* calendar = [NSCalendar currentCalendar];
        NSDateComponents* components = [calendar components:NSCalendarUnitYear fromDate:date];      //take a year
        
        NSInteger yearOfBirth = [components year] - student.age;                                    //year of Birth
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
        NSDate* date2 = [dateFormatter dateFromString:@"2000/Jan/01 00:00"];
        components = [calendar components: NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date2];// date = 01.01.2000
        [components setYear:yearOfBirth];                                                          // date = 01.01.yearOfBirth
        
 
        student.dateOfBirth = [calendar dateFromComponents:components];
        
        NSInteger dayOfBirth = (arc4random()%365) * 24 * 60 * 60;
        student.dateOfBirth = [student.dateOfBirth dateByAddingTimeInterval:dayOfBirth];          // date = 01.01.yearOfBirth + random day
        
        [studentsArray addObject:student];
      }
    
    [studentsArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[obj2 dateOfBirth] compare:[obj1 dateOfBirth]];
    }];
    
//    for (GRStudent* student in studentsArray) {
//        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
//        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
//        NSLog(@"%@",[dateFormatter stringFromDate:student.dateOfBirth]);
//    }
    
    NSArray* studentsName = [NSArray arrayWithObjects:@"Aleksandr", @"Dima", @"Egor", @"Fedor", @"Nafanya", @"Anton", @"Fedor", @"Oleg",nil];
    NSArray* studentsLastName = [NSArray arrayWithObjects:@"Nikiforov", @"Ivanov", @"Medvedev", @"Sobolev", @"Pavlov", @"Vlasov", @"Petrov", @"Strelkov", nil];
    
    
    for (GRStudent* student in studentsArray) {
        
      NSInteger nameSeed = arc4random()%8;
      NSInteger lastNameSeed = arc4random()%8;
        
      student.name = [studentsName objectAtIndex:nameSeed];
      student.lastName = [studentsLastName objectAtIndex:lastNameSeed];
    }
    
    self.objArray = [[NSMutableArray alloc]init];

    for (GRStudent* student in studentsArray) {
        
        NSCalendar* calendar = [NSCalendar currentCalendar];
        NSDateComponents* components = [calendar components:NSCalendarUnitMonth | NSCalendarUnitDay fromDate:student.dateOfBirth];
        [self.objArray  addObject:components];
    }
    
    self.il = 1;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.005f target:self selector:@selector(timerTest) userInfo:nil repeats:YES];
    [self.timer fire];
    
    GRStudent* firstStudent = [studentsArray objectAtIndex:0];
    GRStudent* lastStudent = [studentsArray  objectAtIndex:[studentsArray count]-1];
    NSDate* firstDate = firstStudent.dateOfBirth;
    NSDate* lastDate = lastStudent.dateOfBirth;
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components: NSCalendarUnitYear |
                                                         NSCalendarUnitMonth |
                                                         NSCalendarUnitWeekOfYear |
                                                         NSCalendarUnitDay
                                               fromDate:lastDate
                                               toDate:firstDate
                                               options: NSCalendarWrapComponents];
    
    NSLog(@"Difference of age: %d лет, %d месяцев, %d недель, %d дней", [components year],[components month], [components week], [components day]);
    return YES;
}

-(void)timerTest{
    if (self.il<365) {
        
        NSCalendar* calendar = [NSCalendar currentCalendar];
        NSDate* date = [NSDate date];
        
        NSDateComponents* dayComponents = [[NSDateComponents alloc]init];
        dayComponents.day = 1 + self.il;
        
        NSDate* date2 = [NSDate date];
        date2 = [calendar dateByAddingComponents:dayComponents toDate:date options:0];
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"dd.MM.yyyy"];
        
        NSDateComponents* components1= [calendar components: NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date2];

        for(NSDateComponents* components in self.objArray) {
           
            if ([components1 month] == [components month] & [components1 day] == [components day] ) {
                NSLog(@"Happy birthday! %@", [dateFormatter stringFromDate:date2]);
            }
        }
        
        self.il++;
    }else{
        [self.timer invalidate];
    }
}

/*-(void)timerTest{
 if (self.il<365) {
 NSDate* date = [NSDate dateWithTimeIntervalSinceNow:+(self.il * 24 * 60 * 60)];
 
 NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
 [dateFormatter setDateFormat:@"dd.MM.yyyy"];
 
 NSCalendar* calendar = [NSCalendar currentCalendar];
 NSDateComponents* components1= [calendar components: NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
 
 for(NSDateComponents* components in self.objArray) {
 
 if ([components1 month] == [components month] & [components1 day] == [components day] ) {
 NSLog(@"Happy birthday! %@", [dateFormatter stringFromDate:date]);
 }
 }
 
 self.il++;
 }else{
 [self.timer invalidate];
 }
 }*/
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
