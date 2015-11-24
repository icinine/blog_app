require 'rails_helper'

RSpec.feature "Adding Reviews to Articles" do
  
  before do
    @john = User.create(email:"john@example.com", password:"password")  
    @fred = User.create(email:"fred@example.com", password:"password")  
    
    @article = Article.create(title: "Article Title", body:"Article Body", user:@john)
  end
  
  scenario "permit signed in user to write a review" do
    login_as (@fred)
    
    visit "/"
    click_link @article.title
    fill_in "New Comment", with: "Great article"
    click_button "Add Comment"
    
    expect(page).to have_content("Article has been created")
    expect(page).to have_content("Great article")
    expect(current_path).to eq(article_path(@article.comments.last.id))
    
  end
  
end