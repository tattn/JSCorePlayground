
def parse_header source
  source = remove_comment_out source
  source = remove_protocol source

  class_name        = get_class_name source
  parent_class_name = get_parent_class_name source

  methods    = get_methods source
  properties = get_properties source
  properties[:properties].concat(
    convert_to_getter_setter(methods[:instance_methods])[:properties]
  ).uniq! {|f| f[:name] }
  properties[:properties].concat(
    convert_to_getter_setter(methods[:static_methods], static: true)[:properties]
  ).uniq! {|f| f[:name] }

  data = {class_name: class_name, parent_class_name: parent_class_name}
  data.merge! methods
  data.merge! properties
end


def remove_comment_out source
  source = source.gsub /\/\*\/?(\n|[^\/]|[^\*]\/)*\*\//, ''
  source.gsub /\s*\/\/.*$/, ''
end

def remove_protocol source
  source.gsub /@protocol.*?@end/m, ''
end

def get_class_name source
  $1 if source =~ /@interface\s+(\w+)/
end

def get_parent_class_name source
  $1 if source =~ /@interface\s+.*?:\s*(\w+)\s*<?/
end

def get_methods source
  classname = get_class_name source
  def parse_method methods, classname

    methods.map do |method|
      result = { original: method }

      # メソッド名
      if method =~ /\)\s*(\w+)\s*.*[;:]/
        result[:name] = $1.strip
      else
        p method
        throw "Parse Error"
      end

      # 戻り値
      if method =~ /\(([^)]+)\)/
        result[:return_type] = $1.strip
      else
        p method
        throw "Parse Error"
      end

      # 引数
      if method =~ /:(.+);/
        args = $1
        args = args.scan /(?:\w+:)?\([^)]+\)\w+/

        result[:args] = args.map do |arg|
          if arg =~ /(\w+:)?\(([^)]+)\)(\w+)/
            {type: objctype2swifttype(classname, $2.strip), name: $3.strip, label: $1 != nil}
          else
            p method
            p result[:args]
            p args
            throw "Parse Error"
          end
        end
      end
      result
    end
    .uniq {|f| f[:name] }
    .select {|f| f[:name] != 'init'}
  end

  static_method_list   = source.scan /^\+.+;$/
  instance_method_list = source.scan /^\-.+;$/

  static_methods   = parse_method static_method_list, classname
  instance_methods = parse_method instance_method_list, classname

  {static_methods: static_methods, instance_methods: instance_methods}
end

def get_properties source
  property_list = source.scan /^@property.+;$/
  properties = property_list.map do |property|
    # @property(nullable, nonatomic,readonly) UIView       *superview;
    result = {}

    # プロパティ名
    if property =~ /@property\s*\([^)]+\)\s*(?:__kindof)?\s*\w+(?:<[^>]+>)?\s*\*?\s*(\w+)\s*/
      result[:name] = $1.strip
    end

    # 型
    if property =~ /@property\s*\([^)]+\)\s*(?:__kindof)?\s*(\w+(?:<[^>]+>)?\s*\*?)\s*\w+\s*/
      result[:type] = $1.strip
    end

    # 属性
    if property =~ /@property\s*\(([^)]+)\)\s*(?:__kindof)?\s*\w+(?:<[^>]+>)?\s*\*?\s*\w+\s*/
      attributes = $1.strip.split(',').map {|attr| attr.strip }
      result[:set]      = !attributes.include?('readonly')
      result[:nullable] = attributes.include? 'nullable'
      result[:static]   = attributes.include? 'class'
    else
      result[:set]      = true
      result[:nullable] = false
    end

    result[:get] = true
    result
  end
  {properties: properties}
end

def convert_to_getter_setter methods, static=false
  properties = []
  methods.each do |method|
    name    = method[:name]
    args    = method[:args]
    rettype = method[:return_type]

    if name[0..2] == 'set'
      next if !args or args.length != 1
      
      name = name[3].downcase + name[4..name.length]

      property = properties.select{|p| p[:name] == name}[0]

      unless property
        property = {}

        property[:name] = name
        property[:get]  = true
        property[:type] = args[0][:type]

        properties.push property
      end

      property[:set]    = true
      property[:static] = static

      method[:delete] = true

    elsif !args and rettype != 'void'
      property = properties.select{|p| p[:name] == name}[0]

      unless property
        property = {} 

        property[:name] = name
        property[:get]  = true
        property[:type] = rettype

        properties.push property
      end

      property[:static] = static

      method[:delete] = true
    end
  end

  methods.delete_if {|m| m[:delete]}

  {properties: properties}
end
