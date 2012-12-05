module GamificationUtil
  # レベルチェック関数
  def check_level(old, new)
    if old < new
      return new
    end
    old
  end

  # レベルの計算
  def decide_level(point)
    lvl = 1
    total = point
    up_point = 100
    while total >= up_point
      lvl += 1
      total = total - up_point
      up_point = up_point * 1.2
    end
    lvl
  end

  def check_badge(user_badge, lvl)
    user_badge.lvl5_badge   = 1 if 5   <= lvl
    user_badge.lvl10_badge  = 1 if 10  <= lvl
    user_badge.lvl50_badge  = 1 if 50  <= lvl
    user_badge.lvl100_badge = 1 if 100 <= lvl
    user_badge
  end
end
