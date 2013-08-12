require 'spec_helper'

describe SessionsController do

  it "should be succesfull" do 
    get :new
    response.should be_success
  end
  it "should have the right title" do 
    get :new
    response.should have_selector("title", :content =>"Ruby on Rails Tutorials Sample App | Sign in")
  end
  
  describe "render post create" do 
    
    describe "invalid signin" do 
      
      before(:each) do
        @attr = {:email => "email@example.com", :password => "invalid"} 
      end
      
      it "should rerender the new page" do
        post :create, :session => @attr
        response.should render_template('new') 
      end
      
      it "should have the right title" do 
        post :create, session => @attr
        response.should have_selector("title", :content =>"Ruby on Rails Tutorials Sample App | Sign in")
      end
      
      it"should have flash.now mesage" do 
        post :create, :session => @attr
        flash.now[:error].should =~ /invalid/i
      end
    end  
   
    describe "valid sing in" do 
      
      before(:each) do 
        @user = Factory(:user)
        @attr = {:email => @user.email , :password => @user.password}
      end
      
      it "should sign the user in " do 
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.signed_in? should be_true
      end
      
      it "should reirect to show page" do 
        post :create, :session => @attr
        response.should redirect_to(user_path(@user))
      end 
    end

    describe "Delete session" do 
      it "should sign a user out" do 
        test_sign_in(Factory(:user))
        delete :destroy
        controller.should_not be_signed_in 
        response.should redirect_to(root_path)
      end
    end
  end
end
