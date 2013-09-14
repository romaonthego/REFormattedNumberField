//
//  RootViewController.m
//  REFormattedNumberFieldExample
//
//  Created by Roman Efimov on 2/21/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RootViewController.h"
#import "REFormattedNumberField.h"

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
	
    REFormattedNumberField *phoneField1 = [[REFormattedNumberField alloc] initWithFrame:CGRectMake(20, 40, 280, 30)];
    phoneField1.backgroundColor = [UIColor whiteColor];
    phoneField1.format = @"(XXX) XXX-XXXX";
    phoneField1.placeholder = @"(123) 456-7890";
    phoneField1.font = [UIFont systemFontOfSize:21];
    [self.view addSubview:phoneField1];
    
    REFormattedNumberField *phoneField2 = [[REFormattedNumberField alloc] initWithFrame:CGRectMake(20, 100, 280, 30)];
    phoneField2.backgroundColor = [UIColor whiteColor];
    phoneField2.format = @"+X (XXX) XXX-XXXX";
    phoneField2.placeholder = @"+1 (123) 456-7890";
    phoneField2.font = [UIFont systemFontOfSize:21];
    [self.view addSubview:phoneField2];
    
    REFormattedNumberField *ccField = [[REFormattedNumberField alloc] initWithFrame:CGRectMake(20, 160, 280, 30)];
    ccField.backgroundColor = [UIColor whiteColor];
    ccField.format = @"XXXX XXXX XXXX XXXX";
    ccField.placeholder = @"1234 5678 9102 3456";
    ccField.font = [UIFont systemFontOfSize:21];
    [self.view addSubview:ccField];
    
    REFormattedNumberField *ccExpirationField = [[REFormattedNumberField alloc] initWithFrame:CGRectMake(20, 220, 280, 30)];
    ccExpirationField.backgroundColor = [UIColor whiteColor];
    ccExpirationField.format = @"XX/XX";
    ccExpirationField.placeholder = @"MM/YY";
    ccExpirationField.font = [UIFont systemFontOfSize:21];
    [self.view addSubview:ccExpirationField];
    
    REFormattedNumberField *lengthField = [[REFormattedNumberField alloc] initWithFrame:CGRectMake(20, 280, 280, 30)];
    lengthField.backgroundColor = [UIColor whiteColor];
    lengthField.format = @"Xm XXcm";
    lengthField.placeholder = @"1m 80cm";
    lengthField.font = [UIFont systemFontOfSize:21];
    [self.view addSubview:lengthField];
}


@end
