Pod::Spec.new do |s|
  s.name         = "KIAdditions"
  s.version      = "0.0.6"
  s.summary      = "KIAdditions"

  s.description  = <<-DESC
                   KIAdditions.
                   DESC

  s.homepage     = "https://github.com/smartwalle/KIAdditions"
  s.license      = "MIT"
  s.author       = { "SmartWalle" => "smartwalle@gmail.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/smartwalle/KIAdditions.git", :tag => "#{s.version}", :submodules => true }
#  s.source_files  = "KIAdditions/KIAdditions/*.{h,m}"
#  s.exclude_files = "Classes/Exclude"

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  s.requires_arc = true

  s.subspec 'NSArray' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/NSArray/*.{h,m}"
  end

  s.subspec 'NSBundle' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/NSBundle/*.{h,m}"
  end

  s.subspec 'NSData' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/NSData/NSData+KIAdditions.{h,m}"
  end

  s.subspec 'NSDate' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/NSDate/NSDate+KIAdditions.{h,m}"
  end

  s.subspec 'NSDictionary' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/NSDictionary/NSDictionary+KIAdditions.{h,m}"
  end

  s.subspec 'NSFileManager' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/NSFileManager/NSFileManager+KIAdditions.{h,m}"
    ss.dependency 'KIAdditions/NSBundle'
  end

  s.subspec 'NSLayoutConstraint' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/NSLayoutConstraint/NSLayoutConstraint+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
  end

  s.subspec 'NSMutableDictionary' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/NSMutableDictionary/NSMutableDictionary+KIAdditions.{h,m}"
  end

  s.subspec 'NSObject' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/NSObject/NSObject+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
    ss.dependency 'KIAdditions/NSData'
  end

  s.subspec 'NSString' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/NSString/NSString+KIAdditions.{h,m}"
  end

  s.subspec 'NSUserDefaults' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/NSUserDefaults/NSUserDefaults+KIAdditions.{h,m}"
  end

  s.subspec 'UIButton' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UIButton/UIButton+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
  end

  s.subspec 'UIColor' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UIColor/UIColor+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
  end

  s.subspec 'UIDevice' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UIDevice/UIDevice+KIAdditions.{h,m}"
    ss.frameworks    = "UIKit", "AudioToolbox", "SystemConfiguration"
  end

  s.subspec 'UIImage' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UIImage/*.{h,m}"
    ss.frameworks    = "UIKit", "Accelerate", "QuartzCore"
  end

  s.subspec 'UINavigationBar' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UINavigationBar/UINavigationBar+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
    ss.dependency 'KIAdditions/UIDevice'
  end

  s.subspec 'UINavigationController' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UINavigationController/UINavigationController+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
  end

  s.subspec 'UIScreen' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UIScreen/UIScreen+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
  end

  s.subspec 'UITableView' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UITableView/UITableView+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
  end

  s.subspec 'UITableViewCell' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UITableViewCell/UITableViewCell+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
  end

  s.subspec 'UITableViewController' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UITableViewController/UITableViewController+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
     ss.dependency 'KIAdditions/UITableView'
  end

  s.subspec 'UITextField' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UITextField/UITextField+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
  end

  s.subspec 'UIViewController' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UIViewController/UIViewController+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
  end

  s.subspec 'UICollectionView' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UICollectionView/UICollectionView+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
  end

  s.subspec 'UICollectionViewCell' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UICollectionViewCell/UICollectionViewCell+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
  end

  s.subspec 'UISearchBar' do |ss|
    ss.source_files  = "KIAdditions/KIAdditions/UISearchBar/UISearchBar+KIAdditions.{h,m}"
    ss.framework     = "UIKit"
  end

end
