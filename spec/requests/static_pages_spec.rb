require 'spec_helper'

describe "Static Pages" do

  describe "Home Page" do
    before do
      log_in
    end

    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      expect(page.find('h1')).to have_content('About Us')
    end

    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_title("About Us · BackOffice · St. Joseph Youth Alliance")
    end
  end

end
