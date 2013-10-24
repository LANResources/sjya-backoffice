require "spec_helper"

describe UserMailer do
  describe "invitation" do
    let(:invitee) { build_stubbed(:invited_registered_user) }

    subject { UserMailer.invitation invitee }

    its(:subject) { should == 'Registration Invitation' }
    its(:to) { should == [invitee.email] }
    its(:from) { should == ['invitations@youth-alliance.backofficeapps.com'] }

    it "contains the site name" do
      subject.body.encoded.should match("St. Joseph Youth Alliance BackOffice")
    end

    it "contains the recipient's name" do
      subject.body.encoded.should match(invitee.full_name)
    end

    it "contains the inviter's name" do
      subject.body.encoded.should match(invitee.inviter.full_name)
    end

    it "contains the rsvp link" do
      subject.body.encoded.should match("/users/#{invitee.id}/register/#{invitee.invite_token}")
    end
  end

end
