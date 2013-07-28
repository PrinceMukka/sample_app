class User
  attr_accessor :name1, :email
  def initialize(attributes ={})
    @name1 = attributes[:name]
    @email = attributes[:email]
  end 
  def formatted_email
    "#{@name1} <#{email}>"
  end
end