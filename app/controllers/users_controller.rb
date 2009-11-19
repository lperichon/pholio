class UsersController < ApplicationController
  before_filter :set_page
  before_filter :require_user, :except => [:new, :create]

  def index
   @users = current_account.users 
  end

  def new
    @user = User.new(:account => Account.new())
  end

  def create
    if current_user
      @user = current_account.users.new(params[:user])
    else
      @user = User.new(params[:user])
      @user.save(false)
      @user.managed_account = @user.account
      @user.account.pages.create(:name => 'Home', :permalink => 'index', :content => 'This is the home page')
    end

    if @user.save
      flash[:notice] = "Registration successful."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

  def set_page
    @page = Page.new(:name => 'Users', :permalink => 'users')
  end
end
