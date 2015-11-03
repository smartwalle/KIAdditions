Pod::Spec.new do |s|
  s.name         = "KIAdditions"
  s.version      = "0.1"
  s.summary      = "KIAdditions"

  s.description  = <<-DESC
                   KIAdditions.
                   DESC

  s.homepage     = "https://github.com/smartwalle/KIAdditions"
  s.license      = "MIT"
  s.author       = { "SmartWalle" => "smartwalle@gmail.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/smartwalle/KIAdditions.git", :branch => "master" }
  s.source_files  = "KIAdditions/KIAdditions/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  s.requires_arc = true

  s.subspec 'NSBundle' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/NSBundle+KIAdditions.{h,m}"
  end

  s.subspec 'NSData' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/NSData+KIAdditions.{h,m}"
    ss.library       = "CommonCrypto"
  end

  s.subspec 'NSDate' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/NSDate+KIAdditions.{h,m}"
  end

  s.subspec 'NSDictionary' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/NSDictionary+KIAdditions.{h,m}"
  end

  s.subspec 'NSFileManager' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/NSFileManager+KIAdditions.{h,m}"
    ss.dependency 'KIAdditions/NSBundle'
  end

  s.subspec 'NSLayoutConstraint' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/NSLayoutConstraint+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
  end

  s.subspec 'NSMutableDictionary' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/NSMutableDictionary+KIAdditions.{h,m}"
  end

  s.subspec 'NSObject' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/NSObject+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
    ss.dependency 'KIAdditions/NSData'
  end

  s.subspec 'NSString' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/NSString+KIAdditions.{h,m}"
    ss.library       = "CommonCrypto"
    ss.dependency 'KIAdditions/NSData'
  end

  s.subspec 'NSUserDefaults' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/NSUserDefaults+KIAdditions.{h,m}"
  end

  s.subspec 'UIButton' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UIButton+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
  end

  s.subspec 'UIColor' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UIColor+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
  end

  s.subspec 'UIDevice' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UIDevice+KIAdditions.{h,m}"
    ss.frameworks    = "UIKit", "AudioToolbox", "SystemConfiguration"
  end

  s.subspec 'UIImage' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UIImage+KIAdditions.{h,m}"
    ss.frameworks    = "UIKit", "Accelerate", "QuartzCore"
  end

  s.subspec 'UIView' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UIView+KIAdditions.{h,m}"
    ss.framework     = "QuartzCore"
  end

  s.subspec 'UIImageView' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UIImageView+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
    ss.dependency 'KIAdditions/UIView'
    ss.dependency 'KIAdditions/UIImage'
  end

  s.subspec 'UINavigationBar' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UINavigationBar+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
    ss.dependency 'KIAdditions/UIDevice'
  end

  s.subspec 'UINavigationController' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UINavigationController+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
  end

  s.subspec 'UIScreen' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UIScreen+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
  end

  s.subspec 'UITableView' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UITableView+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
  end

  s.subspec 'UITableViewCell' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UITableViewCell+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
  end

  s.subspec 'UITableViewController' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UITableViewController+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
     ss.dependency 'KIAdditions/UITableView'
  end

  s.subspec 'UITextField' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UITextField+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
  end

  s.subspec 'UIViewController' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UIViewController+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
  end

end
