require 'colorize'
@left = './left'
@right = './right'

def populate_deck(deck, card_hash, deck_side)
  File.readlines(deck).each do |line|
    num, card_name = line.split(' ', 2)
    if card_hash[card_name]
      card_hash[card_name][:owner] = 'B'
      card_hash[card_name][deck_side] = num
    else
      card_hash[card_name] = {}
      card_hash[card_name][:owner] = deck_side
      card_hash[card_name][deck_side] = num
    end
  end
end

def opposite_side(deck_side)
  'L' == deck_side ? 'R' : 'L'
end

def print_hash(card_hash, deck_side)
  card_hash.sort.each do |card_name, card_data|
    card_name = card_name.strip
    owner = card_data[:owner]
    if owner == 'B'
      opp = card_data[opposite_side(deck_side)]
      num_diff = card_data[deck_side].to_i - opp .to_i
      if num_diff == 0
        puts " #{card_data[deck_side]} #{card_name}"
      elsif num_diff > 0
        puts "-#{num_diff.abs} #{card_name} (#{opp})".colorize(:red)
      else
        puts "+#{num_diff.abs} #{card_name} (#{opp})".colorize(:green)
      end
    else
      if owner == deck_side
        puts "-#{card_data[deck_side]} #{card_name}".colorize(:red)
      else
        puts "+#{card_data[opposite_side(deck_side)]} #{card_name}".colorize(:green)
      end
    end
  end
end

card_hash = {}
populate_deck(@left, card_hash, 'L')
populate_deck(@right, card_hash, 'R')

print_hash(card_hash,'L')
