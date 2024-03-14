require "test_helper"

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  def new_product(image_url)
    Product.new(title: "My book Title",
                description: "yyy",
                price: 1,
                image_url: image_url)
  end

  test "product attributes should not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    #assert product.errors[:image_url].any?
  end


  test "product price must be positive" do
    product = Product.new(title: "Book about Ruby",
                          description: "This is useful book about ruby lang",
                          image_url: "red_rubin.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal(["Price can not be less then 0.49$"], product.errors[:price])

    product.price = 0
    assert product.invalid?
    assert_equal(["Price can not be less then 0.49$"], product.errors[:price])

    product.price = 1
    assert product.valid?
  end

  test "image_url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.jpg
            http://a,b,c/x/y/z/fred.gif }

    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |image_url|
      assert new_product(image_url).valid?, "#{image_url} must be valid"
    end

    bad.each do |image_url|
      assert new_product(image_url).invalid?, "#{image_url} must be invalid"
    end
  end


  test "Product is not valid without a unique title" do
    product = Product.new( title: products(:ruby).title,
                           description: "yyy",
                           price: 11,
                           image_url: "fred.gif")
    assert product.invalid?
    assert_equal(["has already been taken"], product.errors[:title])
  end

end
