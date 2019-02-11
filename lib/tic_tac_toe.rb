class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
    puts "Welcome to Tic Tac Toe!"
    display_board
  end
  WIN_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} \n-----------\n #{@board[3]} | #{@board[4]} | #{@board[5]} \n-----------\n #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    return input.to_i - 1
  end

  def move(input, player)
    @board[input] = player
    return @board
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    if (!position_taken?(index) && index.between?(0, 8))
      return true
    else
      return false
    end
  end

  # def turn_count
  #   counter = 0
  #   @board.each do |x|
  #     if x != " " && x != ""
  #       counter += 1
  #     end
  #   end
  #   return counter
  # end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def current_player
    player = turn_count % 2 == 0 ? "X" : "O"
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def won?
    is_won = false
    for win_combination in WIN_COMBINATIONS
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = @board[win_index_1]
      position_2 = @board[win_index_2]
      position_3 = @board[win_index_3]
      if position_1 == position_2 && position_2 == position_3 && position_taken?(win_index_1)
        return win_combination
      else
        false
      end
    end
    is_won
  end

  def full?
    is_full = true
    for i in 0..8
      if !position_taken?(i)
        is_full = false
      end
    end
    return is_full
  end

  def draw?
    if full? && !won?
      return true
    else
      false
    end
  end

  def over?
    if draw?
      return true
    elsif won?
      return true
    else
      return false
    end
  end

  def winner
    if won?
      return @board[won?[0]]
    else
      return nil
    end
  end

  def play
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    else
      until over?
        turn
        if won?
          puts "Congratulations #{winner}!"
        elsif draw?
          puts "Cat's Game!"
        end
      end
    end
  end


end
