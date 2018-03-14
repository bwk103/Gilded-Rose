require 'gilded_rose'

class AgedBrie < Item
  def update_item(store)
    @quality += 1
    @sell_in -= 1
    store.checkMaxQuality(self)
  end
end
