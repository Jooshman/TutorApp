class Userlogin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  searchkick word_start: [:aboutMe, :email]
  def search_data 
    {
    email: email,
    aboutMe: aboutMe
  }
end
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :send_admin_mail
  

  ratyrate_rateable 'overall', 'clarity', 'knowledge', 'politeness', 'flexibility'
  ratyrate_rater
  
  acts_as_messageable

  def mailboxer_name
    self.first
  end

  def mailboxer_email(object)
    self.email
  end


  def send_admin_mail
    UserMailer.welcome_email(self).deliver
  end
end
