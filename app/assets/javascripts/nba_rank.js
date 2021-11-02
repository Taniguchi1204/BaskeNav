// ランキングの年度変更タブ
$(function() {
  $('.game--years__tab a').on('click', function() {
    let parentElm = $(this).parent(); //タブ内のaタグの親要素（li）を取得
			$('.game--years__tab li').removeClass("active"); //タブ内のliについているactiveクラスを取り除き
			$(parentElm).addClass("active"); //リンク元の指定されたURLのハッシュタグとタブ内のリンク名が同じであれば、liにactiveクラスを追加
	})
})