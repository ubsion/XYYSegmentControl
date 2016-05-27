

Pod::Spec.new do |s|

 

  s.name         = "XYYSegmentControl"
  s.version      = "1.3.1"
  s.summary      = "SegmentControl of XYYSegmentControl for develop"

  s.description  = <<-DESC
                      SegmentControl of XYYSegmentControl for developers
                   DESC

  s.homepage     = "https://github.com/1273011249/XYYSegmentControl"


  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "xuyong" => "1273011249@qq.com" }

  s.platform     = :ios, '7.0'


  s.source       = { :git => "https://github.com/1273011249/XYYSegmentControl.git", :tag => "1.3.1" }


  s.source_files  = "Classes", "XYYSegmentControl/Classes/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  s.public_header_files = "XYYSegmentControl/Classes/*.h"

  s.requires_arc = true

end
