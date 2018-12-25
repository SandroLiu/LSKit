Pod::Spec.new do |s|

  s.name         = "LSUtils"
  s.version      = "0.0.2"
  s.summary      = "a self use utils"
  s.description  = %{
    LSUtils is a iOS utils for self use.
  }
  s.homepage     = "https://github.com/SandroLiu/LSUtils"
  s.license      = "MIT"
  s.author       = { "sandro" => "liushuai_ios@126.com" }
  s.platform     = :ios, '8.0'
  s.source       = { :git => "https://github.com/SandroLiu/LSUtils.git", :tag => "#{s.version}" }
  s.source_files  = "SAKit/**/*.{h,m}"
  s.requires_arc = true
end
