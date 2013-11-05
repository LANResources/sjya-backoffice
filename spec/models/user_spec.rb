require 'spec_helper'

describe User do
  let(:user) { build(:user) }

  subject { user }

  it 'is valid with valid attributes' do
    user.should be_valid
  end

  describe '#first_name' do
    it { should respond_to(:first_name) }

    it 'is required' do
      user.first_name = nil
      user.should_not be_valid
    end
  end

  describe '#last_name' do
    it { should respond_to(:last_name) }

    it 'is required' do
      user.last_name = nil
      user.should_not be_valid
    end
  end

  describe '#email' do
    it { should respond_to(:email) }

    it 'is required' do
      user.email = nil
      user.should_not be_valid
    end

    describe "when format is invalid" do
      it "should be invalid" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                       foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address|
          user.email = invalid_address
          expect(user).not_to be_valid
        end
      end
    end

    describe "when format is valid" do
      it "should be valid" do
        addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
        addresses.each do |valid_address|
          user.email = valid_address
          expect(user).to be_valid
        end
      end
    end

    it 'should be unique' do
      user_with_same_email = user.dup
      user_with_same_email.save
      user.should_not be_valid
    end
  end

  describe '#title' do
    it { should respond_to(:title) }
  end

  describe '#phone' do
    it { should respond_to(:phone) }
  end

  describe '#address' do
    it { should respond_to(:address) }
  end

  describe '#city' do
    it { should respond_to(:city) }
  end

  describe '#state' do
    it { should respond_to(:state) }
  end

  describe '#zipcode' do
    it { should respond_to(:zipcode) }
  end

  describe '#avatar' do
    it { should respond_to(:avatar) }
  end

  describe '#contact?' do
    it { should respond_to(:contact?) }
  end

  describe '#invited?' do
    it { should respond_to(:invited?) }
  end

  describe '#registered?' do
    it { should respond_to(:registered?) }
  end

  describe '#registered_user?' do
    it { should respond_to(:registered_user?) }
  end

  describe '#organization_manager?' do
    it { should respond_to(:organization_manager?) }
  end

  describe '#site_manager?' do
    it { should respond_to(:site_manager?) }
  end

  describe '#administrator?' do
    it { should respond_to(:administrator?) }
  end

  describe '#status' do
    it { should respond_to(:status) }

    it 'should default to contact_only' do
      expect(user.status).to eq('contact_only')
    end
  end

  describe '#role' do
    it { should respond_to(:role) }

    it 'should default to contact if not invited' do
      user = create(:user)
      expect(user.role).to eq('contact')
    end

    it 'should default to registered_user if invited' do
      user = create(:user, :invited)
      expect(user.role).to eq('registered_user')
    end

    it 'should default to registered_user if password is set' do
      user = create(:user, :password)
      expect(user.role).to eq('registered_user')
    end

    it "should accept valid roles" do
      user = build(:registered_user)
      User::ROLES.each do |valid_role|
        user.role = valid_role
        expect(user).to be_valid
      end
    end

    it "should reject invalid roles" do
      user.role = "invalid"
      expect(user).not_to be_valid
    end
  end

  describe '#password' do
    it { should respond_to(:password_digest) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }

    describe "when absent" do
      let(:user) { build(:registered_user, password: " ", password_confirmation: " ") }

      it "should be valid when user is contact" do
        user.role = 'contact'
        should be_valid
      end

      it "should be valid when user status is invited" do
        user.invite_token = 'token'
        should be_valid
      end

      it "should not be valid when user is registered" do
        User::ROLES.each do |role|
          if role != 'contact'
            user.role = 'registered'
            expect(user).not_to be_valid
          end
        end
      end
    end

    it 'should match confirmation' do
      user = build(:registered_user, password_confirmation: "mismatch")
      expect(user).not_to be_valid
    end

    it 'must be at least 6 characters' do
      user.role = 'registered_user'
      user.password = user.password_confirmation = "a" * 5
      should_not be_valid
    end
  end

  describe '#authenticate' do
    let(:user) { create(:registered_user) }
    let(:found_user) { User.find_by(email: user.email) }

    it { should respond_to(:authenticate) }

    describe "with valid password" do
      it { should eq found_user.authenticate(user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end

    describe "for non-registered users" do
      before { user.update_attribute(:invite_token, 'token') }
      let(:contact) { found_user.authenticate user.password }
      it { should_not eq contact }
      specify { expect(contact).to be_false }
    end
  end

  describe '#assignable_roles' do
    describe 'for administrators' do
      subject { create(:administrator) }
      its(:assignable_roles) { should == %w(contact registered_user organization_manager site_manager administrator) }
    end

    describe 'for site managers' do
      subject { create(:site_manager) }
      its(:assignable_roles) { should == %w(contact registered_user organization_manager site_manager) }
    end

    describe 'for organization managers' do
      subject { create(:organization_manager) }
      its(:assignable_roles) { should == %w(contact registered_user) }
    end

    describe 'for registered users' do
      subject { create(:registered_user) }
      its(:assignable_roles) { should == [] }
    end

    describe 'for contacts' do
      subject { create(:contact) }
      its(:assignable_roles) { should == [] }
    end
  end

  describe 'invitations' do
    let(:inviter) { create(:site_manager) }
    let(:invitee) { create(:contact) }

    subject { invitee }

    it { should respond_to(:invite_token) }
    it { should respond_to(:invited_by) }
    it { should respond_to(:invited_at) }

    describe 'prior to invite' do
      its(:invite_token) { should be_nil }
      its(:invited_by) { should be_nil }
      its(:invited_at) { should be_nil }
    end

    describe '#send_invite' do
      before { inviter.send_invite invitee }

      its(:status) { should == 'invited' }
      its(:role) { should == 'registered_user' }
      its(:invite_token) { should_not be_nil }
      its(:invited_by) { should == inviter.id }
      its(:invited_at) { should be_within(1.minute).of(Time.zone.now) }
    end

    describe '#uninvite' do
      before do
        inviter.send_invite invitee
        inviter.uninvite invitee
      end

      its(:status) { should == 'contact_only' }
      its(:role) { should == 'contact' }
      its(:invite_token) { should be_nil }
      its(:invited_by) { should be_nil }
      its(:invited_at) { should be_nil }
    end
  end
end
