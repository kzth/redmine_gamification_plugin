# coding: utf-8

module GamificationHelper
  def badge_image(name, flag)
    if flag == 0
      image_tag('/badges/hatena.jpg', {width: 200, height: 200, plugin: 'gamification'})
    elsif flag == 1
      name = '/badges/' + name
      image_tag(name, {plugin: 'gamification'})
    end
  end

  def check_agile(list)
    return if list.nil?
    title = list[:title]
    name = list[:name]
    flag = list[:flag]
    if flag == 0
      list = 'list[' + name + ']'
      check_box_tag(list, 1, false)
    elsif flag == 1
      image_tag('/tutorial/check.png', {width: 20, height: 20, plugin: 'gamification', class: 'check-img'})
    end
  end

  def check_medal(medal)
    case medal
    when 'thank_medal'
      'サンクスメダル'
    when 'smile_medal'
      'スマイルメダル'
    when 'hot_medal'
      '熱血メダル'
    when 'nice_medal'
      'ナイスアクションメダル'
    when 'comm_medal'
      'コミュニケーションメダル'
    when 'grow_medal'
      '成長メダル'
    end
  end

  def check_agile_level(l)
    case l
    when 0
      '-'
    when 1
      '初心者'
    when 2
      '中級者'
    when 3
      '上級者'
    end
  end
end
