//
//  ViewController.m
//  AutolayoutExample
//
//  Created by Kamil Burczyk on 01.02.2014.
//  Copyright (c) 2014 Sigmapoint. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeight;
@property (weak, nonatomic) IBOutlet UIView *redSquare;

@property (nonatomic, strong) NSArray *constraintsWithHigherPriority;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    _constraintHeight.constant = 150;
    
    //print constraints for view and superview
    NSLog(@"constraints: %@", _redSquare.constraints);
    NSLog(@"superview constraints: %@", _redSquare.superview.constraints);
    
    //try to remove all view constraints and print again - superview constraints which affect view are not removed
    
//    [_redSquare removeConstraints:_redSquare.constraints];
//    NSLog(@"constraints: %@", _redSquare.constraints);
//    NSLog(@"superview constraints: %@", _redSquare.superview.constraints);

    
    _constraintsWithHigherPriority = [NSArray array];
}

- (IBAction)resizeView:(UIButton *)sender {
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(100)-[_redSquare(200)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_redSquare)];
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(50)-[_redSquare(200)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_redSquare)];
    
    _constraintsWithHigherPriority = [_constraintsWithHigherPriority arrayByAddingObjectsFromArray:verticalConstraints];
    _constraintsWithHigherPriority = [_constraintsWithHigherPriority arrayByAddingObjectsFromArray:horizontalConstraints];
    
    [_redSquare.superview addConstraints:_constraintsWithHigherPriority];
    
    [UIView animateWithDuration:1.0f animations:^{
        [self.view layoutIfNeeded];
    }];
    
    NSLog(@"constraints after resize: %@", _redSquare.constraints);
    NSLog(@"superview constraints after resize: %@", _redSquare.superview.constraints);
}

- (IBAction)moveBackToOriginalPosition:(UIButton *)sender {
    [_redSquare.superview removeConstraints:_constraintsWithHigherPriority];
    
    [UIView animateWithDuration:1.0f animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
