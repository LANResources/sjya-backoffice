require 'spec_helper'

describe User do
  before { @user = build(:user) }

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:title) }
  it { should respond_to(:phone) }
  it { should respond_to(:address) }
  it { should respond_to(:city) }
  it { should respond_to(:state) }
  it { should respond_to(:zipcode) }
  it { should respond_to(:avatar) }
  it { should respond_to(:status) }
  it { should respond_to(:role) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:contact?) }
  it { should respond_to(:invited_user?) }
  it { should respond_to(:registered_user?) }
  it { should respond_to(:organization_manager?) }
  it { should respond_to(:site_manager?) }
  it { should respond_to(:administrator?) }

  it { should be_valid }

  describe "when first name is not present" do
    before { @user.first_name = " " }
    it { should_not be_valid }
  end

  describe "when last name is not present" do
    before { @user.last_name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "status" do
    it "should default to 'contact_only'" do
      expect(@user.status).to eq('contact_only')
    end

    it "should accept valid statuses" do
      @user = build(:registered_user)
      User::STATUSES.each do |valid_status|
        @user.status = valid_status
        expect(@user).to be_valid
      end
    end

    it "should reject invalid statuses" do
      @user.status = "invalid"
      expect(@user).not_to be_valid
    end
  end

  describe "role" do
    it "should set proper defaults based on status" do
      {contact: 'contact', invited_user: 'invited_user', registered_user: 'registered_user' }.each do |type, role|
        user = create(type.to_sym)
        expect(user.role).to eq(role)
      end
    end

    it "should accept valid roles" do
      @user = build(:registered_user)
      User::ROLES.each do |valid_role|
        @user.role = valid_role
        expect(@user).to be_valid
      end
    end

    it "should reject invalid roles" do
      @user.role = "invalid"
      expect(@user).not_to be_valid
    end
  end

  describe "when password is not present" do
    before do
      @user = build(:registered_user, password: " ", password_confirmation: " ")
    end

    it "should be valid when user status is contact_only" do
      @user.status = 'contact_only'
      should be_valid
    end

    it "should be valid when user status is invited" do
      @user.status = 'invited'
      should be_valid
    end

    it "should not be valid when user status is registered" do
      @user.status = 'registered'
      should_not be_valid
    end
  end

  describe "when password doesn't match confirmation" do
    before { @user = build(:registered_user, password_confirmation: "mismatch") }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before do
      @user.status = 'registered'
      @user.password = @user.password_confirmation = "a" * 5
    end
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user = create(:registered_user) }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end

    describe "for non-registered users" do
      before { @user.update_attribute(:status, 'contact_only') }
      let(:contact) { found_user.authenticate @user.password }
      it { should_not eq contact }
      specify { expect(contact).to be_false }
    end
  end
end
