class SendMailController < ApplicationController
	include SendMailHelper
	before_filter :authenticate_user!
	def index
	   if current_user#.admin
	   	#@emails = Email.all
	   	@email_files = AccountFile.all
	   	@active_accounts = ActiveAccount.all.limit(11)
	   	#@report = "Generating Report..."
	   end
	end
	def reportcart
	   if current_user#.admin
	   	@reportcard = files
	   end
	   render :json => @reportcard
	end
	def files
		@line=""
		File.open("/var/log/mail.log", "r").each do |line|
          @line =line[0,line.length-1]+"</br>"+@line+"</br>"  #line.index('stat').to_i
      end
      File.open('/var/log/mail.log', 'w') {|file| file.truncate(0) }
      return @line	
    end
    def broadcast
		#setup_email
		
		@mail_id=params[:id]
		@mail=Email.find(@mail_id.to_i)
		@users=ActiveAccount.where(:email_status=>true)
		@users.each do|user|
			#Thread.new{
				Broadcaster.welcome_email(user,@mail).deliver		
			#}
			#end
		end
		render :json => @user
	end
	def edit
		if params[:id]
			users=AccountFile.find(params[:id]).active_accounts.where(:email_status=>false).all
			users.each do|user|
		      begin
			    if EmailVerifier.check(user.email.to_s)!=true
			    	ActiveAccount.destroy(user.id)
			    	PrivatePub.publish_to("/messages/new", "$('.up-file_report').html('<div>#{user.email.to_s}</div><div>Not Valid so deleted</div>')")
			    else
			    	ActiveAccount.find(user.id).update_attributes(:email_status=>true)
			    	PrivatePub.publish_to("/messages/new", "$('.up-file_report').html('<div>#{user.email.to_s}</div><div>Is Valid Status Changed</div>')")
			    end
			  rescue
		        next
		      end
			end
		end
		render :json => params[:id]
		#Email.find(params[:id]).update_attributes(:subject => params[:subject],
		#	:message => params[:message],:broadcasted => false)
	end
	def update_active_accounts
		if params[:id]
			@to=params[:to]
			@from=params[:from]
			@ecount=1
			#Thread.new do
			@pwd=Dir.pwd+"/public"+AccountFile.find(params[:id]).email_file.url
			#@data="<table class='table table-bordered table-striped'>"
			#xls = Creek::Book.new(@pwd)
			workbook = RubyXL::Parser.parse(@pwd)
			wb =workbook.worksheets[0].extract_data
			((@to.to_i)..(@from.to_i)).each do |i|
                    @ecount=@ecount+1
		         	begin
		    #     		if EmailVerifier.check(wb[i][1].to_s)==true
		         			ActiveAccount.create(:name=>wb[i][0].to_s,
		         				:gender=>wb[i][2].to_s,
		         				:age=>wb[i][3].to_s,
		         				:email=>wb[i][1].to_s,
		        				:phone=>wb[i][4].to_s,
		         				:salary=>wb[i][5].to_s,
		         				:location=>wb[i][6].to_s,
		         				:account_file_id=>params[:id],
		         				:email_status=>false
		         				)
		         		PrivatePub.publish_to("/messages/new", "$('.up-file_report').html('<div>#{wb[i][1].to_s}</div><div>#{i}</div>')")
		    #     		end
		         	rescue
		         		next
		         	end
		    end
		end
		if AccountFile.find(params[:id]).read_line
			AccountFile.find(params[:id]).read_line.update_attributes(:lines_read=>@ecount)
		else
			ReadLine.create(:account_file_id=>params[:id],:lines_read=>@ecount)
		end
		PrivatePub.publish_to("/messages/new", "$('.up-file_report').html('#{@from}')")
	end
	
	protected
	def setup_email
		@recipients = "mohit@fundsinn.com"
		@from = "support@xxxxx.com"
          #headers "Reply-to" => "support@xxxxx.com"
          @sent_on      = Time.now
          @content_type = "text/html"
      end
  end
