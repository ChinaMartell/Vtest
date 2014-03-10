Pod::Spec.new do |s|


  s.name         = "VFoundation"
  s.version      = "0.9"
  s.summary      = "a powerful foundation for ios"

  s.description  = <<-DESC
                   A longer description of VFoundation in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/ChinaMartell/VFoundation"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "shadowxie" => "shashadowdow@gmail.com", "jessieyong" => "527068687@qq.com" }
  s.platform     = :ios, '5.0'
  s.source       = { :git => "https://github.com/ChinaMartell/VFoundation.git" ,:tag => '0.9'}
  s.source_files =  '*'
  s.frameworks    =  'Foundation' , 'UIKit'
  s.requires_arc = true
end
