require 'spec_helper'

describe "MicropostPages" do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	let(:other_user) {FactoryGirl.create(:user) }

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

	describe "micropost destruction" do
		before { FactoryGirl.create(:micropost, user: user) }

		describe "as correct user" do
			before { visit root_path }
			
			it { should have_link('delete') }

			it "should delete a micropost" do
				expect { click_link "delete" }.should change(Micropost, :count).by(-1)
			end
		end

		describe "as wrong user" do
			before { visit user_path(other_user) }
			it { should_not have_link('delete') }
		end
	end

	describe "feed behaviour" do
		before do
			31.times { FactoryGirl.create(:micropost, user: user) }
			visit user_path(user)
		end

		it { should have_selector('div.pagination') }

		it "should list each micropost" do
			user.feed.paginate(page: 1).each do |item|
				page.should have_selector("li>span", text: item.content)
			end
		end	
	end
end
