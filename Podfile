# Uncomment the next line to define a global platform for your project
 platform :ios, '12.0'

# Comment the next line if you don't want to use dynamic frameworks
use_frameworks!

target 'Notely' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'VIPArchitechture', path: 'VIPArchitechture'
  pod 'Platform', path: 'Platform'
  pod 'Domain', path: 'Domain'
  pod 'SteviaLayout'
  pod 'RxCocoa'
  pod 'NSObject+Rx'
  pod 'R.swift'
  pod 'SwiftLint'
  pod 'MBProgressHUD'
  pod 'SwipeCellKit'
  pod 'RxGesture'
  pod 'RxRealm', git: 'git@github.com:trmquang93/RxRealm.git'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.respond_to?(:product_type) and target.product_type == "com.apple.product-type.bundle"
      target.build_configurations.each do |config|
        config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
      end
    end
    
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
  
  installer.pods_project.targets.each do |target|
    if target.name == 'RxSwift'
      target.build_configurations.each do |config|
        if config.name == 'Debug'
          config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
        end
      end
    end
  end
  
end
