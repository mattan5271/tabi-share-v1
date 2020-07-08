require 'rails_helper'

RSpec.describe 'ログインとログアウト', type: :feature do
  describe 'ユーザー認証のテスト' do
    let(:user) { create(:user) }

    it 'ログインできること' do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      expect(page).to have_content 'ログアウト'
    end
  end
end