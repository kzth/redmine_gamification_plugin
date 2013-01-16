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
    diff = up_point - total
    return lvl, diff
  end

  def check_level_badge(user_badge, lvl)
    user_badge.lvl5_badge   = 1 if 5   <= lvl
    user_badge.lvl10_badge  = 1 if 10  <= lvl
    user_badge.lvl50_badge  = 1 if 50  <= lvl
    user_badge.lvl100_badge = 1 if 100 <= lvl
    check_badge_count(user_badge)
    user_badge
  end

  def check_ticket_badge(user_badge, tkt_count)
    user_badge.tkt10_badge   = 1 if 10 <= tkt_count
    user_badge.tkt50_badge   = 1 if 50 <= tkt_count
    user_badge.tkt100_badge  = 1 if 100 <= tkt_count
    user_badge.tkt500_badge  = 1 if 500 <= tkt_count
    user_badge.tkt1000_badge = 1 if 1000 <= tkt_count
    check_badge_count(user_badge)
    user_badge
  end

  def check_badge_count(user_badge)
    sum = 0
    sum += user_badge.lvl5_badge.to_i
    sum += user_badge.lvl10_badge.to_i
    sum += user_badge.lvl50_badge.to_i
    sum += user_badge.lvl100_badge.to_i
    sum += user_badge.tkt10_badge.to_i
    sum += user_badge.tkt50_badge.to_i
    sum += user_badge.tkt100_badge.to_i
    sum += user_badge.tkt500_badge.to_i
    sum += user_badge.tkt1000_badge.to_i
    user = Gamification.find_by_user_id(user_badge.user_id)
    user.badge_count = sum
    user.save
  end
end
