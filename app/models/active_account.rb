class ActiveAccount < ActiveRecord::Base
	has_many :emails
	belongs_to :account_file
	validates :email, presence: true,uniqueness: true
end
