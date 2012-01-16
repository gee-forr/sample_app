require 'spec_helper'

describe User do
  before(:each) do
    @attr = {name: 'Example User', email: 'user@example.com'}
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
end
