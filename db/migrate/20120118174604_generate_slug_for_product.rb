class GenerateSlugForProduct < ActiveRecord::Migration
  def change
    Product.find_each(&:save)
  end
end
