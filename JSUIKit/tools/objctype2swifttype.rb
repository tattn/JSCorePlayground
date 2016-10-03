
def objctype2swifttype classname, objctype
  case objctype
  when 'id'
    classname
  when 'id*'
    'UnsafePointer<UInt8>'
  when /.*struct (\w+).*/
    $1
  when 'unsigned int'
    'UInt'
  else
    objctype.capitalize
  end
end

