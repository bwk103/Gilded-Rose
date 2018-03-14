require 'gilded_rose'

describe GildedRose do

  subject(:store) { described_class.new(items) }
  let(:sulfuras) { Item.new('Sulfuras, Hand of Ragnaros', 0, 80) }
  let(:brie) { Item.new('Aged Brie', 10, 10) }
  let(:passes) { Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 10) }
  let(:valuable_passes) { Item.new('Backstage passes to a TAFKAL80ETC concert', 3, 50) }
  let(:ordinary) { Item.new('Ordinary item', 5, 10) }
  let(:items) { [sulfuras, brie, passes, ordinary, valuable_passes] }

  before(:each) do
    store.update_quality
  end

  describe '#update_quality' do
    describe 'ordinary items' do
      it "quality cannot be negative" do
        20.times { store.update_quality }
        expect(ordinary.quality).to be 0
      end

      describe "before sell by date" do
        it "quality decreases by 1" do
          expect(ordinary.quality).to be 9
        end
        it "sellIn decreases by 1" do
          expect(ordinary.sell_in).to be 4
        end
      end

      describe "after sell by date" do
        before(:each) do
          5.times { store.update_quality }
        end

        it "quality decreases by 2" do
          expect(ordinary.quality).to be 3
        end

        it "sellIn decreases by 1" do
          expect(ordinary.sell_in).to be -1
        end
      end
    end

    describe 'Sulfuras, Hand of Ragnaros' do
      it 'quality does not decrease' do
        expect(sulfuras.quality).to eq 80
      end

      it 'sellIn does not decrease' do
        expect(sulfuras.sell_in).to eq 0
      end
    end

    describe 'Aged Brie' do
      it 'quality increases by 1' do
        expect(brie.quality).to eq 11
      end

      it 'quality cannot be more than 50' do
        45.times { store.update_quality }
        expect(brie.quality).to be 50
      end

      it 'sellIn decreases by 1' do
        expect(brie.sell_in).to eq 9
      end
    end

    describe 'Backstage passes to a TAFKAL80ETC concert' do
      it 'quality cannot be more than 50' do
        expect(valuable_passes.quality).to be 50
      end

      describe "when more than 10 days before the concert" do
        it "quality increases by 1" do
          expect(passes.quality).to be 11
        end
        it "sellIn decreases by 1" do
          expect(passes.sell_in).to be 14
        end
      end

      describe 'when more than 5 days before the concert' do
        before(:each) do
          5.times { store.update_quality }
        end
        it 'quality increases by 2' do
          expect(passes.quality).to eq 17
        end
        it "sellIn decreases by 1" do
          expect(passes.sell_in).to eq 9
        end
      end

      describe "when less than 5 days before the concert" do
        before(:each) do
          10.times { store.update_quality }
        end
        it "quality increases by 3" do
          expect(passes.quality).to eq 28
        end
        it "sellIn decreases by 1" do
          expect(passes.sell_in).to eq 4
        end
      end

      describe "after the concert" do
        before(:each) do
          15.times { store.update_quality }
        end
        it "quality becomes 0" do
          expect(passes.quality).to be 0
        end
        it "sellIn decreases by 1" do
          expect(passes.sell_in).to be -1
        end
      end
    end
  end
end
