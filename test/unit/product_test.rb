require 'test_helper'

class ProductTest < ActiveSupport::TestCase

	fixtures :products

	test "Comprobacion de atributos no nulos" do
		product = Product.new
		assert product.invalid?
		assert product.errors[:title].any?
		assert product.errors[:description].any?
		assert product.errors[:image_url].any?
		assert product.errors[:price].any?
	end

	test "El precio debe ser positivo" do
		product = Product.new(:title => 'Producto para el test', 
			:description => 'Descripcion del producto para los tests',
			:image_url => 'zzz.jpg')

		product.price = -1
		assert product.invalid?
		assert_equal 'must be greater than or equal to 0.01',
			product.errors[:price].join('; ')

		product.price = 0
		assert product.invalid?
		assert_equal 'must be greater than or equal to 0.01',
			product.errors[:price].join('; ')

		product.price = 1
		assert product.valid?
	end

	def new_product(image_url)
		Product.new(:title => 'Titulo de test',
			:description => 'Description para el producto de test',
			:image_url => image_url,
			:price => 1)
	end

	test "Image url" do
		ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
		bad = %w{ fred.doc fred.gif/more fred.gif.more }
		
		ok.each do |name|
			assert new_product(name).valid?, "#{name} shouldn't be invalid"
		end

		bad.each do |name|
			assert new_product(name).invalid?, "#{name} shouldn't be valid"
		end

	end

	test "product is not valid whitout a unique title" do
		product = Product.new(
			:title => products(:ruby).title,
			:description => "yyy",
			:image_url => "zzz.jpg",
			:price => 1)
		assert !product.save
		assert_equal "has already been taken" , product.errors[:title].join('; ')
	end

end
