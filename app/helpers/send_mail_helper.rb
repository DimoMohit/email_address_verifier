module SendMailHelper
	def signed_in?
        !current_user.nil?
    end
    def authenticate_user
        unless signed_in?   
            redirect_to "/auth/facebook"
        end
    end
end
