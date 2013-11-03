require 'spec_helper'

describe PagesController do
  render_views
  
  before(:each) do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  describe "GET 'home'" do
    
    describe "when not signed in" do
      it "returns http success" do
        get 'home'
        response.should be_success
      end
      
      it "should have the rigth title" do
        get 'home'
        response.should have_selector("title", :content => "#{@base_title} | Home")
      end
      
      it "should have a non blank body" do
        get 'home'
        response.body.should_not =~ /<body>\s*<\/body>/
      end
    end
  
    describe "GET 'contact'" do
      it "returns http success" do
        get 'contact'
        response.should be_success
      end
      
      it "should have the rigth title" do
        get 'contact'
        response.should have_selector("title", :content => "#{@base_title} | Contact")
      end
    end
  end
   
  describe "when signed in" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
      other_user = Factory(:user, :email => "another@yahoo.com")
      other_user.follow!(@user)
    end
    
    it "should have the right follower/following counts" do
      get :home
      response.should have_selector("a", :href => following_user_path(@user), :content => "0 following")
      response.should have_selector("a", :href => followers_user_path(@user), :content => "1 follower") 
    end
  end 
  
  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
    
    it "should have the rigth title" do
      get 'about'
      response.should have_selector("title", :content => "#{@base_title} | About")
    end
  end

end
