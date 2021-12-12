class LanternFish
  @@lantern_fishes = []
  attr_reader :internal_timer

  def initialize(internal_timer = 8)
    @internal_timer = internal_timer
    @@lantern_fishes << self
  end

  def next_day
    if @internal_timer.zero?
      LanternFish.new
      @internal_timer = 6
    else
      @internal_timer -= 1
    end
  end

  def self.local_group
    @@lantern_fishes
  end

  # We need to duplicate the original array, otherwise when next day method creates new fish it is being handled by this method too
  def self.next_day
    @@lantern_fishes.dup.each { |fish| fish.next_day }
  end

  def self.create_multiple_fishes(ary)
    ary.each { |timer| self.new(timer) }
  end
end

def part_one
  inputs = File.open('day_6_inputs.txt', 'r').readline.split(",").map(&:to_i)
  LanternFish.create_multiple_fishes(inputs)
  80.times { LanternFish.next_day }
  LanternFish.local_group.length
end

p part_one