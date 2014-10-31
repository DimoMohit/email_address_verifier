class AccountFile < ActiveRecord::Base
	mount_uploader :email_file, EmailUploader
	has_many :active_accounts
	has_one :read_line
	validates :name, presence: true
	validates :email_file, presence: true
end
