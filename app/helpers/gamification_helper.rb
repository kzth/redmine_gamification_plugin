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
      image_tag('/tutorial/check.png', {width: 20, height: 20, plugin: 'gamification'})
    end
  end
end
