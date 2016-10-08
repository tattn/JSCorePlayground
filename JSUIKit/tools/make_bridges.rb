
output = ARGV[0]

headers = [
  'UIView.h',
  'UIColor.h',
  'UIResponder.h',
]

tool = File.expand_path('../make_bridge.rb', __FILE__)

headers.each do |header|
  if output
    `ruby #{tool} #{header} #{output}`
  else
    `ruby #{tool} #{header}`
  end
end

