COUNT = Transform /^once|twice$/ do |count|
  { 'once' => 1,
    'twice' => 2 
  }[count] || raise("I don't understand '#{count}")
end
