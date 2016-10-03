
def objctype2swifttype classname, objctype
  case objctype
  when 'id'
    classname
  when 'id*'
    'UnsafePointer<UInt8>'
  when /.*struct (\w+).*/
    $1
  when 'double*'
    'UnsafeMutablePointer<CGFloat>?'
  when 'unsigned int'
    'UInt'
  when 'unsigned long long'
    'UInt64'
  when 'long long'
    'Int64'
  when 'Class'
    'AnyClass'
  else
    objctype.capitalize
  end
end

