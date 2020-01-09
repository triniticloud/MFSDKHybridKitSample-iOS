//
//  LoginViewController.m
//  HybridSample
//
//  Created by Active.AI on 07/01/20.
//

#import "LoginViewController.h"
#import <MFSDKMessagingKit/MFSDKMessagingManager.h>
#import <MFNotificationKit/MFSDKNotificationKitManager.h>
#import "AppDelegate.h"
#import "ProjectStringConstant.h"

@interface LoginViewController ()<MFSDKMessagingDelegate,MFNotificationKitManagerDelegate>
- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *postLoginFlowButton;
@property(nonatomic,weak)UIViewController *objWebScreen;
@property (weak, nonatomic) IBOutlet UITextField *customerIDField;
@property (weak, nonatomic) IBOutlet UITextField *sessionIDField;

- (IBAction)loginAction:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 8.2, *)) {
        [self.postLoginFlowButton.titleLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightBold]];
    }
    self.postLoginFlowButton.layer.cornerRadius = 8.0f;
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)loginAction:(id)sender {
    [self startChat:nil];
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
    if(self.customerIDField.text.length>0&&self.sessionIDField.text.length>0){
        BOOL enableSecurity = YES;
        NSString * botURL;
        botURL = POST_LOGIN_EXAMPLE_URL;
        NSString * botID;
        botID = POST_LOGIN_EXAMPLE_BOT_ID;
        NSString *custID;
        custID = self.customerIDField.text;
        NSString *sessionId;
        sessionId = self.sessionIDField.text;
        MFSDKProperties *params = [[MFSDKProperties alloc] initWithDomain:botURL];
        [params addBot:botID botName:POST_LOGIN_BOT_NAME];
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
        //passing post login related data in userInfo property of sessionProperties
        NSDictionary *userInfo = @{USER_INFO_KEY1:custID,USER_INFO_KEY2:sessionId};
        sessionProperties.userInfo = userInfo;
        self.objWebScreen = [[MFSDKMessagingManager sharedInstance] showScreenWithBotID:botID fromViewController:self withSessionProperties:sessionProperties];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:ALERT_TITLE message:[NSString stringWithFormat:USER_INFO_TEXT_VALIDATION_ERROR] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *oneAction = [UIAlertAction actionWithTitle:ALERT_PRIMARY_BUTTON style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
        {
            [self.objWebScreen dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:oneAction];
        [self presentViewController:alert animated:YES completion:nil];

    }
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
    //[self dismissViewControllerAnimated:YES completion:nil];
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
