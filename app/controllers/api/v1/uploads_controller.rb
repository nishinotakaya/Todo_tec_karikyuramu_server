require 'cgi'

class Api::V1::UploadsController < ApplicationController
  def create
    file = params[:image]

    if file
      # ファイル名をURLエンコード (CGI.escapeを使用) し、さらに '+' を '%20' に置換
      encoded_filename = CGI.escape(file.original_filename).gsub('+', '%20')

      # public/uploadsフォルダーに画像を保存する
      file_path = Rails.root.join('public', 'uploads', encoded_filename)
      
      # デバッグ出力
      Rails.logger.debug "Saving file to: #{file_path}"
      
      File.open(file_path, 'wb') do |f|
        f.write(file.read)
      end

      # エンコードされたファイル名を含むURLを生成
      image_url = "/uploads/#{encoded_filename}"

      # デバッグ出力
      Rails.logger.debug "Generated image URL: #{image_url}"
      binding.pry
      render json: { url: image_url }, status: :ok
    else
      render json: { error: 'ファイルがありません' }, status: :unprocessable_entity
    end
  end
end
