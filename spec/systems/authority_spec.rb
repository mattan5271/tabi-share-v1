require 'rails_helper'

RSpec.describe 'ユーザー権限のテスト', type: :feature do
  let(:user) { create(:user) }
  subject { page }
  before do
    visit new_user_session_path
  end

  describe '遷移のテスト' do
    context 'ユーザー編集画面' do
      it '成功する' do
        login(user)
        visit edit_user_user_path(user)
        is_expected.to have_button '保存'
      end
      it '失敗する' do
        visit edit_user_user_path(user)
        is_expected.to have_content 'アカウント登録もしくはログインしてください。'
      end
    end

    context '観光スポット新規登録画面' do
      it '成功する' do
        login(user)
        visit new_user_tourist_spot_path
        is_expected.to have_button '新規登録'
      end
      it '失敗する' do
        visit new_user_tourist_spot_path
        is_expected.to have_content 'アカウント登録もしくはログインしてください。'
      end
    end
  end
end