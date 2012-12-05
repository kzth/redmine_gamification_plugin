window.onload = function() {
  var rc = new html5jp.graph.radar('sample');
  if (!rc) { return; }
  var items = [
    ['獲得メダル', <%= @user.gamification_medal.thank_medal  %>,
                   <%= @user.gamification_medal.smile_medal  %>,
                   <%= @user.gamification_medal.hot_medal  %>,
                   <%= @user.gamification_medal.nice_medal  %>,
                   <%= @user.gamification_medal.comm_medal  %>,
                   <%= @user.gamification_medal.grow_medal  %>]
  ];
  var params = {
    aCap: ['サンクスメダル', 'スマイルメダル', '熱血メダル',
           'ナイスメダル', 'コミュニケーションメダル', '成長メダル']
  };
  rc.draw(items, params);
}
