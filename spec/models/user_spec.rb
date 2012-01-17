require 'spec_helper'

describe User do
  before(:each) do
    @attr = {
      name:                   'Example User',
      email:                  'user@example.com',
      password:               'foobar',
      password_confirmation:  'foobar'
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    @attr[:name] = ''
    no_name_user = User.new(@attr)

    no_name_user.should_not be_valid
  end

  it "should require an email address" do
    @attr[:email] = ''
    no_email_user = User.new(@attr)

    no_email_user.should_not be_valid
  end

  it "should reject names that are too long" do
    @attr[:name]   = 'a' * 51
    long_name_user = User.new(@attr)

    long_name_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]

      addresses.each do |address|
        invalid_email_user = User.new(@attr.merge(email: address))
        invalid_email_user.should_not be_valid
      end
  end

  it "should reject duplicate email addresses" do
    User.create!(@attr)

    user_with_duplicate_address = User.new(@attr)
    user_with_duplicate_address.should_not be_valid
  end

  it "should reject duplicate email addresses regardless of case" do
    User.create!(@attr)

    @attr[:email].upcase!
    user_with_duplicate_address = User.new(@attr)
    user_with_duplicate_address.should_not be_valid
  end

  describe "password validations" do
    it "should require a password" do
      @attr[:password]              = ''
      @attr[:password_confirmation] = ''

      User.new(@attr).should_not be_valid
    end

    it "should require a matching password confirmation" do
      @attr[:password_confirmation] = 'barfoo'

      User.new(@attr).should_not be_valid
    end

    it "should reject short passwords" do
      @attr[:password]              = 'a' * 5
      @attr[:password_confirmation] = @attr[:password]

      User.new(@attr).should_not be_valid
    end

    it "should reject too long passwords" do
      @attr[:password]              = 'a' * 41
      @attr[:password_confirmation] = @attr[:password]

      User.new(@attr).should_not be_valid
    end
  end

  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do
      it "should be true if passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end

      it "should be false if passwords don't match" do
        @user.has_password?('invalid').should be_false
      end
    end

    describe "authenticate method" do
      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], 'wrongpass')
        wrong_password_user.should be_nil
      end

      it "should return nil for an email address with no user" do
        nonexistant_user = User.authenticate('boo@far.com', @attr[:password])
        nonexistant_user.should be_nil
      end

      it "should return the user on email/password match" do
        authenticated_user = User.authenticate(@attr[:email], @attr[:password])
        authenticated_user.should == @user
      end
    end
  end
end
