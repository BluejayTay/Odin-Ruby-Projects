def caesar_cipher(string, shift_factor)
  new_string = ""
  ascii_num = 0
  string.each_char do |char| 
    # A-Z = 65-90, a-z = 97-122
    if (char.ord).between?(65, 90) || (char.ord).between?(97, 122)
      ascii_num = (char.ord) + shift_factor
    # wrap Z-A & z-a
      if ascii_num.between?(91, 96) || ascii_num > 122
        ascii_num = ascii_num - 26
      end 
    # non-alphabet characters stay the same
    else
      ascii_num = char.ord
    end
    new_string += "#{ascii_num} "
  end 
  string_array = new_string.split
  cipher_numbers = string_array.map {|number| number.to_i}
  cipher_array = cipher_numbers.map {|int| int.chr}
  final_message = cipher_array.join
  puts final_message
end

print "Enter your message to encrypt: "
string = gets.chomp
print "Enter your shift-factor (must be a positive integer): "
shift_factor = gets.chomp.to_i
caesar_cipher(string, shift_factor)