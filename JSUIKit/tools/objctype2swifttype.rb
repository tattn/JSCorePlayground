
def objctype2swifttype classname, objctype
  suffix = ''

  # nullable
  if objctype =~ /nullable\s+([^)]+)/
    objctype = $1.strip
    suffix = '?'
  end

  swifttype =
    case objctype
    when 'instancetype'
      classname
    when 'id'
      # 'Any'
      classname
    when /id\s*\*/
      'UnsafePointer<UInt8>'
    when /struct (\w+).*/
      $1
    when /NSString\s*\*/
      'String'
    when /void\s*\*/
      'UnsafeMutableRawPointer'
    when /double\s*\*/
      suffix = '?'
      'UnsafeMutablePointer<CGFloat>'
    when /CGFloat\s*\*/
      suffix = '?'
      'UnsafeMutablePointer<CGFloat>'
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
    when 'BOOL'
      'Bool'
    when 'NSInteger'
      'Int'
    else
      objctype[0].upcase + objctype[1..objctype.length]
    end

  # remove *
  def remove_ster type
    if type =~ /\s*([^*]+)\*/
      $1.strip
    else
      type
    end
  end


  # NSArray<__kindof UIView *> *)views
  if swifttype =~ /NSArray\s*<(?:__\w+)?([^>]+)/
    swifttype = "[#{remove_ster $1.strip}]"
  end
  # NSSet<UITouch *> *)touches
  if swifttype =~ /NSSet\s*<(?:__\w+)?([^>]+)/
    swifttype = "Set<#{remove_ster $1.strip}>"
  end

  swifttype = remove_ster swifttype

  # remove NS prefix
  if swifttype =~ /^NS(.*)/
    ignores = ['Coder', 'LayoutConstraint', 'UserActivity', 'LayoutXAxisAnchor', 'LayoutYAxisAnchor', 'LayoutDimension']
    swifttype = $1 unless ignores.include? $1
  end

  # remove __kindof
  if swifttype =~ /__kindof\s+(.*)/
    swifttype = $1.strip
  end
  
  # remove Ref
  if swifttype =~ /(.*)Ref/
    swifttype = $1
  end

  swifttype + suffix
end

