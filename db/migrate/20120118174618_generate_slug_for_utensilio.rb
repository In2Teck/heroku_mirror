class GenerateSlugForUtensilio < ActiveRecord::Migration
  def change
    Utensilio.find_each(&:save)
  end
end
