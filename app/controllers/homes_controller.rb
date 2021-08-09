class HomesController < ApplicationController

  def top

  end

  def news
      uri = "https://newsapi.org/v2/everything?q=%E3%83%90%E3%82%B9%E3%82%B1&sortBy=popularity&apiKey=08e77fd7762e4312810107351e5d8464"
      article_serialized = open(uri).read
      @articles = JSON.parse(article_serialized)
  end

  def game_east

    year = params[:year]

    # API-NBAからリーグ順位情報を取得
    require 'uri'
    require 'net/http'
    require 'openssl'

    url = URI("https://api-nba-v1.p.rapidapi.com/standings/standard/#{year}/conference/east")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = '89d0cb5f10msh9fbc8b12596ffebp19602djsn37814997cd03'
    request["x-rapidapi-host"] = 'api-nba-v1.p.rapidapi.com'

    response = http.request(request)
    result = JSON.parse(response.read_body)

    # JSONファイルを扱いやすいように配列に挿入
    array = []
    for i in 0..14 do
      array << result["api"]["standings"][i]
    end

    # 順位順に並べ替え
    array.sort! do |a, b|
      a["conference"]["rank"].to_i <=> b["conference"]["rank"].to_i
    end

    # チーム名をJSON配列に挿入
    array.each do |team|
      case team["teamId"]
        when "1" then
          team["teamId"] = {"fullName" => "アトランタ ホークス",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/e/ee/Hawks_2016.png"}
        when "2" then
          team["teamId"] = {"fullName" => "ボストン セルティックス",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/6/65/Celtics_de_Boston_logo.svg/1024px-Celtics_de_Boston_logo.svg.png"}
        when "4" then
          team["teamId"] = {"fullName" => "ブルックリン ネッツ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Brooklyn_Nets_newlogo.svg/130px-Brooklyn_Nets_newlogo.svg.png"}
        when "5" then
          team["teamId"] = {"fullName" => "シャーロット ホーネッツ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/f/f3/Hornets_de_Charlotte_logo.svg/1200px-Hornets_de_Charlotte_logo.svg.png"}
        when "6" then
          team["teamId"] = {"fullName" => "シカゴ ブルズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/d/d1/Bulls_de_Chicago_logo.svg/1200px-Bulls_de_Chicago_logo.svg.png"}
        when "7" then
          team["teamId"] = {"fullName" => "クリーブランド キャバリアーズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/0/06/Cavs_de_Cleveland_logo_2017.png/150px-Cavs_de_Cleveland_logo_2017.png"}
        when "8" then
          team["teamId"] = {"fullName" => "ダラス マーベリックス",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/b/b8/Mavericks_de_Dallas_logo.svg/150px-Mavericks_de_Dallas_logo.svg.png"}
        when "9" then
          team["teamId"] = {"fullName" => "デンバー ナゲッツ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/3/35/Nuggets_de_Denver_2018.png/180px-Nuggets_de_Denver_2018.png"}
        when "10" then
          team["teamId"] = {"fullName" => "デトロイト ピストンズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/en/thumb/1/1e/Detroit_Pistons_logo.svg/1200px-Detroit_Pistons_logo.svg.png"}
        when "11" then
          team["teamId"] = {"fullName" => "ゴールデンステイト ウォーリアーズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/d/de/Warriors_de_Golden_State_logo.svg/1200px-Warriors_de_Golden_State_logo.svg.png"}
        when "14" then
          team["teamId"] = {"fullName" => "ヒューストン ロケッツ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/d/de/Houston_Rockets_logo_2003.png/330px-Houston_Rockets_logo_2003.png"}
        when "15" then
          team["teamId"] = {"fullName" => "インディアナ ペイサーズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/c/cf/Pacers_de_l%27Indiana_logo.svg/1180px-Pacers_de_l%27Indiana_logo.svg.png"}
        when "16" then
          team["teamId"] = {"fullName" => "ロサンゼルス クリッパーズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/d/d6/Los_Angeles_Clippers_logo_2010.png"}
        when "17" then
          team["teamId"] = {"fullName" => "ロサンゼルス レイカーズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Los_Angeles_Lakers_logo.svg/220px-Los_Angeles_Lakers_logo.svg.png"}
        when "19" then
          team["teamId"] = {"fullName" => "メンフィス グリズリーズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/en/thumb/f/f1/Memphis_Grizzlies.svg/1200px-Memphis_Grizzlies.svg.png"}
        when "20" then
          team["teamId"] = {"fullName" => "マイアミ ヒート",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/1/1c/Miami_Heat_-_Logo.svg/1200px-Miami_Heat_-_Logo.svg.png"}
        when "21" then
          team["teamId"] = {"fullName" => "ミルウォーキー バックス",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/3/34/Bucks2015.png"}
        when "22" then
          team["teamId"] = {"fullName" => "ミネソタ ティンバーウルブス",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/d/d9/Timberwolves_du_Minnesota_logo_2017.png/200px-Timberwolves_du_Minnesota_logo_2017.png"}
        when "23" then
          team["teamId"] = {"fullName" => "ニューオーリンズ ペリカンズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/2/21/New_Orleans_Pelicans.png/200px-New_Orleans_Pelicans.png"}
        when "24" then
          team["teamId"] = {"fullName" => "ニューヨーク ニックス",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/d/dc/NY_Knicks_Logo_2011.png"}
        when "25" then
          team["teamId"] = {"fullName" => "オクラホマシティ サンダー",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/4/4f/Thunder_d%27Oklahoma_City_logo.svg/1200px-Thunder_d%27Oklahoma_City_logo.svg.png"}
        when "26" then
          team["teamId"] = {"fullName" => "オーランド マジック",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/b/bd/Orlando_Magic_logo_2010.png"}
        when "27" then
          team["teamId"] = {"fullName" => "フィラデルフィア 76ers",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/4/48/76ers_2016.png"}
        when "28" then
          team["teamId"] = {"fullName" => "フェニックス サンズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/5/56/Phoenix_Suns_2013.png"}
        when "29" then
          team["teamId"] = {"fullName" => "ポートランドトレイル ブレイザーズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/en/thumb/2/21/Portland_Trail_Blazers_logo.svg/1200px-Portland_Trail_Blazers_logo.svg.png"}
        when "30" then
          team["teamId"] = {"fullName" => "サクラメント キングス",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/9/95/Kings_de_Sacramento_logo.svg/1200px-Kings_de_Sacramento_logo.svg.png"}
        when "31" then
          team["teamId"] = {"fullName" => "サンアントニオ スパーズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/0/0e/San_Antonio_Spurs_2018.png"}
        when "38" then
          team["teamId"] = {"fullName" => "トロント ラプターズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/8/89/Raptors2015.png"}
        when "40" then
          team["teamId"] = {"fullName" => "ユタ ジャズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/3/3b/Jazz_de_l%27Utah_logo.png"}
        when "41" then
          team["teamId"] = {"fullName" => "ワシントン ウィザーズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/archive/d/d6/20161212034849%21Wizards2015.png"}
      end
    end

    @team_rank = array
  end

  def game_west
    year = params[:year]

    # API-NBAからリーグ順位情報を取得
    require 'uri'
    require 'net/http'
    require 'openssl'

    url = URI("https://api-nba-v1.p.rapidapi.com/standings/standard/#{year}/conference/west")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = '89d0cb5f10msh9fbc8b12596ffebp19602djsn37814997cd03'
    request["x-rapidapi-host"] = 'api-nba-v1.p.rapidapi.com'

    response = http.request(request)
    result = JSON.parse(response.read_body)

    # JSONファイルを扱いやすいように配列に挿入
    array = []
    for i in 0..14 do
      array << result["api"]["standings"][i]
    end

    # 順位順に並べ替え
    array.sort! do |a, b|
      a["conference"]["rank"].to_i <=> b["conference"]["rank"].to_i
    end

    # チーム名をJSON配列に挿入
    array.each do |team|
      case team["teamId"]
        when "1" then
          team["teamId"] = {"fullName" => "アトランタ ホークス",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/e/ee/Hawks_2016.png"}
        when "2" then
          team["teamId"] = {"fullName" => "ボストン セルティックス",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/6/65/Celtics_de_Boston_logo.svg/1024px-Celtics_de_Boston_logo.svg.png"}
        when "4" then
          team["teamId"] = {"fullName" => "ブルックリン ネッツ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Brooklyn_Nets_newlogo.svg/130px-Brooklyn_Nets_newlogo.svg.png"}
        when "5" then
          team["teamId"] = {"fullName" => "シャーロット ホーネッツ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/f/f3/Hornets_de_Charlotte_logo.svg/1200px-Hornets_de_Charlotte_logo.svg.png"}
        when "6" then
          team["teamId"] = {"fullName" => "シカゴ ブルズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/d/d1/Bulls_de_Chicago_logo.svg/1200px-Bulls_de_Chicago_logo.svg.png"}
        when "7" then
          team["teamId"] = {"fullName" => "クリーブランド キャバリアーズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/0/06/Cavs_de_Cleveland_logo_2017.png/150px-Cavs_de_Cleveland_logo_2017.png"}
        when "8" then
          team["teamId"] = {"fullName" => "ダラス マーベリックス",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/b/b8/Mavericks_de_Dallas_logo.svg/150px-Mavericks_de_Dallas_logo.svg.png"}
        when "9" then
          team["teamId"] = {"fullName" => "デンバー ナゲッツ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/3/35/Nuggets_de_Denver_2018.png/180px-Nuggets_de_Denver_2018.png"}
        when "10" then
          team["teamId"] = {"fullName" => "デトロイト ピストンズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/en/thumb/1/1e/Detroit_Pistons_logo.svg/1200px-Detroit_Pistons_logo.svg.png"}
        when "11" then
          team["teamId"] = {"fullName" => "ゴールデンステイト ウォーリアーズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/d/de/Warriors_de_Golden_State_logo.svg/1200px-Warriors_de_Golden_State_logo.svg.png"}
        when "14" then
          team["teamId"] = {"fullName" => "ヒューストン ロケッツ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/d/de/Houston_Rockets_logo_2003.png/330px-Houston_Rockets_logo_2003.png"}
        when "15" then
          team["teamId"] = {"fullName" => "インディアナ ペイサーズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/c/cf/Pacers_de_l%27Indiana_logo.svg/1180px-Pacers_de_l%27Indiana_logo.svg.png"}
        when "16" then
          team["teamId"] = {"fullName" => "ロサンゼルス クリッパーズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/d/d6/Los_Angeles_Clippers_logo_2010.png"}
        when "17" then
          team["teamId"] = {"fullName" => "ロサンゼルス レイカーズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Los_Angeles_Lakers_logo.svg/220px-Los_Angeles_Lakers_logo.svg.png"}
        when "19" then
          team["teamId"] = {"fullName" => "メンフィス グリズリーズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/en/thumb/f/f1/Memphis_Grizzlies.svg/1200px-Memphis_Grizzlies.svg.png"}
        when "20" then
          team["teamId"] = {"fullName" => "マイアミ ヒート",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/1/1c/Miami_Heat_-_Logo.svg/1200px-Miami_Heat_-_Logo.svg.png"}
        when "21" then
          team["teamId"] = {"fullName" => "ミルウォーキー バックス",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/3/34/Bucks2015.png"}
        when "22" then
          team["teamId"] = {"fullName" => "ミネソタ ティンバーウルブス",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/d/d9/Timberwolves_du_Minnesota_logo_2017.png/200px-Timberwolves_du_Minnesota_logo_2017.png"}
        when "23" then
          team["teamId"] = {"fullName" => "ニューオーリンズ ペリカンズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/2/21/New_Orleans_Pelicans.png/200px-New_Orleans_Pelicans.png"}
        when "24" then
          team["teamId"] = {"fullName" => "ニューヨーク ニックス",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/d/dc/NY_Knicks_Logo_2011.png"}
        when "25" then
          team["teamId"] = {"fullName" => "オクラホマシティ サンダー",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/4/4f/Thunder_d%27Oklahoma_City_logo.svg/1200px-Thunder_d%27Oklahoma_City_logo.svg.png"}
        when "26" then
          team["teamId"] = {"fullName" => "オーランド マジック",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/b/bd/Orlando_Magic_logo_2010.png"}
        when "27" then
          team["teamId"] = {"fullName" => "フィラデルフィア 76ers",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/4/48/76ers_2016.png"}
        when "28" then
          team["teamId"] = {"fullName" => "フェニックス サンズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/5/56/Phoenix_Suns_2013.png"}
        when "29" then
          team["teamId"] = {"fullName" => "ポートランドトレイル ブレイザーズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/en/thumb/2/21/Portland_Trail_Blazers_logo.svg/1200px-Portland_Trail_Blazers_logo.svg.png"}
        when "30" then
          team["teamId"] = {"fullName" => "サクラメント キングス",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/thumb/9/95/Kings_de_Sacramento_logo.svg/1200px-Kings_de_Sacramento_logo.svg.png"}
        when "31" then
          team["teamId"] = {"fullName" => "サンアントニオ スパーズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/0/0e/San_Antonio_Spurs_2018.png"}
        when "38" then
          team["teamId"] = {"fullName" => "トロント ラプターズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/8/89/Raptors2015.png"}
        when "40" then
          team["teamId"] = {"fullName" => "ユタ ジャズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/3/3b/Jazz_de_l%27Utah_logo.png"}
        when "41" then
          team["teamId"] = {"fullName" => "ワシントン ウィザーズ",
                            "logo"     => "https://upload.wikimedia.org/wikipedia/fr/archive/d/d6/20161212034849%21Wizards2015.png"}
      end
    end

    @team_rank = array
  end
end
