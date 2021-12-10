# lib/main.rb
require_relative "caesar_cipher.rb"
# driver script

print "Enter your message to encrypt: "
string = gets.chomp
print "Enter your shift-factor (must be a positive integer): "
shift_factor = gets.chomp.to_i
caesar_cipher(string, shift_factor)