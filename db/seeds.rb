a1 = Admin.where(email: "clairezuliani@gmail.com").first_or_initialize
if ["production","staging"].include?(Rails.env)
  a1.update_attributes(:password => "aqwxsz21")
else
  a1.update_attributes(:password => "password")
end
