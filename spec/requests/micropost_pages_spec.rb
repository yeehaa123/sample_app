require 'spec_helper'

describe "MicropostPages" do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }

	before { sign_in user }

	describe "micropost creation" do
		before { visit root_path }
	
		describe "with invalid information" do

			it "should not create a micropost" do
				expect{ click_button "Post" }.not_to change(Micropost, :count)			
			end

			describe "error messages" do
				before { click_button "Post"}
				it { should have_content('error') }			
			end
		end		
	end
end
