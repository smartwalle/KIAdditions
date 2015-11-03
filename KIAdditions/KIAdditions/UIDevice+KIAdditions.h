//
//  UIDevice+KIAdditions.h
//  Kitalker
//
//  Created by 杨 烽 on 13-11-7.
//
//

#import <UIKit/UIKit.h>

/**************************************************
 *屏幕尺寸相关
 **************************************************/

/*判断当前设备是否为3.5寸屏*/
#define KI_DEVICE_35_INCH ([[UIDevice currentDevice] is35Inch])

/*判断当前设备是否为4.0寸屏*/
#define KI_DEVICE_40_INCH  ([[UIDevice currentDevice] is40Inch])

/*判断当前设备是否为4.7寸屏*/
#define KI_DEVICE_47_INCH  ([[UIDevice currentDevice] is47Inch])

/*判断当前设备是否为5.5寸屏*/
#define KI_DEVICE_55_INCH  ([[UIDevice currentDevice] is55Inch])


/**************************************************
 *设备型号相关
 **************************************************/

/*判断当前设备是否为iPad*/
#define KI_DEVICE_PAD  ([[UIDevice currentDevice] isPad])

/*判断当前设备是否为iPhone*/
#define KI_DEVICE_PHONE ([[UIDevice currentDevice] isPhone])

/*判断当前设备是否为iTouch*/
#define KI_DEVICE_TOUCH ([[UIDevice currentDevice] isTouch])


/*判断当前设备是否为真机*/
#define KI_DEVICE_OS        !TARGET_IPHONE_SIMULATOR

/*判断当前设备是否为模拟器*/
#define KI_DEVICE_SIMULATOR TARGET_IPHONE_SIMULATOR


/*判断当前设备是否为iPhone真机*/
#define KI_DEVICE_PHONE_OS          (KI_DEVICE_PHONE && KI_DEVICE_OS)

/*判断当前设备是否为iPhone模拟器*/
#define KI_DEVICE_PHONE_SIMULATOR   (KI_DEVICE_PHONE && KI_DEVICE_SIMULATOR)

/*判断当前设备是否为iPad真机*/
#define KI_DEVICE_PAD_OS            (KI_DEVICE_PAD && KI_DEVICE_OS)

/*判断当前设备是否为iPad模拟器*/
#define KI_DEVICE_PAD_SIMULATOR     (KI_DEVICE_PAD && KI_DEVICE_SIMULATOR)

/*判断当前设备是否为iTouch真机*/
#define KI_DEVICE_TOUCH_OS          (KI_DEVICE_TOUCH && KI_DEVICE_OS)


/**************************************************
 *系统版本相关
 **************************************************/

/*判断当前系统版本号是否等于某个值*/
#define KISystemVersionEqualTo(version)                 ([[[UIDevice currentDevice] systemVersion] compare:version\
                                                                options:NSNumericSearch] == NSOrderedSame)

/*判断当前系统版本号是否大于某个值*/
#define KISystemVersionGreaterThan(version)             ([[[UIDevice currentDevice] systemVersion] compare:version\
                                                                options:NSNumericSearch] == NSOrderedDescending)

/*判断当前系统版本号是否大于等于某个值*/
#define KISystemVersionGreaterThanOrEqualTo(version)    ([[[UIDevice currentDevice] systemVersion] compare:version\
                                                                options:NSNumericSearch] != NSOrderedAscending)

/*判断当前系统版本号是否小于某个值*/
#define KISystemVersionLessThan(version)                ([[[UIDevice currentDevice] systemVersion] compare:version\
                                                                options:NSNumericSearch] == NSOrderedAscending)

/*判断当前系统版本号是否小于等于某个值*/
#define KISystemVersionLessThanOrEqualTo(version)       ([[[UIDevice currentDevice] systemVersion] compare:version\
                                                                options:NSNumericSearch] != NSOrderedDescending)

/*判断当前系统版本号是否大于等于8.0*/
#define KI_IOS_8_OR_LATER (KISystemVersionGreaterThanOrEqualTo(@"8.0"))

/*判断当前系统版本号是否大于等于7.0*/
#define KI_IOS_7_OR_LATER (KISystemVersionGreaterThanOrEqualTo(@"7.0"))

/*判断当前系统版本号是否大于等于6.0*/
#define KI_IOS_6_OR_LATER (KISystemVersionGreaterThanOrEqualTo(@"6.0"))

/*判断当前系统版本号是否大于等于5.0*/
#define KI_IOS_5_OR_LATER (KISystemVersionGreaterThanOrEqualTo(@"5.0"))

/*判断当前系统版本号是否大于等于4.3*/
#define KI_IOS_4_3_OR_LATER (KISystemVersionGreaterThanOrEqualTo(@"4.3"))


@interface UIDevice (KIAdditions)

/*换取当前连接的wifi ssid*/
- (NSString *)wifiSSID;

/*获取设备IP地址*/
- (NSDictionary *)IPAddresses;

- (NSString *)wifiIPv4Address;

- (NSString *)wifiIPv6Address;

- (NSString *)cellularIPv4Address;

- (NSString *)cellularIPv6Address;

/*当前设备的系统版本号*/
- (float)deviceSystemVersion;

/*当前设备模型*/
- (NSString *)deviceModel;

- (NSString *)machineName;

/*当前设备模型详细*/
- (NSString *)machineDetail;

/*当前设备名称*/
- (NSString *)deviceName;

/*当前设备是否为iPad*/
- (BOOL)isPad;

/*当前设备是否为iPhone*/
- (BOOL)isPhone;

/*当前设备是否为iPod touch*/
- (BOOL)isTouch;

/*当前设备是否为视网膜屏*/
- (BOOL)isRetina;

/*3.5 inch 4\4s\pod4 */
- (BOOL)is35Inch;

/*4.0 inch 5\5s\5c\pod5 */
- (BOOL)is40Inch;

/*4.7 inch 6 */
- (BOOL)is47Inch NS_AVAILABLE_IOS(8_0);

/*5.5 inch 6+ */
- (BOOL)is55Inch NS_AVAILABLE_IOS(8_0);

- (natural_t)getFreeMemory;

/*震动设备*/
- (void)vibrateDevice;

/*播放提示音*/
- (void)playToneWithFilePath:(NSString *)filePath;

@end
