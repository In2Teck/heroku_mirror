require 'active_record/fixtures'

Utensilio.delete_all
File.open("#{Rails.root}/db/utensilios.txt").readlines.each do |line|
  Utensilio.find_or_create_by_nombre(line.strip!)
end

Grupo.delete_all
File.open("#{Rails.root}/db/grupos.txt").readlines.each do |line|
  Grupo.find_or_create_by_nombre(line.strip!)
end
