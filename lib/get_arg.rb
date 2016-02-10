def get_arg
  ARGV.each { |a| task a.to_sym do ; end }
  ARGV[1]
end
