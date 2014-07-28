//
//  GRStudent.m
//  _16_Time
//
//  Created by Exo-terminal on 3/28/14.
//  Copyright (c) 2014 Evgenia. All rights reserved.
//

#import "GRStudent.h"

@implementation GRStudent


-(NSString*)description{
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    
    NSString* string =[NSString stringWithFormat:@"%@ %@ age: %d year  date of birth: %@",self.name,self.lastName,self.age,[dateFormatter stringFromDate:self.dateOfBirth]];
    return string;
}
@end
