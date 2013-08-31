Pod::Spec.new do |s|
  s.name             =  "KFToolbar"
  s.version          =  "0.0.6"
  s.license          =  { :type => 'MIT', :file => 'LICENSE' }
  s.summary          =  "An UIView subview that handles KFToolbarItems."
  
  s.homepage         =  "https://pods.kf-interactive.com"
  s.authors          =  { "Rico Becker" => "rico.becker@kf-interactive.com", "Gunnar Herzog" => "gunnar.herzog@kf-interactive.com"}
  s.source           =  { :git => "https://github.com/ricobeck/KFToolbar.git", s.version.to_s }
  
  s.platform         =  :osx, 10.7
  
  s.framework        =  'Foundation'
  s.requires_arc     =  true
  s.source_files     =  'KFToolbar/Sources/**/*.{h,m}', 'KFToolbar/LICENSE'
end