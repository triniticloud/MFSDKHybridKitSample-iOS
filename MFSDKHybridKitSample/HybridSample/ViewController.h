//
//  ViewController.h
//  MFWebSDKDemo
//
//  Created on 23/10/17.
//  Copyright © 2017 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *objUsernameTF;
@property (weak, nonatomic) IBOutlet UITextField *objPasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *objLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *objForgotPasswordButton;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UIButton *objLanguageButton;
@property (weak, nonatomic) IBOutlet UIButton *capthaButton;
@property (weak, nonatomic) IBOutlet UIView *languagePickerView;
@property(nonatomic,weak)UIViewController *objWebScreen;

@end

