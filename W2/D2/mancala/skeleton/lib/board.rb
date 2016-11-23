class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = Array.new(14) {Array.new}
    @name1 = name1
    @name2 = name2
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index do |cup, idx|
      next if idx == 6 || idx == 13
      4.times do
        cup << :stone
      end
    end
  end

  def valid_move?(start_pos)
    if start_pos > 13 || start_pos < 1 || start_pos == 13 || start_pos == 6
      raise "Invalid starting cup"
    end
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos].dup
    @cups[start_pos] = []
    index = start_pos
    until stones.empty?
      index += 1
      index = 0 if index> 13
      if index == 6
        @cups[6] << stones.pop if current_player_name == @name1
      elsif index == 13
        @cups[13] << stones.pop if current_player_name == @name2
      else
        @cups[index] << stones.pop
      end
    end
    render
    next_turn(index)
  end

  def next_turn(ending_cup_idx)
    if ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    elsif @cups[ending_cup_idx].count == 1
      :switch
    else
    ending_cup_idx
    end
  end


  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups.take(6).all? { |cup| cup.empty? } ||
    @cups[7..12].all? { |cup| cup.empty? }
  end


  def winner
    p1_score = @cups[6].count
    p2_score = @cups[13].count
    if p1_score == p2_score
      :draw
    elsif   p1_score > p2_score
      @name1
    else
      @name2
    end
  end
end
