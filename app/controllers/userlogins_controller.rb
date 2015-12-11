# app/controllers/userlogins_controller.rb
class UserloginsController < ApplicationController
  def index
    @userlogins = Userlogin.all
   end

  def show
  		@userlogins = Userlogin.find(params[:id])
      super
  end

  def search
    if params[:search].present? #|| params[:price].present? || params[:male].present? || params[:female].present?
      if (params[:sort] == "price" && params[:sort].present?)
        @userlogins = Userlogin.search(params[:search], fields:[{email: :word_start}, {classes: :word_start}, {skills: :word_start}], order:[{price: :desc}])
      elsif (params[:sort] == "review" && params[:sort].present?)
        @userlogins = Userlogin.search(params[:search], fields:[{email: :word_start}, {classes: :word_start}, {skills: :word_start}], order:[{: :desc}])
      else
        @userlogins = Userlogin.search(params[:search], fields:[{email: :word_start}, {classes: :word_start}, {skills: :word_start}])
          #where: {
          #price: {lte: params[:price]},
          #or: [
            #[{gender: params["male"]}, {gender: params["female"]}]
          #]
        #})
      #@postPrice = []
      #if (params[:price].present?)
        #@buffer.each do |result|
          #if (result.price <= params[:price])
            #@postPrice << result
          #end
        #end

      #else
          #@postPrice = @buffer
      #end

      #@postGender = []
      #if (params[:male].present?)
        #@postPrice.each do |result|
          #if (result.gender == params[:male])
            #@postGender << result
          #end
        #end     
      #else
          #@postGender = @buffer
      #end

      #@userlogins = Userlogin.where("price <= ?", params[:price]) if params[:price].present?
      #@userlogins = @userlogins.where(gender: params[:male]) if params[:male].present?
      #@userlogins = @userlogins.where(gender: params[:female]) if params[:female].present?
      end
    else
  		@userlogins = Userlogin.all
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
end
