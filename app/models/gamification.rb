# coding: utf-8

require 'date'

class Gamification < ActiveRecord::Base
  unloadable

  belongs_to :user
  has_one :gamification_medal, {foreign_key: 'user_id', primary_key: 'user_id'}

  def up_point(add_point)
    self.point += add_point
    self.monthly_point += add_point
  end

  def up_ticket_count
    self.ticket_count += 1
    self.monthly_ticket_count += 1
  end

  def update_date
    self.update_at = Date.today
  end

  def differ_month
    month = Date.today.month
    if month == self.update_at.month
      return false
    end
    true
  end

  def monthly_init
    self.monthly_point = 0
    self.monthly_ticket_count = 0
  end
end
