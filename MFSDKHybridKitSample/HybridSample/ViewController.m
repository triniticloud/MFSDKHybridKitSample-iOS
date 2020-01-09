//
//  ViewController.m
//  MFWebSDKDemo
//
//  Created on 23/10/17.
//  Copyright © 2017 . All rights reserved.
//

#import "ViewController.h"
#import <MFSDKMessagingKit/MFSDKMessagingManager.h>
#import <MFNotificationKit/MFSDKNotificationKitManager.h>
#import "AppDelegate.h"
#import "ProjectStringConstant.h"

@interface ViewController ()<MFSDKMessagingDelegate, UITextFieldDelegate,UIGestureRecognizerDelegate,MFNotificationKitManagerDelegate>
@property (nonatomic, strong)NSArray *pickerData;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;
@property (nonatomic, strong)NSArray *pickerDataTitle;
@property (nonatomic, strong)NSString *languageTitle;
@property (weak, nonatomic) IBOutlet UIButton *askMeButton;
@property (nonatomic, strong)NSString *languageCode;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _picker.showsSelectionIndicator = YES;
    [self.languagePickerView addSubview:_picker];
    self.objUsernameTF.delegate = self;
    self.objPasswordTF.delegate = self;
    [self.objLanguageButton setTitle:ENGLISH forState:UIControlStateNormal];
    _pickerData = @[ENGLISH_LANG_CODE, HINDI_LANG_CODE];
    _pickerDataTitle = @[ENGLISH, HINDI];
    self.languageCode = ENGLISH_LANG_CODE;
    //setting notificationDelegate for MFNotificationKit
    [MFSDKNotificationKitManager sharedInstance].notificationDelegate = self;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundTapped:)];
    tapRecognizer.cancelsTouchesInView = NO;
        [self.askMeButton setTitleColor:[self colorFromHexString:BOT_ICON_BACKGROUND_COLOR] forState:UIControlStateNormal];
    self.askMeButton.frame = CGRectMake(0, 0, 90, 90);
    self.askMeButton.clipsToBounds = YES;
    self.askMeButton.layer.cornerRadius = 90/2.0f;
    if (@available(iOS 8.2, *)) {
            [self.askMeButton.titleLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightBold]];
    }
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    [self.languagePickerView setHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*!
@brief Implement the setting of initial properties MFSDKMessagingKit and loading Chat screen

@discussion This method sets initial properties MFSDKMessagingKit and loads the MFSDKMessagingKit's Chat screen

To use it, simply call @c[self startChat:sender];

@param sender is the button which initiate the action of loading MFSDKMessagingKit
@code
[self startChat:sender];
@endcode

@remark This is a button action method
*/
-(IBAction)startChat:(id)sender
{
    BOOL enableSecurity = YES;
    NSString * botURL;
    botURL = PRE_LOGIN_EXAMPLE_URL;
    NSString * botID;
    botID = PRE_LOGIN_EXAMPLE_BOT_ID;
    MFSDKProperties *params = [[MFSDKProperties alloc] initWithDomain:botURL];
    //adding bot name
    [params addBot:botID botName:PRE_LOGIN_BOT_NAME];
    //rooted device and security check
    [params enableCheck:enableSecurity];
    params.messagingDelegate = self;
    //setting of app version
    NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    params.appVersion = version;
    [[MFSDKMessagingManager sharedInstance] initWithProperties:params];
    MFSDKSessionProperties *sessionProperties = [[MFSDKSessionProperties alloc]init];
    //setting voice recognition google api key
    sessionProperties.speechAPIKey = SPEECH_API_KEY;
    //setting bot language
    sessionProperties.shouldSupportMultiLanguage = YES;
    sessionProperties.language = _languageCode;
    if([(AppDelegate *)[[UIApplication sharedApplication] delegate] handleNotificationOnLaunch]){
        if([(AppDelegate *)[[UIApplication sharedApplication] delegate] userInfoDic]!=nil){
            if ([sender isKindOfClass:[NSDictionary class]]){
                NSDictionary *userInfo = (NSDictionary *)sender;
                sessionProperties.pushData = userInfo;
            }
        }
    }else{
        if ([sender isKindOfClass:[NSDictionary class]]){
            NSDictionary *userInfo = (NSDictionary *)sender;
            sessionProperties.pushData = userInfo;
        }
    }
    //set bot header and customize the design
    [self createAndSetBotHeader:params withSessionProperties:sessionProperties];
    self.objWebScreen = [[MFSDKMessagingManager sharedInstance] showScreenWithBotID:botID fromViewController:self withSessionProperties:sessionProperties];
}

/**
languageAction
 
@remark This method is called when language selection button is tapped
 
*/

- (IBAction)languageAction:(id)sender {
    [self.languagePickerView setHidden:NO];
}

/**
backgroundTapped
 
@remark This method is called when anywhere view screen of this controller is tapped
 
*/
-(IBAction)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
}

/**
pickerDoneAction
 
@remark This method is called when done button is clicked after selecting the language
 
*/
- (IBAction)pickerDoneAction:(id)sender {
    if (_languageTitle.length > 0){
        [self.objLanguageButton setTitle:(_languageTitle) forState:UIControlStateNormal];
    }
    else{
        [self.objLanguageButton setTitle:(ENGLISH) forState:UIControlStateNormal];
    }
    [self.languagePickerView setHidden:YES];
}

/**
 Staus bar lightens to white color
 
 @return return value description
 */
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/**
 Text field delegate
 
 @param textField textField description
 @return return value description
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

/**
 UIPicker Delegate
 
 @param pickerView pickerView description
 @return number of components
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
/**
UIPicker Delegate

@param pickerView pickerView description
@return number of rows
*/
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _pickerData.count;
}
/**
UIPicker Delegate

@param pickerView pickerView description
 
@return Title string for the component specific row
*/
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _pickerDataTitle[row];
}
/**
UIPicker Delegate

@param pickerView pickerView description
@remark This is a callback method is called when picker view row is selected by the user
 
*/
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _languageTitle = _pickerDataTitle[row];
    _languageCode = _pickerData[row];
}

/*!
@brief Implement on logout callback from bot screen

@discussion This method will let the project handle the logout scenarios of bot and do the required action further

@param logoutType is the logout code which suggests the scenario through which bot got logged out
 
@remark This is a callback method to be implemented by the integrator project
*/
-(void)onLogout:(NSInteger)logoutType
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:ALERT_TITLE message:[NSString stringWithFormat:@"%@ : %ld",LOGOUT_ALERT_MESSAGE,(long)logoutType] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *oneAction = [UIAlertAction actionWithTitle:ALERT_PRIMARY_BUTTON style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
    {
        // call method whatever u need
        [self.objWebScreen dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:oneAction];
    [self.objWebScreen presentViewController:alert animated:YES completion:nil];
}

/*!
@brief Implement onChatClose callback from bot screen

@discussion This method will let the project handle the bot screen closing scenarios through user's back action or any other reason
 
@remark This is a callback method to be implemented by the integrator project
*/
-(void)onChatClose
{
    self.objWebScreen = nil;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:ALERT_TITLE message:[NSString stringWithFormat:CLOSE_ALERT_MESSAGE] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *oneAction = [UIAlertAction actionWithTitle:ALERT_PRIMARY_BUTTON style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:oneAction];
    [self presentViewController:alert animated:YES completion:nil];
}

/*!
@brief Implement onSearchResponse callback from bot screen

@discussion This method will let the project handle code to display native screens

@param model contains menuCode which suggests the project which screen to open also it has payload property from which data can be passed from bot to integrator project
 
@remark This is a callback method to be implemented by the integrator project
*/

-(void)onSearchResponse:(MFSearchResponseModel *)model{
    
    //handle code to display native screens
    NSLog(@"onSearchResponse: %@",model.menuCode);
}

/*!
@brief Implement color objcect conversion from hex code

@discussion This method will get the UIColor object from the hex code passed in params

@param hexString contains the color hex code passed
@remark This is a color conversion method 
*/
- (UIColor *) colorFromHexString:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

/*!
@brief Implement askTohandlePushTapWithUserInfo callback of MFNotificationKitManagerDelegate

@discussion This method will let the project handle the HUD tap action

@param userInfo contains the push data which can be passed to open bot
@remark This is a callback method to be implemented by the integrator project
*/
-(void)askTohandlePushTapWithUserInfo:(MFNotificationData*)userInfo{
    // open chat by passing push data
    if(userInfo!=nil){
        [self startChat:userInfo];
    }
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] setPropertiesNil];
}
/*!
@brief Implement createAndSetBotHeader for setting up bot header UI

@discussion This method will create header design & UI and will set it for the bot

@param sdkProperties will be the MFSDKProperties object passed from the bot invoking method
 
@param sessionProperties will be the MFSDKSessionProperties object passed from the bot invoking method

@remark This method is to design and customize bot header
*/
-(void)createAndSetBotHeader:(MFSDKProperties*)sdkProperties withSessionProperties:(MFSDKSessionProperties*)sessionProperties{
    // setting up bot header
        sdkProperties.showNativeNavigationBar = YES;
        MFSDKHeader *headerObject = [[MFSDKHeader alloc]init];
        headerObject.isCustomNavigationBar = YES;
        headerObject.titleText = BOT_HEADER_TEXT;
        headerObject.titleAlignment = CENTER_ALIGN;
        headerObject.titleColor = HEADER_TITLE_COLOR;
        headerObject.titleFontName = HEADER_TITLE_FONT_NAME;
        headerObject.titleFontSize = HEADER_TITLE_FONT_SIZE;
        headerObject.backgroundColor = HEADER_BACKGROUND_COLOR;
        //right button
        headerObject.rightButtonAction = HOME_BUTTON;
        headerObject.rightButtonImage = HEADER_LEFT_BAR_IMG;
        //left button
        headerObject.leftButtonAction = BACK_BUTTON;
        headerObject.leftButtonImage = HEADER_LEFT_BAR_IMG;
        [sessionProperties setHeader:headerObject];
}
@end

