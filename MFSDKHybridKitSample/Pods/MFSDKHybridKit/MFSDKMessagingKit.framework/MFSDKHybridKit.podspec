Pod::Spec.new do |s|
s.name         = "MFSDKHybridKit"
s.version      = "2.5.0"
s.summary      = "Morfeus messaging framework for hybrid."
s.description  = <<-DESC
Morfeus messaging framework for hybrid. Cheers
DESC
s.homepage     = "https://active.ai"
s.license      = { :type => "MIT", :file => "license" }
s.author             = { "active ai" => "mobile.release@active.ai" }
s.ios.deployment_target = '8.0'
#s.platform     = :ios, '7.1'
s.ios.vendored_frameworks = 'MFSDKMessagingKit.framework'
s.source = { :http => 'http://artifacts.active.ai/artifactory/ios-sdk-release/LatestBuild/MFSDKHybridKit/2.5.0/MFSDKHybridKit.zip' }
s.exclude_files = "Classes/Exclude"
s.resources = ["MFSDKMessagingKit.framework/MFSDKMessagingKit.momd","MFSDKMessagingKit.framework/MFSDKMessagingKit.momd/*","MFSDKMessagingKit.framework/MFLanguages.json","MFSDKMessagingKit.framework/MFLanguages.json/*","Resources/*.json"]
s.dependency 'MorfeusVoiceKit'
end
