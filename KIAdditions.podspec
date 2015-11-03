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

end
