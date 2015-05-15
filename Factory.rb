# FactoryRG
class Factory
	def self.new(*fields, &block)
		raise ArgumentError, "wrong number of arguments (0 for 1+)" if fields.length < 1

		Class.new do
			self.class_eval(&block) if block_given?
			define_method :initialize do |*values|
				fields.each_index do |i|
					instance_variable_set("@#{fields[i]}", values[i])
				end
			end

			fields.each_index do |i|
				define_method fields[i] do
					instance_variable_get("@#{fields[i]}")
				end
			define_method "#{fields[i]}=" do |new_value|
				instance_variable_set("@#{fields[i]}", new_value)
				end
			end

			define_method :[] do |arg|
				if arg.instance_of? Fixnum
					instance_variable_get(instance_variables[arg])
				else
					instance_variable_get("@#{arg}")
				end
			end
		end
	end
end


Customer = Factory.new(:name, :address, :zip)
p Customer
 
joe = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)

p joe.name
p joe["name"]
p joe[:name]
p joe[0]
