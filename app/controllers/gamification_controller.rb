# coding: utf-8

class GamificationController < ApplicationController
  unloadable

  menu_item :project_gamification

  before_filter :auth_gamification, only: [:index, :project]
  before_filter :find_project, only: [:project]

  def index
    current_user_id = User.current.id

    @user = Gamification.find_by_user_id(current_user_id)

    if GamificationLog.exists?({ to_user_id: current_user_id})
      @medal_logs = GamificationLog.where('to_user_id = ?', current_user_id).order(:updated_at).reverse_order.limit(10)
    end

    if session[:point]
      @point = @user.point.to_i - session[:point]
      session[:point] = @user.point
    else
      session[:point] = @user.point
    end

    if session[:level]
      diff_level = @user.level.to_i - session[:level]
      p diff_level
      unless diff_level == 0
        @level = @user.level
      else
        @level = 0
      end
      session[:level] = @user.level
    else
      session[:level] = @user.level
    end

    if session[:ticket]
      @ticket = @user.ticket_count.to_i - session[:ticket]
      session[:ticket] = @user.ticket_count
    else
      session[:ticket] = @user.ticket_count
    end
  end

  def setting
    @user = Gamification.find_by_user_id(User.current.id)
  end

  def save_goal
    user = Gamification.find_by_user_id(User.current.id)
    user.goal = params[:goal]
    if user.save
      flash[:notice] = '更新しました'
      redirect_to action: 'setting'
    end
  end

  def get_image
    @user = Gamification.find_by_user_id(User.current.id)
    send_data(@user.image, type: 'image/png', disposition: 'inline')
  end

  def user_image
    @user_image = Gamification.find_by_user_id(params[:uid].to_i)
    send_data(@user_image.image, disposition: 'inline')
  end

  def upload_image
    current_user_id = User.current.id
    user = Gamification.find_by_user_id(current_user_id)
    user.image = params[:gamification][:image].read

    if user.save

      # GamificationTut DBの更新
      if GamificationTut.exists?({user_id: current_user_id})
        GamificationTut.update_flag(current_user_id, :up_image_f)
      end

      flash[:notice] = '更新しました'
      redirect_to action: 'setting'
    end
  end

  def remove_image
    user = Gamification.find_by_user_id(User.current.id)
    user.image = nil
    if user.save
      redirect_to action: 'setting'
    end
  end

  def project
    current_user_id = User.current.id
    project_id = Project.find_by_identifier(params[:project_id]).id

    # プロジェクトが存在し、参加しているかの判定を行い、
    # 参加してない場合はプロジェクトへ参加する
    if Member.exists?({project_id: project_id, user_id: current_user_id}) && 
       !GamificationProject.exists?({project_id: project_id, user_id: current_user_id})
      project = GamificationProject.new
      project.user_id = current_user_id
      project.project_id = project_id

      if project.save
        # GamificationTut DBの更新
        if GamificationTut.exists?({user_id: current_user_id})
          GamificationTut.update_flag(current_user_id, :project_f)
        end
      end
    end

    unless GamificationProject.exists?({user_id: current_user_id, project_id: project_id})
      flash[:error] = "このプロジェクトに参加していません。"
      redirect_to action: 'error'
      return
    end

    @project_users = GamificationProject.where({project_id: project_id})
    @current_user_id = current_user_id
  end

  def entry
  end

  def create
    current_user_id = User.current.id

    # user create
    user = Gamification.new
    user.update_at = Date.today
    user.user_id = current_user_id

    # user project create
    members = Member.where(user_id: current_user_id).select('project_id')
    members.each do |member|
      project = GamificationProject.new
      project.user_id = current_user_id
      project.project_id = member.project_id
      project.save
    end

    # badge table create
    user_badge = GamificationBadge.new({user_id: current_user_id})
    unless user_badge.save
      redirect_to action: 'error'
    end

    # tut table create
    user_tut = GamificationTut.new({user_id: current_user_id})
    unless user_tut.save
      redirect_to action: 'error'
    end

    # medal table create
    user_medal = GamificationMedal.new({user_id: current_user_id})
    unless user_medal.save
      redirect_to 'error'
    end

    unless user.save
      redirect_to action: 'error'
    else
      flash[:notice] = '登録が完了しました。'
      redirect_to action: 'index'
    end
  end

  def tutorial
    @user = Gamification.find_by_user_id(User.current.id)
    user_tuts = GamificationTut.find_by_user_id(@user.user_id)
    @tuts = [
              {title: "プロジェクトに参加する", flag: user_tuts.project_f},
              {title: "新しいチケットを作成する", flag: user_tuts.new_tkt_f},
              {title: "チケットを更新する", flag: user_tuts.edit_tkt_f},
              {title: "wikiを更新する", flag: user_tuts.edit_wiki_f},
              {title: "トップページに画像をアップロードする", flag: user_tuts.up_image_f},
              {title: "メンバーを評価する", flag: user_tuts.rate_member_f}
            ]

    # アジャイルチェックリスト
    #@check_list = [
    #  {title: "", flag: }
    #]
  end

  def badges
    @user = Gamification.find_by_user_id(User.current.id)
    @user_badges = GamificationBadge.find_by_user_id(@user.user_id)
  end

  def rating
    my_account = Gamification.find_by_user_id(User.current.id)
    @medals = {'サンクスメダル' => 'thank_medal', 'スマイルメダル' => 'smile_medal', '熱血メダル' => 'hot_medal', 
               'ナイスアクションメダル' => 'nice_medal', 'コミュニケーションメダル' => 'comm_medal', '成長メダル' => 'grow_medal'}

    users = Gamification.all
    @users = {}
    users.each do |user|
      @users[user.user.login] = user.user_id unless user.user_id == my_account.user_id
    end
  end

  def rating_ticket
    current_user_id = fu = User.current.id
    return unless tu = params[:assigned_to_id]

    # 評価メダルを与える
    user = GamificationMedal.find_by_user_id(tu.to_i)
    medal = params[:medal]
    mon_medal = 'monthly_'.concat(medal)
    user[medal] += 1
    user[mon_medal] += 1

    # 評価メダルログ
    mdlog = GamificationLog.new
    mdlog.issue_id = params[:issue_id].to_i
    mdlog.from_user_id = fu.to_i 
    mdlog.to_user_id = tu.to_i
    mdlog.rating_medal = medal
    mdlog.updated_at = Date.today

    if user.save && mdlog.save

      # GamificationTut DBの更新
      if GamificationTut.exists?({user_id: current_user_id})
        GamificationTut.update_flag(current_user_id, :rate_member_f)
      end

      # ajaxで実装

      #flash[:notice] = '投票しました'
      #redirect_to action: 'rating'
    end

  end

  # ajax
  def search
    @user = Gamification.find_by_user_id(params[:rate_user].to_i)
  end

  def regist_rating
    current_user_id = User.current.id
    user = GamificationMedal.find_by_user_id(params[:rate_user].to_i)
    medal = params[:medal]
    mon_medal = 'monthly_'.concat(medal)
    user[medal] += 1
    user[mon_medal] += 1
    if user.save

      # GamificationTut DBの更新
      if GamificationTut.exists?({user_id: current_user_id})
        GamificationTut.update_flag(current_user_id, :rate_member_f)
      end

      flash[:notice] = '投票しました'
      redirect_to action: 'rating'
    end
  end

  def ranking
    @users = Gamification.order("point DESC").limit(20)
  end

  def ranking_monthly
    @users = Gamification.order("monthly_point DESC").limit(20)
  end

  def ranking_badge
    
  end

  def destroy
    current_user_id = User.current.id
    user = Gamification.find_by_user_id(current_user_id)
    user_badge = GamificationBadge.find_by_user_id(current_user_id)

    if user.destroy && user_badge.destroy && GamificationProject.destroy_all({user_id: current_user_id}) &&
       GamificationMedal.destroy({user_id: current_user_id})
      flash[:notice] = 'ゲーミフィケーションの機能を削除しました'
      redirect_to action: 'entry'
    else
      redirect_to action: 'error'
    end
  end

  def error
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  Admin = 1
  Anonymous = 2

  def auth_gamification
    user_id = User.current.id

    # 管理者またはゲストの場合はエラー
    if user_id == Admin || user_id == Anonymous
      flash[:error] = "この機能を利用できません。"
      redirect_to action: 'error'
      return 
    end

    unless Gamification.exists?(user_id: user_id)
      redirect_to action: 'entry'
      return
    end 
  end
end
