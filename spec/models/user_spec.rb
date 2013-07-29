require 'spec_helper'

describe User do

  it "should create a new instance given a valid attribute" do
    expect{
      Fabricate(:user)
    }.to change{User.count}.by(1)
  end

  it "should require an email address" do
    no_email_user = Fabricate.build(:user, :email => "")
    no_email_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = Fabricate(:user, :email => address)
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = Fabricate.build(:user, :email => address)
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    Fabricate(:user)
    user_with_duplicate_email = Fabricate.build(:user)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = 'example@example.com'.upcase
    Fabricate(:user, email: upcased_email)
    user_with_duplicate_email = Fabricate.build(:user)
    user_with_duplicate_email.should_not be_valid
  end

  describe "passwords" do

    let(:user){Fabricate(:user)}

    it "should have a password attribute" do
      user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      user.should respond_to(:password_confirmation)
    end
  end

  describe "password validations" do

    it "should require a password" do
      Fabricate.build(:user, :password => "", :password_confirmation => "").
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      Fabricate.build(:user, :password_confirmation => "invalid").
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      Fabricate.build(:user, :password => short, :password_confirmation => short).should_not be_valid
    end

  end

  describe "password encryption" do

    let(:user){Fabricate(:user)}

    it "should have an encrypted password attribute" do
      user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      user.encrypted_password.should_not be_blank
    end

  end

end
