require 'gilded_rose'

class Conjured < Item

  def update_item(store)
    @sell_in -= 1
    @quality -= 2
    @quality -= 2 if @sell_in < 0
  end
end
