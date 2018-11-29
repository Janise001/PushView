source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!
#Framework

install! 'cocoapods', :deterministic_uuids => false

#target:'Custom' do
#    pod 'SnapKit', :git => 'https://github.com/SnapKit/SnapKit'
#end

abstract_target 'CommonPods' do
    pod 'RxSwift', :git => 'https://github.com/ReactiveX/RxSwift'
    pod 'RxCocoa', :git => 'https://github.com/ReactiveX/RxSwift'
    pod 'RxGesture'
    pod 'RxSwiftExt'
    pod 'RxAnimated'
    pod 'RxOptional'
    pod 'RxKeyboard'
    
    pod 'SnapKit', :git => 'https://github.com/SnapKit/SnapKit'
    pod 'SDWebImage', :git => 'https://github.com/rs/SDWebImage'
    pod 'Result'
    pod 'FlexLayout'
   
   pod 'Alamofire'
    
    target:'PushView' do
        target 'PushViewUITests' do
            inherit! :search_paths
        end
        target 'PushViewTests' do
            inherit! :search_paths
        end
    end
end








#post_install do |installer|
#  installer.pods_project.targets.each do |target|
#    target.build_configurations.each do |config|
#      config.build_settings['SWIFT_VERSION'] = '4.0'
#      config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
#    end
#  end
#end
