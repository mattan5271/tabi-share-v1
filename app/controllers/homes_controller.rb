class HomesController < ApplicationController
  def top
    @tourist_spots_rank = TouristSpot.top_ranking.limit(3) # 観光地ランキング順(行きたい！数)
    @tourist_spots_new = TouristSpot.top_new.limit(3) #観光地新着
    @users_rank = User.all.order(point: "DESC").limit(3) #ユーザーランキング(ポイント数)
    @tags_rank = TouristSpot.all.tag_counts.order(taggings_count: 'DESC').limit(10) # タグランキング
    @genre = Genre.all
    @scene = Scene.all
    gon.tourist_spots = TouristSpot.all
  end

  def about
  end
end
