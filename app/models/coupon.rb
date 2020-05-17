class Coupon < ApplicationRecord
  belongs_to :user

  enum is_valid: { '有効': true, '無効': false }

  attachment :image

  def self.coupon_create(user)
    time = Time.now.to_i
    coupon = Coupon.new(
      user_id: user.id,
      image_id: '75d6fabbac9c196cc890365c189cc3652ead8d009ba6f307870d272b7f37',
      limit: 1,
    )
    coupon.save
  end

  def self.coupon_destroy
    time = Time.now
    coupons = Coupon.all
    coupons.each do |coupon|
      if coupon.created_at + coupon.limit.days < time && coupon.is_valid == '有効'
        coupon.is_valid = '無効'
        coupon.save
      end
    end
  end
end
