
def objctype2swifttype classname, objctype
  case objctype
  when 'id'
    # 'Any'
    classname
  when 'id*'
    'UnsafePointer<UInt8>'
  when /struct (\w+).*/
    $1
  when 'void*'
    'UnsafeMutableRawPointer'
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
  when 'SEL'
    'Selector'
  else
    objctype[0].upcase + objctype[1..objctype.length]
  end
end

