#spec/caesar_cipher.rb
require "./lib/caesar_cipher.rb"

describe "caesar_cipher" do
  it "shifts message characters by given factor" do
    expect(caesar_cipher("abc", 5)).to eql("fgh")
  end
  it "shifts message characters by given factor" do
    expect(caesar_cipher("abc", 20 )).to eql("uvw")
  end
end

describe "caesar_cipher" do
  it "works with both lowercase and uppercase letters" do
    expect(caesar_cipher("Whatastring", 5)).to eql("Bmfyfxywnsl")
  end
end

describe "caesar_cipher" do
  it "works with spaces in string" do
    expect(caesar_cipher("What a string", 5)).to eql("Bmfy f xywnsl")
  end
end
describe "caesar_cipher" do
  it "returns same message if shift factor is 0" do
    expect(caesar_cipher("What a string", 0)).to eql("What a string")
  end
end

describe "caesar_cipher" do
  it "returns emtpy string if given empty string" do
    expect(caesar_cipher("", 4)).to eql("")
  end
end

describe "caesar_cipher" do
  it "keeps any puncutation intact" do
    expect(caesar_cipher("!.,:;'?", 5)).to eql("!.,:;'?")
  end
end

describe "caesar_cipher" do
  it "keeps numbers intact" do
    expect(caesar_cipher("123", 10)).to eql("123")
  end
end

describe "caesar_cipher" do
  it "wraps Z-A & z-a" do
    expect(caesar_cipher("Zebra", 5)).to eql("Ejgwf")
  end
end
