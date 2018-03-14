class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name == "Sulfuras, Hand of Ragnaros"
      elsif item.name == "Aged Brie"
        aged_brie(item)
      elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
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
    item.quality = 0 if item.quality < 0
  end

  def aged_brie(item)
    item.quality += 1
    item.sell_in -= 1
    item.quality = 50 if item.quality > 50
  end

  def backstage_passes(item)
    item.quality += 1 if item.sell_in <= 5
    item.quality += 1 if item.sell_in <= 10
    item.quality += 1
    item.sell_in -= 1
    item.quality = 50 if item.quality > 50
    item.quality = 0 if item.sell_in <= 0
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
