# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
	def index
    	@userlogin = Userlogin.all
  	end

  	def search
  		if params[:search].present?
  	 		@userlogin = Userlogin.search(params[:search])
  		else
  			@userlogin = Userlogin.all
  		end
  	end

	def new
		super
	end

	def create
		super
	end

	def update
		super
	end

	def after_update_path_for(resource)
	  if resource.isTutor? 
  		"/pages/User_Profile/" + resource.id.to_s
  	else
  		"/pages/Home"
  	end
  end

  def after_sign_up_path_for(resource)
    '/pages/tutorial'
  end
end
