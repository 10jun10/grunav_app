class RestaurantsController < ApplicationController
  require 'open-uri'
  require 'net/http'
  require 'json'

  def index
    lat = params[:lat]
    lng = params[:lng]
    range = params[:range]

    query_items = {
      "keyid": ENV['GNAVI_API_KEY'],
      "latitude": lat,
      "longitude": lng,
      "hit_per_page": 100,
      "lunch": params[:lunch],
      "no_smoking": params[:no_smoking],
      "card": params[:card],
      "e_money": params[:e_money],
      "buffet": params[:buffet],
      "lunch_buffet": params[:lunch_buffet],
      "bottomless_cup": params[:bottomless_cup],
      "deliverly": params[:deliverly],
      "until_morning": params[:until_morning],
      "lunch_desert": params[:lunch_desert],
      "midnight": params[:midnight],
      "range": range
    }
    query = query_items.to_query

    url = 'https://api.gnavi.co.jp/RestSearchAPI/v3/?' << query

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
      render :search
    end
    @restaurants = Kaminari.paginate_array(restaurants).page(params[:page]).per(10)
  end

  def search; end

  def show
    uri = 'https://api.gnavi.co.jp/RestSearchAPI/v3/'
    access_key = ENV['GNAVI_API_KEY']
    id = params[:id]
    url = uri << '?keyid=' << access_key << '&id=' << id

    url = URI.encode url
    re_url = URI.parse(url)
    json = Net::HTTP.get(re_url)
    hash = JSON.parse(json)
    @restaurants = []

    if hash.key?('rest')
      hash['rest'].each do |rest|
        @restaurants.push({
                            name: rest['name'],
                            name_kana: rest['name_kana'],
                            category: rest['category'],
                            url: rest['url'],
                            url_mobile: rest['url_mobile'],
                            address: rest['address'],
                            image1: rest['image_url']['shop_image1'],
                            image2: rest['image_url']['shop_image2'],
                            opentime: rest['opentime'],
                            holiday: rest['holiday'],
                            pr_short: rest['pr']['pr_short'],
                            pr_long: rest['pr']['pr_long'],
                            budget: rest['budget'],
                            party: rest['party'],
                            lunch: rest['lunch'],
                            tel: rest['tel']
                          })
      end
    elsif hash.key?('error')
      @error = if hash['error']['code'] == '400'
                 '不正なパラメーターが指定されました。'
               elsif hash['error']['code'] == '401'
                 '不正なアクセス（認証エラー）です。'
               elsif hash['error']['code'] == '404'
                 '指定された店舗の情報が存在しません。'
               elsif hash['error']['code'] == '405'
                 '不正なアクセスです。'
               elsif hash['error']['code'] == '429'
                 'リクエスト可能な上限回数を超過しました。'
               elsif hash['error']['code'] == '500'
                 '処理中にエラーが発生しました。'
               else
                 'エラーが発生しました。'
               end
      render :index
    end
  end
end
