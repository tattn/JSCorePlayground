require 'date'
require_relative './objctype2swifttype'
require_relative './parse_header'
require_relative './gen_swift_protocol'

header     = ARGV[0]
output_dir = ARGV[1]


# header = 'UIView.h' # Debug

def objc_header_to_swift_data header
  path_root = "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/System/Library/Frameworks/UIKit.framework/Headers/"

  path = path_root + header
  return nil unless File.exist? path

  source = open(path, &:read)

  data  = parse_header source
end

data         = objc_header_to_swift_data header
class_name   = data[:class_name]
parent_class = data[:parent_class_name]

while parent_class
  parent_data  = objc_header_to_swift_data parent_class + '.h'
  break unless parent_data

  parent_class = parent_data[:parent_class_name]
  
  data[:static_methods].concat(parent_data[:static_methods]).uniq! {|f| f[:name]}
  data[:instance_methods].concat(parent_data[:instance_methods]).uniq! {|f| f[:name]}
  data[:properties].concat(parent_data[:properties]).uniq! {|f| f[:name]}
end

swift = generate_swift_protocol data

if output_dir
  filename = "JS#{class_name}.swift"
  open(File.join(output_dir, filename), "w") {|f| f.write swift}
else
  puts swift
end

