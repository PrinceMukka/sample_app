require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do 
      get 'new'
      response.should have_selector("title", :content => "Sign up")
    end
  end
  describe "Get show" do 
    before(:each) do 
      @user = Factory(:user)
    end
    it "should be successful" do 
      get :show , :id => @user
      response.should be_success 
    end
    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
    it "should have right title" do
      get :show , :id =>@user
      response.should have_selector("title", :content => @user.name)
    end
    it "should include the user name" do 
      get :show , :id => @user
      response.should have_selector("h1", :content =>@user.name)
    end
    it "should have a profile image" do
      get :show, :id => @user
      response.should have_selector "h1>img", :class => "gravatar"
    end
  end
  describe "Post Create" do 
    describe "failure" do 
    before(:each) do 
      @attr = {:name => "" , :email => "", :password => "", :password_confirmation => ""}
    end 
    it "should not create user" do 
      lambda do 
        post :create, :user => @attr
      end.should_not change(User, :count)
    end
    it "should have the right title" do
      post :create, :user => @attr
      response.should have_selector("title", :content => "Sign up")
    end
    it "should render the 'new' page" do 
      post :create, :user => @attr 
      response.should render_template('new')
    end
  end
  describe "success" do 
    before(:each) do 
      @attr = {:name => "Test name", :email =>"test@email.com", :password => "test123", :password_confirmation => "test123"}
    end
    it "should create a new user" do 
      lambda do
        post :create , :user => @attr
      end.should change(User, :count).by(1)
    end
    it "should redirect to the user show page" do 
      post :create, :user => @attr
      response.should redirect_to(user_path(assigns(:user)))
    end
    it "should show flash message" do 
      post :create , :user => @attr
      flash[:success].should =~ /welcome/i
    end
  end 
  
  end
end
