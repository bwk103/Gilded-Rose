require_relative 'aged_brie'
require_relative 'backstage_passes'
require_relative 'aged_brie'
require_relative 'sulfuras'
require_relative 'ordinary'

class GildedRose

  MAX_QUALITY = 50
  MIN_QUALITY = 0

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      item.update_item(self)
    end
  end

  def checkMaxQuality(item)
    item.quality = MAX_QUALITY if item.quality > MAX_QUALITY
  end

  def checkMinQuality(item)
    item.quality = MIN_QUALITY if item.quality < MIN_QUALITY
  end

end

# class Item
#   attr_accessor :name, :sell_in, :quality
#
#   def initialize(name, sell_in, quality)
#     @name = name
#     @sell_in = sell_in
#     @quality = quality
#   end
#
#   def to_s()
#     "#{@name}, #{@sell_in}, #{@quality}"
#   end
# end
