class RestaurantsController < ApplicationController
  def index
    lat = params[:lat]
    lng = params[:lng]
    range = params[:range]

    require 'uri'
    require 'net/http'
    require 'json'

    uri = 'https://api.gnavi.co.jp/RestSearchAPI/v3/'
    keyid = ENV['GNAVI_API_KEY']

    url = uri << '?keyid=' << keyid << '&hit_per_page=100' << '&latitude=' << lat << '&longitude=' << lng << '&range=' << range

    url = url << '&freeword=' << params[:freeword] if params[:freeword]


    url = URI.encode url
    re_url = URI.parse(url)
    json = Net::HTTP.get(re_url)
    hash = JSON.parse(json)
    restaurants = []

    if hash.key?('rest')
      hash['rest'].each do |rest|
        restaurants.push({
                           id: rest['id'],
                           name: rest['name'],
                           access: rest['access']['walk'],
                           image: rest['image_url']['shop_image1']
                         })
      end
    elsif hash.key?('error')

      @error = if hash['error'].first['code'] == 400
                 '不正なパラメーターが指定されました。'
               elsif hash['error'].first['code'] == 401
                 '不正なアクセス（認証エラー）です。'
               elsif hash['error'].first['code'] == 404
                 '指定された店舗の情報が存在しません。'
               elsif hash['error'].first['code'] == 405
                 '不正なアクセスです。'
               elsif hash['error'].first['code'] == 429
                 'リクエスト可能な上限回数を超過しました。'
               elsif hash['error'].first['code'] == 500
                 '処理中にエラーが発生しました。'
               else
                 'エラーが発生しました。'
               end

      @error
    end

    puts '=============テスト==========='
    puts restaurants
    puts '=============テスト終了==========='

    @restaurants = Kaminari.paginate_array(restaurants).page(params[:page]).per(10)
  end

  def search; end
end
