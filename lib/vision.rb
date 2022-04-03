require 'base64'
require 'json'
require 'net/https'
module Vision
  class << self
    def image_analysis(profile_image)
      image_annotator = Google::Cloud::Vision::ImageAnnotator.new(
          version: :v1,
          credentials: JSON.parse(File.open("tabi-share-0af400ab0eff.json") do |f| f.read end)
      )

      # リクエストパラメータ作成
      image = profile_image
      requests_content = { image: { content: image }, features: [{ type: :SAFE_SEARCH_DETECTION }] }
      requests =   [requests_content]

      # Cloud Vision APIに画像を送信
      response = image_annotator.batch_annotate_images(requests)
      result = response.responses[0].safe_search_annotation.to_h
      # => {:adult=>:VERY_UNLIKELY, :spoof=>:UNLIKELY, :medical=>:VERY_UNLIKELY, :violence=>:VERY_UNLIKELY, :racy=>:VERY_UNLIKELY}
      # binding.pry
      # 不適切な画像の疑いがある場合は保存しない
      if result.values.include?(:LIKELY) || result.values.include?(:VERY_LIKELY)
        return false
      else
        return true
      end
    end
  end
end