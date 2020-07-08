require 'rails_helper'

RSpec.describe '表示のテスト', type: :feature do
  let(:admin) { create(:admin) }
  let(:current_user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:tourist_spot) { create(:tourist_spot, user: current_user) }
  let(:review) { create(:review, user: current_user, tourist_spot: tourist_spot) }
  let(:comment) { create(:comment, user: current_user, review: review) }
  let(:room) { create(:room) }
  subject { page }
  before do
    visit new_user_session_path
  end

  describe 'リンク表示のテスト' do
    context '管理者画面トップリンク' do
      it 'ログインしていれば表示される' do
        visit new_admin_session_path
        login(admin)
        is_expected.to have_link '管理者画面トップ'
      end
    end

    context 'ユーザー一覧リンク' do
      it 'ログインしていれば表示される' do
        visit new_admin_session_path
        login(admin)
        is_expected.to have_link 'ユーザー一覧'
      end
    end

    context '観光スポット一覧リンク' do
      it 'ログインしていれば表示される' do
        visit new_admin_session_path
        login(admin)
        is_expected.to have_link '観光スポット一覧'
      end
    end

    context 'ジャンル一覧リンク' do
      it 'ログインしていれば表示される' do
        visit new_admin_session_path
        login(admin)
        is_expected.to have_link 'ジャンル一覧'
      end
    end

    context '利用シーン一覧リンク' do
      it 'ログインしていれば表示される' do
        visit new_admin_session_path
        login(admin)
        is_expected.to have_link '利用シーン一覧'
      end
    end

    context 'ログアウトリンク' do
      it 'ログインしていれば表示される' do
        visit new_admin_session_path
        login(admin)
        is_expected.to have_link 'ログアウト'
      end
    end

    context '新規会員登録リンク' do
      it 'ログインしていなければ表示される' do
        is_expected.to have_link '新規会員登録'
      end
      it 'ログインしていれば表示されない' do
        login(current_user)
        is_expected.not_to have_link '新規会員登録'
      end
    end

    context 'ログインリンク' do
      it 'ログインしていなければ表示される' do
        is_expected.to have_link 'ログイン'
      end
      it 'ログインしていれば表示されない' do
        login(current_user)
        is_expected.not_to have_link 'ログイン'
      end
    end

    context 'マイページリンク' do
      it 'ログインしていれば表示される' do
        login(current_user)
        is_expected.to have_link 'マイページ'
      end
      it 'ログインしていなければ表示されない' do
        is_expected.not_to have_link 'マイページ'
      end
    end

    context '通知リンク' do
      it 'ログインしていれば表示される' do
        login(current_user)
        is_expected.to have_link '通知'
      end
      it 'ログインしていなければ表示されない' do
        is_expected.not_to have_link '通知'
      end
    end

    context 'メッセージリンク' do
      it 'ログインしていれば表示される' do
        login(current_user)
        is_expected.to have_link 'メッセージ'
      end
      it 'ログインしていなければ表示されない' do
        is_expected.not_to have_link 'メッセージ'
      end
    end

    context 'クーポンリンク' do
      it 'ログインしていれば表示される' do
        login(current_user)
        is_expected.to have_link 'クーポン'
      end
      it 'ログインしていなければ表示されない' do
        is_expected.not_to have_link 'クーポン'
      end
    end

    context '行きたい観光スポットリンク' do
      it 'ログインしていれば表示される' do
        login(current_user)
        is_expected.to have_link '行きたい観光スポット'
      end
      it 'ログインしていなければ表示されない' do
        is_expected.not_to have_link '行きたい観光スポット'
      end
    end

    context '行った観光スポットリンク' do
      it 'ログインしていれば表示される' do
        login(current_user)
        is_expected.to have_link '行った観光スポット'
      end
      it 'ログインしていなければ表示されない' do
        is_expected.not_to have_link '行った観光スポット'
      end
    end

    context 'マイカレンダーリンク' do
      it 'ログインしていれば表示される' do
        login(current_user)
        is_expected.to have_link 'マイカレンダー'
      end
      it 'ログインしていなければ表示されない' do
        is_expected.not_to have_link 'マイカレンダー'
      end
    end

    context 'プロフィール編集リンク' do
      it 'ログインしていれば表示される' do
        login(current_user)
        is_expected.to have_link 'プロフィール編集'
      end
      it 'ログインしていなければ表示されない' do
        is_expected.not_to have_link 'プロフィール編集'
      end
    end

    context 'ログアウトリンク' do
      it 'ログインしていれば表示される' do
        login(current_user)
        is_expected.to have_link 'ログアウト'
      end
      it 'ログインしていなければ表示されない' do
        is_expected.not_to have_link 'ログアウト'
      end
    end
  end

  describe 'ボタン表示のテスト' do
    context 'プロフィール編集ボタン' do
      it 'マイページであれば表示される' do
        login(current_user)
        visit user_user_path(current_user)
        is_expected.to have_link 'プロフィールを編集'
      end
      it 'マイページでなければ表示されない' do
        login(another_user)
        visit user_user_path(current_user)
        is_expected.not_to have_link 'プロフィールを編集'
      end
    end

    context '退会ボタン' do
      it 'マイページであれば表示される' do
        login(current_user)
        visit user_user_path(current_user)
        is_expected.to have_link '退会'
      end
      it 'マイページでなければ表示されない' do
        login(another_user)
        visit user_user_path(current_user)
        is_expected.not_to have_link '退会'
      end
    end

    context 'フォローボタン' do
      it 'マイページであれば表示されない' do
        login(current_user)
        visit user_user_path(current_user)
        is_expected.not_to have_link 'フォローする'
      end
      it 'マイページでなければ表示される' do
        login(another_user)
        visit user_user_path(current_user)
        is_expected.to have_link 'フォローする'
      end
    end

    context 'メッセージボタン' do
      it 'マイページであれば表示されない' do
        login(current_user)
        visit user_user_path(current_user)
        is_expected.not_to have_button 'メッセージ'
      end
      it 'マイページでなければ表示される' do
        login(another_user)
        visit user_user_path(current_user)
        is_expected.to have_button 'メッセージ'
      end
    end

    context '観光スポット編集ボタン' do
      it '自分が登録した観光スポットであれば表示される' do
        login(current_user)
        visit user_tourist_spot_path(tourist_spot)
        is_expected.to have_link '編集'
      end
      it '自分が登録した観光スポットでなければ表示されない' do
        login(another_user)
        visit user_tourist_spot_path(tourist_spot)
        is_expected.not_to have_link '編集'
      end
    end

    context '観光スポット削除ボタン' do
      it '自分が登録した観光スポットであれば表示される' do
        login(current_user)
        visit user_tourist_spot_path(tourist_spot)
        is_expected.to have_link '削除'
      end
      it '自分が登録した観光スポットでなければ表示されない' do
        login(another_user)
        visit user_tourist_spot_path(tourist_spot)
        is_expected.not_to have_link '削除'
      end
    end

    context '「行きたい！」ボタン' do
      it 'ログインしていれば表示される' do
        login(current_user)
        visit user_tourist_spot_path(tourist_spot)
        is_expected.to have_link '行きたい！'
      end
      it 'ログインしていなければ表示されない' do
        visit user_tourist_spot_path(tourist_spot)
        is_expected.not_to have_link '行きたい！'
      end
    end

    context '「行った！」ボタン' do
      it 'ログインしていれば表示される' do
        login(current_user)
        visit user_tourist_spot_path(tourist_spot)
        is_expected.to have_link '行った！'
      end
      it 'ログインしていなければ表示されない' do
        visit user_tourist_spot_path(tourist_spot)
        is_expected.not_to have_link '行った！'
      end
    end
  end
end