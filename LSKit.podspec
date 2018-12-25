Pod::Spec.new do |s|

  s.name         = "LSKit"
  s.version      = "0.0.1"
  s.summary      = "a self use kit"
  s.description  = %{
    LSKit is a iOS Kit for self use.
  }
  s.homepage     = "https://github.com/SandroLiu/LSKit"
  s.license      = "MIT"
  s.author       = { "sandro" => "liushuai_ios@126.com" }
  s.platform     = :ios, '8.0'
  s.source       = { :git => "https://github.com/SandroLiu/LSKit.git", :tag => "#{s.version}" }
  s.source_files  = "LSKit/**/*.{h,m}"
  s.requires_arc = true
end
