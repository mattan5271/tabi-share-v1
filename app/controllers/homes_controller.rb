class HomesController < ApplicationController
  def top
    @genres = Genre.all
    @scenes = Scene.all
    @tourist_spots = TouristSpot.top_ranking.limit(10) #観光スポットランキング(行きたい！数)
    @tags = TouristSpot.all.tag_counts.order(taggings_count: 'DESC').limit(10) # タグランキング
    @reviews = Review.recommended_order.limit(10)
    gon.tourist_spots = TouristSpot.all

    # ユーザーランキング
    users = User.all.order(point: 'DESC')
    @users = users.limit(10)
    @my_rank = 0
    if user_signed_in?
      users.each do |user|
        @my_rank += 1
        if user.id == current_user.id
          break
        end
      end
    end
  end

  def about
  end
end
