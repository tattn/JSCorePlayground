
class String
  def removed_header
    lines = self.split("\n")
    lines.shift 6
    lines
  end
end

def test classname
  tmp  = open("tmp/JS#{classname}.swift",  &:read).removed_header
  test = open("data/JS#{classname}.swift", &:read).removed_header

  puts "#{classname}: #{tmp == test}"
end


`ruby ../make_bridge.rb ./tmp`

test 'UIColor'
