class PagesController < ApplicationController
  def Search
  end

  def Messaging
  end

  def Favorites
  end

  def Error
  end

  def Profile_Setup
  end

  def User_Profile
      @userlogins = Userlogin.find(params[:id])
  end
end
