require 'gilded_rose'

class BackstagePasses < Item
  def update_item(store)
    @quality += 1 if @sell_in <= 5
    @quality += 1 if @sell_in <= 10
    @quality += 1
    @sell_in -= 1
    @quality = 0 if @sell_in <= 0
    store.checkMaxQuality(self)
  end
end
