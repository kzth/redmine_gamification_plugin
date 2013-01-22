    af = 8
    bf = 5
    cf = 3
    i = 0
    agile_f = 0
    f = ''

    while i < af
      f = 'af' + (i+0).to_s
      if user_agile[f.to_sym] == 0
        agile_f = 0
        break
      end
      agile_f = 1
      i++
    end

    i = 0
    if agile_f == 1
      while i < bf
        f = 'bf' + (i+0).to_s
        if user_agile[f.to_sym] == 0
          agile_f = 1
          break
        end
        agile_f = 2
        i++
      end
    end

    i = 0
    if agile_f == 2
      while i < cf
        f = 'cf' + (i+0).to_s
        if user_agile[f.to_sym] == 0
          agile_f = 2
          break
        end
        agile_f = 3
        i++
      end
    end

    user = Gamification.find_by_user_id(current_user_id)
    user.agile_level = agile_f
    user.save
