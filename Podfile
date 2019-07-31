# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'recipepuppy' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

    pod 'RxSwift', git: 'https://github.com/ReactiveX/RxSwift.git', branch: 'rxswift4.0-swift4.0'
    pod 'RxCocoa', git: 'https://github.com/ReactiveX/RxSwift.git', branch: 'rxswift4.0-swift4.0'

  target 'recipepuppyTests' do
    inherit! :search_paths
    pod 'RxTest', git: 'https://github.com/ReactiveX/RxSwift.git', branch: 'rxswift4.0-swift4.0'
    pod 'RxBlocking', git: 'https://github.com/ReactiveX/RxSwift.git', branch: 'rxswift4.0-swift4.0'
    pod 'OHHTTPStubs/Swift'
  end

end
