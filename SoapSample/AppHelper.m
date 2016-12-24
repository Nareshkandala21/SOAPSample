//
//  AppHelper.m
//  IntroduceThem
//
//  Created by Aravind Kumar on 13/06/11.
//  Copyright 2011 Tata Consultant Services. All rights reserved.
//

#import "AppHelper.h"
#import <objc/runtime.h>



@implementation AppHelper {
    UIPopoverController * popoverController;
}

static AppHelper *utility = nil;


+ (AppHelper *)sharedInstance {
    
    @synchronized(self) {
        if (!utility)
            utility = [[AppHelper alloc] init];
    }
    return utility;
}

+(id)alloc {
    
    @synchronized(self) {
        NSAssert(utility == nil, @"Attempted to allocate a second instance of a singleton class");
        return [super alloc];
    }
    return nil;
}
+(NSString *)nullCheck:(id)str {
    
    if (str == nil) {
        return @"";
    }
    return (str ==[NSNull null])?@"":str;
}
-(NSDate*)getNextYearDate:(NSDate*)date year:(NSString*)year {
    NSCalendar *calnder=[NSCalendar currentCalendar];
    NSDateComponents *compnet=[calnder components:NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay fromDate:date];
    NSDateComponents *refCmnt=[[NSDateComponents alloc]init];
    [refCmnt setDay:compnet.day];
      [refCmnt setMonth:compnet.month];
    [refCmnt setYear:compnet.year+ [year intValue]];
    NSLog(@"%@",[calnder dateFromComponents:refCmnt]);
    return [calnder dateFromComponents:refCmnt];
    
}
-(NSDate*)getDate:(NSDate*)date year:(NSString*)year month:(NSString*)month {
    NSCalendar *calnder=[NSCalendar currentCalendar];
    NSDateComponents *compnet=[calnder components:NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay fromDate:date];
    NSDateComponents *refCmnt=[[NSDateComponents alloc]init];
    [refCmnt setDay:7];
    [refCmnt setMonth:[month intValue]];
    [refCmnt setYear:compnet.year+ [year intValue]];
    NSLog(@"%@",[calnder dateFromComponents:refCmnt]);
    return [calnder dateFromComponents:refCmnt];
    
}
+(NSArray *)allPropertyNamesOfClass:(Class)class{
    unsigned count;
    objc_property_t *properties = class_copyPropertyList(class, &count);
    
    NSMutableArray *rv = [NSMutableArray array];
    
    unsigned i;
    for (i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        [rv addObject:name];
    }
    
    free(properties);
    
    return rv;
}
+ (UINavigationController *)navigationController
{
    return (UINavigationController *)[[[AppHelper appDelegate] window] rootViewController];
}
-(void )showIndicator{
    UINavigationController *navi=[AppHelper navigationController];
    HUD = [[MBProgressHUD alloc] initWithView:navi.view];
    HUD.progress        = 5.0f;
    HUD.mode            = MBProgressHUDModeDeterminate;
    HUD.labelText =  @"Capturing Data!!! Please wait, It Will take few minuts ....";
    HUD.minSize = CGSizeMake(235.f, 100.f);
    [navi.view addSubview:HUD];
    [HUD show:YES];

}


-(void )hideIndicator{
    [HUD removeFromSuperview];
    [HUD hide:YES];
}


-(void )showIndicator2{
    UINavigationController *navi=[AppHelper navigationController];
    HUD = [[MBProgressHUD alloc] initWithView:navi.view];
    HUD.progress        = 5.0f;
    HUD.mode            = MBProgressHUDModeDeterminate;
    HUD.labelText =  @"Uploading..";
    HUD.minSize = CGSizeMake(235.f, 100.f);
    [navi.view addSubview:HUD];
    [HUD show:YES];
    
}


-(void )hideIndicator2{
    [HUD removeFromSuperview];
    [HUD hide:YES];
}






+ (AppDelegate*) appDelegate {
    return (AppDelegate*)[[UIApplication sharedApplication]  delegate];
}

+(UIViewController *)intialiseViewControllerFromMainStoryboardWithName:(NSString *)vcName
{
    return  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:vcName];
}
-(void)initPopoverWithViewController:(UIViewController*)vc direction:(UIPopoverArrowDirection)arrowDirection senderRect:(CGRect)rect inView:(UIView *)inView  {
    
    
    //if (!popoverController) {
    popoverController         = [[UIPopoverController alloc] initWithContentViewController:vc];
        popoverController.popoverContentSize = vc.view.frame.size;
    [popoverController presentPopoverFromRect:rect inView:inView permittedArrowDirections:arrowDirection animated:YES];
}
-(MBProgressHUD *)getCurrentHud {
    
   
    return HUD?HUD:nil;
    
}

-(UIPopoverController *)curruntPopOver {
    
    return popoverController?popoverController:nil;
}
//normalize image
+(UIImage *)normalizedImage:(UIImage *)image
{
    if (image.imageOrientation == UIImageOrientationUp) return image;
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    [image drawInRect:(CGRect){0, 0, image.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}

+(void)saveToUserDefaults:(id)value withKey:(NSString*)key
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
	if (standardUserDefaults) {
		[standardUserDefaults setObject:value forKey:key];
		[standardUserDefaults synchronize];
	}
}

+(NSString*)userDefaultsForKey:(NSString*)key
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSString *val = nil;
	
	if (standardUserDefaults)
		val = [standardUserDefaults objectForKey:key];
	
	return val;
}
+(void)removeFromUserDefaultsWithKey:(NSString*)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults removeObjectForKey:key];
    [standardUserDefaults synchronize];
}


////----- show a alert massage
+ (void) showAlertViewWithTag:(NSInteger)tag title:(NSString*)title message:(NSString*)msg delegate:(id)delegate
            cancelButtonTitle:(NSString*)CbtnTitle otherButtonTitles:(NSString*)otherBtnTitles
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:delegate
										  cancelButtonTitle:CbtnTitle otherButtonTitles:otherBtnTitles, nil];
    alert.tag = tag;
	[alert show];
}


+(UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1];
    // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


+(NSString *) hexFromUIColor:(UIColor *)color
{
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0] green:components[0] blue:components[0] alpha:components[1]];
    }
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    return [NSString stringWithFormat:@"#%02X%02X%02X", (int)((CGColorGetComponents(color.CGColor))[0]*255.0), (int)((CGColorGetComponents(color.CGColor))[1]*255.0), (int)((CGColorGetComponents(color.CGColor))[2]*255.0)];
}

#pragma mark Email Validation
+(BOOL)emailValidate:(NSString *)checkString
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

@end
