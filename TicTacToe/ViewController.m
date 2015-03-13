//
//  ViewController.m
//  TicTacToe
//
//  Created by Justin Haar on 3/12/15.
//  Copyright (c) 2015 Justin Haar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelOne;
@property (weak, nonatomic) IBOutlet UILabel *labelTwo;
@property (weak, nonatomic) IBOutlet UILabel *labelThree;
@property (weak, nonatomic) IBOutlet UILabel *labelFour;
@property (weak, nonatomic) IBOutlet UILabel *labelFive;
@property (weak, nonatomic) IBOutlet UILabel *labelSix;
@property (weak, nonatomic) IBOutlet UILabel *labelSeven;
@property (weak, nonatomic) IBOutlet UILabel *labelEight;
@property (weak, nonatomic) IBOutlet UILabel *labelNine;
@property (weak, nonatomic) IBOutlet UILabel *whichPlayerLabel;

@property (nonatomic) NSString *whoWon;

@property (weak, nonatomic) IBOutlet UILabel *theFlyingLabel;
@property CGPoint originalWhichPlayerLabelCenter;


@property (weak, nonatomic) IBOutlet UILabel *seconds;


@end

@implementation ViewController
{

    NSInteger integers[10]; // use 1-9; ignore index 0;

    NSTimer *timer;
    int remainingCounts;

    UIAlertView *alertView;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //first player
    self.whichPlayerLabel.text = @"X";
    //self.whichPlayerLabel.textColor = [UIColor blueColor];



    
}

-(void) viewDidAppear:(BOOL)animated
{

    //keep whichPlayer center location

    self.originalWhichPlayerLabelCenter = self.whichPlayerLabel.center;

/*
    CGPoint p;
    p.x = 200;
    p.y =490;
    self.originalWhichPlayerLabelCenter = p;

    NSLog(@" whichplayer  center X= %f , Y= %f", self.whichPlayerLabel.center.x,self.whichPlayerLabel.center.y);

    NSLog(@" label ONE center %f , %f", self.labelOne.center.x,self.labelOne.center.y);
*/

        //
        //Timer starts here
        //
        remainingCounts = 20;
        timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                 target:self
                                               selector:@selector(countDown)
                                               userInfo:nil
                                                repeats:YES];


}


-(void)countDown {
    if (--remainingCounts == 0) {
        [timer invalidate];

        alertView = [[UIAlertView alloc] initWithTitle:@"Time Out!" message:nil delegate:self cancelButtonTitle:@"Start New Game" otherButtonTitles:nil, nil];

        [alertView show];

    }

    self.seconds.text = [NSString stringWithFormat:@"%i", remainingCounts];
}

-(IBAction) doDrag:(UIPanGestureRecognizer *)sender
{

    if (sender.state == UIGestureRecognizerStateEnded) {

        CGPoint point = [sender locationInView:self.view];
        self.theFlyingLabel.center = point;
        //
        //
        //assign X or O to PanGestured Label
        //
        //
        [self findLabelUsingPoint:point];

        //
        // Fly theFlyLabel back to whichPlayerLabel
        //
        [UIView animateWithDuration:1 animations:^{
            self.theFlyingLabel.center = self.originalWhichPlayerLabelCenter;
            self.theFlyingLabel.alpha = 0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 animations:^{

                // change to another player
                if([self.theFlyingLabel.text isEqualToString:@"X"]){
                    self.theFlyingLabel.text = @"O";
                    self.theFlyingLabel.textColor = [UIColor redColor];
                }
                else {
                    self.theFlyingLabel.text = @"X";
                    self.theFlyingLabel.textColor = [UIColor blueColor];
                }




                self.theFlyingLabel.alpha =1;
            }];
        }];



        // CHECK if player wins
        //

        self.whoWon = [self checkWhoWon];
        if(![self.whoWon isEqualToString:@""]){
            // if not empty string, someone won, Display AlertView with message

            NSMutableString *str = [NSMutableString new];
            [str appendFormat:@"Congradulations! \n Player %@ Won!", self.whoWon];

            alertView = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"Start New Game" otherButtonTitles:nil, nil];
            
            [alertView show];
        }



        //
        // CHECK if all 9 labels been selected
        //
        //

        if([self isAllSelected]){

             alertView = [[UIAlertView alloc] initWithTitle:@"Game Over \n No One Won" message:nil delegate:self cancelButtonTitle:@"Start New Game" otherButtonTitles:nil, nil];

            [alertView show];


        }






    } else {

        CGPoint point = [sender locationInView:self.view];
        self.theFlyingLabel.center = point;

        NSLog(@" current player is %@", self.whichPlayerLabel.text);
    }

}


- (IBAction)onLabelTapped:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.view];


    NSLog(@" current player is %@", self.whichPlayerLabel.text);

    //assign X or O to tapped Label
    [self findLabelUsingPoint:point];

    self.whoWon = [self checkWhoWon];

    if(![self.whoWon isEqualToString:@""]){
        // if not empty string, someone won, Display AlertView with message

        NSMutableString *str = [NSMutableString new];
        [str appendFormat:@"Congradulations! \n Player %@ Won!", self.whoWon];

        alertView = [[UIAlertView alloc] initWithTitle:str message:nil delegate:self cancelButtonTitle:@"Start New Game" otherButtonTitles:nil, nil];

        [alertView show];
    }

}

//AlertView: if user click Play Again button: reset labels , Integers array and set the player to X
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0){ //Play again

        self.labelOne.text = @"";
        self.labelTwo.text = @"";
        self.labelThree.text = @"";
        self.labelFour.text = @"";
        self.labelFive.text = @"";
        self.labelSix.text = @"";
        self.labelSeven.text = @"";
        self.labelEight.text = @"";
        self.labelNine.text = @"";

        self.whichPlayerLabel.text = @"X";
        self.theFlyingLabel.text = @"X";

        self.seconds.text = @"20";

        for (int i=1; i<10; i++) {
            integers[i] = 0;
        }
    }
}


- (void)findLabelUsingPoint:(CGPoint)point
{
    // check if point is in this frame?


    if(CGRectContainsPoint(self.labelOne.frame, point)){

        // place X or O
        integers[1] = [self assignLabelValue:self.labelOne];
    }
    else if(CGRectContainsPoint(self.labelTwo.frame, point)){
        // place X or O
        integers[2] = [self assignLabelValue:self.labelTwo];

    }else if(CGRectContainsPoint(self.labelThree.frame, point)){

        // place X or O
        integers[3] =[self assignLabelValue:self.labelThree];

    }else if(CGRectContainsPoint(self.labelFour.frame, point)){
        // place X or O
        integers[4] =[self assignLabelValue:self.labelFour];

    }else if(CGRectContainsPoint(self.labelFive.frame, point)){
        // place X or O
        integers[5] =[self assignLabelValue:self.labelFive];

    }else if(CGRectContainsPoint(self.labelSix.frame, point)){
        // place X or O
        integers[6] =[self assignLabelValue:self.labelSix];

    }else if(CGRectContainsPoint(self.labelSeven.frame, point)){
        // place X or O
        integers[7] =[self assignLabelValue:self.labelSeven];

    }else if(CGRectContainsPoint(self.labelEight.frame, point)){
        // place X or O
        integers[8] =[self assignLabelValue:self.labelEight];

    }else if(CGRectContainsPoint(self.labelNine.frame, point)){
        // place X or O
        integers[9] =[self assignLabelValue:self.labelNine];
    }

}




-(NSInteger) assignLabelValue: (UILabel *) label
{
    // place X or O
    // if label already has "O" or "X"-> do nothing
    if([label.text isEqualToString:@""]){

        if([self.whichPlayerLabel.text isEqualToString:@"X"]){
            label.text= @"X";
            label.textColor = [UIColor blueColor];
        } else {
            label.text= @"O";
            label.textColor = [UIColor redColor];
        }


        // change to another player
        if([self.whichPlayerLabel.text isEqualToString:@"X"]){
            self.whichPlayerLabel.text = @"O";
            //self.whichPlayerLabel.textColor = [UIColor redColor];
        }
        else {
            self.whichPlayerLabel.text = @"X";
            //self.whichPlayerLabel.textColor = [UIColor blueColor];
        }





    }

    if([label.text isEqualToString:@"X"]){
        return (NSInteger) 1; // player X
    } else {
        return (NSInteger) 100; // player O
    }

}


-(NSString *) checkWhoWon
{

    NSString *string = [NSString new];

    // each X = 1; if there are 3 (Xs) in a line, the total is 3 and player X won
    // each O = 100; if there are 3 (Os) in a line, thetotal will be 300 and player O won
    

    if(
            [self isWon:integers[1] b:integers[2] c:integers[3] total:3]
       ||   [self isWon:integers[4] b:integers[5] c:integers[6] total:3]
       ||   [self isWon:integers[7] b:integers[8] c:integers[9] total:3]
       ||   [self isWon:integers[1] b:integers[4] c:integers[7] total:3]
       ||   [self isWon:integers[2] b:integers[5] c:integers[8] total:3]
       ||   [self isWon:integers[3] b:integers[6] c:integers[9] total:3]
       ||   [self isWon:integers[1] b:integers[5] c:integers[9] total:3]
       ||   [self isWon:integers[3] b:integers[5] c:integers[7] total:3]
       )
    {
        string = @"X";
    }

    else if(
            [self isWon:integers[1] b:integers[2] c:integers[3] total:300]
       ||   [self isWon:integers[4] b:integers[5] c:integers[6] total:300]
       ||   [self isWon:integers[7] b:integers[8] c:integers[9] total:300]
       ||   [self isWon:integers[1] b:integers[4] c:integers[7] total:300]
       ||   [self isWon:integers[2] b:integers[5] c:integers[8] total:300]
       ||   [self isWon:integers[3] b:integers[6] c:integers[9] total:300]
       ||   [self isWon:integers[1] b:integers[5] c:integers[9] total:300]
       ||   [self isWon:integers[3] b:integers[5] c:integers[7] total:300]
       )
    {
        string = @"O";
    }

    else {
        string = @""; // no one won
    }

    for (int i=1; i<10; i++) {
        NSLog(@"dump array---%ld",integers[i]);
    }

     return string; //player who won

}

-(BOOL) isWon:(NSInteger) a b:(NSInteger) b c:(NSInteger) c total:(NSInteger) total {

    // each X = 1; if there are 3 (Xs) in a line, the total is 3 and player X won
    // each O = 100; if there are 3 (Os) in a line, thetotal will be 300 and player O won

    if((a+b+c) == total){
        return YES;
    }
    else {
        return NO;
    }
}

-(BOOL) isAllSelected {

    for(int i=1; i<10; i++){
        if(integers[i] == 0){
            return NO;
        }
    }
    return YES ;

}

@end
