require 'rails_helper'

RSpec.describe 'ユーザー権限のテスト', type: :feature do
  let(:current_user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:tourist_spot) { create(:tourist_spot, user: current_user) }
  let(:review) { create(:review, user: current_user, tourist_spot: tourist_spot) }
  let(:comment) { create(:comment, user: current_user, review: review) }
  let(:room) { create(:room) }
  subject { page }
  before do
    visit new_user_session_path
  end

  describe '遷移のテスト' do
    context 'ユーザー編集画面' do
      it 'ログインしていれば成功する' do
        login(current_user)
        visit edit_user_user_path(current_user)
        is_expected.to have_button '保存'
      end
      it 'ログインしていなければ失敗する' do
        visit edit_user_user_path(current_user)
        is_expected.to have_content 'アカウント登録もしくはログインしてください。'
      end
    end

    context '観光スポット新規登録画面' do
      it 'ログインしていれば成功する' do
        login(current_user)
        visit new_user_tourist_spot_path
        is_expected.to have_button '新規登録'
      end
      it 'ログインしていなければ失敗する' do
        visit new_user_tourist_spot_path
        is_expected.to have_content 'アカウント登録もしくはログインしてください。'
      end
    end

    context '観光スポット編集画面' do
      it 'ログインしていて、自分が作成した観光スポットであれば成功する' do
        login(current_user)
        visit edit_user_tourist_spot_path(tourist_spot)
        is_expected.to have_button '保存'
      end
      it 'ログインしていても、自分が作成した観光スポットでなければ失敗する' do
        login(other_user)
        visit edit_user_tourist_spot_path(tourist_spot)
        expect(current_path).to eq('/')
      end
      it 'ログインしていなければ失敗する' do
        visit edit_user_tourist_spot_path(tourist_spot)
        is_expected.to have_content 'アカウント登録もしくはログインしてください。'
      end
    end

    context 'レビュー新規作成画面' do
      it 'ログインしていれば成功する' do
        login(current_user)
        visit new_user_tourist_spot_review_path(tourist_spot)
        is_expected.to have_button '投稿'
      end
      it 'ログインしていなければ失敗する' do
        visit new_user_tourist_spot_review_path(tourist_spot)
        is_expected.to have_content 'アカウント登録もしくはログインしてください。'
      end
    end

    context 'レビュー編集画面' do
      it 'ログインしていて、自分が投稿したレビューであれば成功する' do
        login(current_user)
        visit edit_user_tourist_spot_review_path(tourist_spot, review)
        is_expected.to have_button '保存'
      end
      it 'ログインしていても、自分が投稿したレビューでなければ失敗する' do
        login(other_user)
        visit edit_user_tourist_spot_review_path(tourist_spot, review)
        expect(current_path).to eq('/')
      end
      it 'ログインしていなければ失敗する' do
        visit edit_user_tourist_spot_review_path(tourist_spot, review)
        is_expected.to have_content 'アカウント登録もしくはログインしてください。'
      end
    end

    context 'コメント編集画面' do
      it 'ログインしていて、自分が投稿したコメントであれば成功する' do
        login(current_user)
        visit edit_user_tourist_spot_review_comment_path(tourist_spot, review, comment)
        is_expected.to have_button '保存'
      end
      it 'ログインしていても、自分が投稿したコメントでなければ失敗する' do
        login(other_user)
        visit edit_user_tourist_spot_review_comment_path(tourist_spot, review, comment)
        expect(current_path).to eq('/')
      end
      it 'ログインしていなければ失敗する' do
        visit edit_user_tourist_spot_review_comment_path(tourist_spot, review, comment)
        is_expected.to have_content 'アカウント登録もしくはログインしてください。'
      end
    end

    context 'ダイレクトメッセージ一覧画面' do
      it 'ログインしていれば成功する' do
        login(current_user)
        visit user_rooms_path
        expect(current_path).to eq('/user/rooms')
      end
      it 'ログインしていなければ失敗する' do
        visit user_rooms_path
        is_expected.to have_content 'アカウント登録もしくはログインしてください。'
      end
    end

    context 'ダイレクトメッセージ詳細画面' do
      it 'ログインしていれば成功する' do
        login(current_user)
        visit user_room_path(room, user)
        expect(current_path).to eq('/user/rooms')
      end
      it 'ログインしていなければ失敗する' do
        visit user_room_path(room)
        is_expected.to have_content 'アカウント登録もしくはログインしてください。'
      end
    end
  end
end