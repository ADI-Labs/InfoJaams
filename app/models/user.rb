class User < ActiveRecord::Base
	validates :name, presence: true, length: {maximum: 50}
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	# made on Rubular
	validates :email, presence: true, length: {maximum: 250}
	# checks that the input for name and email is not empty
		format: { with: VALID_EMAIL_REGEX },
        uniqueness: {case_sensitive: false}
        # checks that email follows the regular format and also that

end
