Pod::Spec.new do |s|
s.name         = "MFNotificationKit"
s.version      = "1.0.0"
s.summary      = "Morfeus Notification framework for hybrid."
s.description  = <<-DESC
Morfeus Notification framework for hybrid. Cheers
DESC
s.homepage     = "https://active.ai"
s.license      = { :type => "MIT", :file => "license" }
s.author             = { "active ai" => "mobile.release@active.ai" }
s.ios.deployment_target = '8.0'
#s.platform     = :ios, '7.1'
s.ios.vendored_frameworks = 'MFNotificationKit.framework'
s.source = { :http => 'http://artifacts.active.ai/artifactory/ios-sdk-release/LatestBuild/MFNotificationKit/1.0.0/MFNotificationKit.zip' }
s.exclude_files = "Classes/Exclude"
s.resources = []
end
