class Api::V1::UploadsController < ApplicationController
  def create
    file = params[:image]

    if file
      # ランダムなファイル名を生成（例: "picture_123456.png"）
      extension = File.extname(file.original_filename) # 元のファイルの拡張子を取得
      random_filename = "picture_#{SecureRandom.uuid}#{extension}" # UUIDを使ってランダムなファイル名を作成

      # public/uploadsフォルダーに画像を保存する
      file_path = Rails.root.join('public', 'uploads', random_filename)
      
      # デバッグ出力
      Rails.logger.debug "Saving file to: #{file_path}"
      
      File.open(file_path, 'wb') do |f|
        f.write(file.read)
      end

      # 生成されたファイル名を含むURLを生成
      image_url = "/uploads/#{random_filename}"

      # デバッグ出力
      Rails.logger.debug "Generated image URL: #{image_url}"
      render json: { url: image_url }, status: :ok
    else
      render json: { error: 'ファイルがありません' }, status: :unprocessable_entity
    end
  end
end
