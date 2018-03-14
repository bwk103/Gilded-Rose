class BackstagePasses
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end

  def update_item(store)
    @quality += 1 if @sell_in <= 5
    @quality += 1 if @sell_in <= 10
    @quality += 1
    @sell_in -= 1
    @quality = 0 if @sell_in <= 0
    store.checkMaxQuality(self)
  end
end
