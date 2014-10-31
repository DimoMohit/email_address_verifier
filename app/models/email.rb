class Email < ActiveRecord::Base
	belongs_to :active_account
	validates :subject, presence: true
	validates :message, presence: true
end
