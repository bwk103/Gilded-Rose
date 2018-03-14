class GildedRose

  MAX_QUALITY = 50
  MIN_QUALITY = 0

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      case item.name
      when "Sulfuras, Hand of Ragnaros"
        item
      when "Aged Brie"
        aged_brie(item)
      when "Backstage passes to a TAFKAL80ETC concert"
        backstage_passes(item)
      else
        original_item(item)
      end
    end
  end

  def original_item(item)
    item.quality -= 1
    item.sell_in -= 1
    item.quality -= 1 if item.sell_in < 0
    checkMinQuality(item)
  end

  def aged_brie(item)
    item.quality += 1
    item.sell_in -= 1
    checkMaxQuality(item)
  end

  def backstage_passes(item)
    item.quality += 1 if item.sell_in <= 5
    item.quality += 1 if item.sell_in <= 10
    item.quality += 1
    item.sell_in -= 1
    item.quality = 0 if item.sell_in <= 0
    checkMaxQuality(item)
  end

  def checkMaxQuality(item)
    item.quality = MAX_QUALITY if item.quality > MAX_QUALITY
  end

  def checkMinQuality(item)
    item.quality = MIN_QUALITY if item.quality < MIN_QUALITY
  end

end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
