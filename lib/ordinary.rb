require 'gilded_rose'

class Ordinary < Item
  def update_item(store)
    @quality -= 1
    @sell_in -= 1
    @quality -= 1 if @sell_in < 0
    store.checkMinQuality(self)
  end
end
