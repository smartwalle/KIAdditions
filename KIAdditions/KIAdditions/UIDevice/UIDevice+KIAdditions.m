//
//  UIDevice+KIAdditions.m
//  Kitalker
//
//  Created by 杨 烽 on 13-11-7.
//
//

#import "UIDevice+KIAdditions.h"
//#import <net/if.h>
#import <net/if_dl.h>
#import <sys/sysctl.h>
#import <sys/socket.h>
#import <AudioToolbox/AudioToolbox.h>
#import <arpa/inet.h>
#import <netdb.h>
#import <net/if.h>
#import <ifaddrs.h>
#import <dlfcn.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <SystemConfiguration/CaptiveNetwork.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@implementation UIDevice (KIAdditions)


/*
- (NSString *)getMacAddress {
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = NULL;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else
    {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else
        {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else
            {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    
    // Befor going any further...
    if (errorFlag != NULL) {
        KILog(@"Error: %@", errorFlag);
        return errorFlag;
    }
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    // Release the buffer memory
    free(msgBuffer);
    return macAddressString;
}
*/

- (NSString *)wifiSSID {
    NSString *ssid = nil;
    NSArray *ifs = (__bridge id)CNCopySupportedInterfaces();
    for (NSString *ifname in ifs) {
        NSDictionary *info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifname);
        if (info[@"SSID"]) {
            ssid = info[@"SSID"];
        }
    }
    return ssid;
}

- (NSDictionary *)IPAddresses {
    static NSMutableDictionary *addresses = nil;
    if (addresses == nil) {
        addresses = [[NSMutableDictionary alloc] init];
        struct ifaddrs *interfaces;
        if(!getifaddrs(&interfaces)) {
            struct ifaddrs *interface;
            for(interface=interfaces; interface; interface=interface->ifa_next) {
                if(!(interface->ifa_flags & IFF_UP) || (interface->ifa_flags & IFF_LOOPBACK)) {
                    continue;
                }
                const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
                if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                    NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                    char addrBuf[INET6_ADDRSTRLEN];
                    if(inet_ntop(addr->sin_family, &addr->sin_addr, addrBuf, sizeof(addrBuf))) {
                        NSString *key = [NSString stringWithFormat:@"%@/%@", name, addr->sin_family == AF_INET ? IP_ADDR_IPv4 : IP_ADDR_IPv6];
                        addresses[key] = [NSString stringWithUTF8String:addrBuf];
                    }
                }
            }
            freeifaddrs(interfaces);
        }
    }
    return [addresses count] ? addresses : nil;
}

- (NSString *)wifiIPv4Address {
    return [[self IPAddresses] objectForKey:@"en0/ipv4"];
}

- (NSString *)wifiIPv6Address {
    return [[self IPAddresses] objectForKey:@"en0/ipv6"];
}

- (NSString *)cellularIPv4Address {
    return [[self IPAddresses] objectForKey:@"pdp_ip0/ipv4"];
}

- (NSString *)cellularIPv6Address {
    return [[self IPAddresses] objectForKey:@"pdp_ip0/ipv6"];
}

/*设备相关*/
- (float)deviceSystemVersion {
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    return version;
}

- (NSString *)deviceModel {
    NSString *model = [[UIDevice currentDevice] model];
    return model;
}

- (NSString *)machineName {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *machineName = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return machineName;
}

- (NSString *)machineDetail {
    NSString *machineName = [self machineName];
    static NSDictionary *deviceList = nil;
    if (deviceList == nil) {
        //        逗号后面数字解释：(i386是指模拟器)
        //        1-WiFi版
        //        2-GSM/WCDMA 3G版
        //        3-CDMA版
        deviceList = @{
                       @"iPhone1,1": @"iPhone 2G",
                       @"iPhone1,2": @"iPhone 3G",
                       @"iPhone2,1": @"iPhone 3GS",
                       @"iPhone3,1": @"iPhone 4",
                       @"iPhone3,2": @"iPhone 4",
                       @"iPhone3,3": @"iPhone 4 (CDMA)",
                       @"iPhone4,1": @"iPhone 4S",
                       @"iPhone5,1": @"iPhone 5",
                       @"iPhone5,2": @"iPhone 5 (GSM+CDMA)",
                       
                       @"iPhone5,3": @"iPhone 5c",
                       @"iPhone5,4": @"iPhone 5c",
                       
                       @"iPhone6,1": @"iPhone 5s",
                       @"iPhone6,2": @"iPhone 5s",
                       
                       @"iPod1,1": @"iPod Touch (1 Gen)",
                       @"iPod2,1": @"iPod Touch (2 Gen)",
                       @"iPod3,1": @"iPod Touch (3 Gen)",
                       @"iPod4,1": @"iPod Touch (4 Gen)",
                       @"iPod5,1": @"iPod Touch (5 Gen)",
                       
                       @"iPad1,1": @"iPad",
                       @"iPad1,2": @"iPad 3G",
                       @"iPad2,1": @"iPad 2 (WiFi)",
                       @"iPad2,2": @"iPad 2",
                       @"iPad2,3": @"iPad 2 (CDMA)",
                       @"iPad2,4": @"iPad 2",
                       @"iPad2,5": @"iPad Mini (WiFi)",
                       @"iPad2,6": @"iPad Mini",
                       @"iPad2,7": @"iPad Mini (GSM+CDMA)",
                       @"iPad3,1": @"iPad 3 (WiFi)",
                       @"iPad3,2": @"iPad 3 (GSM+CDMA)",
                       @"iPad3,3": @"iPad 3",
                       @"iPad3,4": @"iPad 4 (WiFi)",
                       @"iPad3,5": @"iPad 4",
                       @"iPad3,6": @"iPad 4 (GSM+CDMA)",
                       
                       @"iPad4,1": @"iPad Air (WiFi)",
                       @"iPad4,2": @"iPad Air",
                       @"iPad4,4": @"iPad Mini 2 (WiFi)",
                       @"iPad4,5": @"iPad Mini 2",
                       
                       @"i386": @"Simulator(i386)",
                       @"x86_64": @"Simulator(x86_64)"
                       };
    }
    NSString *name = [deviceList objectForKey:machineName];
    if (name == nil) {
        name = machineName;
    }
    return name;
}

- (NSString *)deviceName {
    NSString *name = [[UIDevice currentDevice] name];
    return name;
}

- (BOOL)isPad {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
}

- (BOOL)isPhone {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone);
}

- (BOOL)isTouch {
    return [[self deviceModel] rangeOfString:@"iPod"].location != NSNotFound;
}

- (BOOL)isRetina {
    static BOOL isRetina = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
            if ([[UIScreen mainScreen] scale] >= 2) {
                isRetina = YES;
            }
        }
    });
    return isRetina;
}

- (BOOL)is35Inch {
    static BOOL isPhone4 = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([self isPhone]) {
            if ([[UIScreen mainScreen] bounds].size.height * [[UIScreen mainScreen] bounds].size.width == 320.0f * 480.0f) {
                isPhone4 = YES;
            }
        }
    });
    return isPhone4;
}

- (BOOL)is40Inch {
    static BOOL isPhone5 = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([self isPhone]) {
            if ([[UIScreen mainScreen] bounds].size.height * [[UIScreen mainScreen] bounds].size.width == 320.0f * 568.0f) {
                isPhone5 = YES;
            }
        }
    });
    return isPhone5;
}

- (BOOL)is47Inch {
    static BOOL isPhone6 = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
        if ([self isPhone]) {
            if ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]) {
                if ((([[UIScreen mainScreen] nativeBounds].size.height * [[UIScreen mainScreen] nativeBounds].size.width) / [[UIScreen mainScreen] nativeScale]) == 375.0f * 667.0f) {
                    isPhone6 = YES;
                }
            } else if ([[UIScreen mainScreen] bounds].size.height * [[UIScreen mainScreen] bounds].size.width == 375.0f * 667.0f) {
                isPhone6 = YES;
            }
        }
#endif
    });
    return isPhone6;
}

- (BOOL)is55Inch {
    static BOOL isPhone6p = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
        if ([self isPhone]) {
            if ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]) {
                if ((([[UIScreen mainScreen] nativeBounds].size.height * [[UIScreen mainScreen] nativeBounds].size.width) / [[UIScreen mainScreen] nativeScale]) == 414.0f * 736.0f) {
                    isPhone6p = YES;
                }
            } else if ([[UIScreen mainScreen] bounds].size.height * [[UIScreen mainScreen] bounds].size.width == 414.0f * 736.0f) {
                isPhone6p = YES;
            }
        }
#endif
    });
    return isPhone6p;
}

- (natural_t)getFreeMemory {
    mach_port_t host_port;
    mach_msg_type_number_t host_size;
    vm_size_t pagesize;
    
    host_port = mach_host_self();
    host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    host_page_size(host_port, &pagesize);
    
    vm_statistics_data_t vm_stat;
    
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
        return 0;
    }
    
    /* Stats in bytes */
    natural_t mem_free = vm_stat.free_count * (natural_t)pagesize;
    return mem_free;
}

- (void)vibrateDevice {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (void)playToneWithFilePath:(NSString *)filePath {
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:filePath], &soundID);
    AudioServicesPlaySystemSound (soundID);
}

@end
