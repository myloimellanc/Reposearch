platform :ios, '12.0'


def network_pods
  pod 'Alamofire', '~> 5.4.4'
  pod 'AlamofireImage', '~> 4.2.0'
  pod 'ReachabilitySwift', '~> 5.0.0'
end

def rx_pods
  pod 'RxSwift', '~> 6.2.0'
  pod 'RxCocoa', '~> 6.2.0'
  pod 'RxDataSources', '~> 5.0.0'
  pod 'RxOptional', '~> 5.0.0'
  pod 'RxAlamofire', '~> 6.1.0'
end

def design_pods
  pod 'Toast-Swift', :git => 'https://github.com/myloimellanc/Toast-Swift.git'
end

def utility_pods
  pod 'R.swift', '~> 6.1.0'

end


target 'reposearch' do
#  inhibit_all_warnings!
#  use_frameworks!
  use_modular_headers!

  network_pods
  rx_pods
  design_pods
  utility_pods
end


post_install do | installer |
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      # for minimum deployment target of pod
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'

      # for use @testable import of cocoapods targets
      if config.name == 'Test'
        config.build_settings['ENABLE_TESTABILITY'] = 'YES'
      end
    end
  end
end
