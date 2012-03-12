//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Miike Ramos on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *)brain {
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = sender.currentTitle;
    NSRange range = [self.display.text rangeOfString:@"."];
    //%@ means print the parameter after the "" string; @ means the param is an object
    //NSLog(@"digit pressed = %@", digit);
    if (self.userIsInTheMiddleOfEnteringANumber) {
        // Is the user entering a decimal?
        NSLog(@"Digit pressed: %@", digit);
        if ([digit isEqualToString:@"."]) {
            // Has the user already entered a decimal?
            NSLog(@"Range length: %@", NSStringFromRange(range));
            if (range.length > 0) {
                NSLog(@"Do nothing");
            } else {
                self.display.text = [self.display.text stringByAppendingString:digit];
                NSLog(@"Adding the digit to the display");
            }
        } else {
            self.display.text = [self.display.text stringByAppendingString:digit];
            NSLog(@"Not a decimal, simply adding it");
        }
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
        NSLog(@"This is the first digit press %@", digit);
    }
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
}


@end
