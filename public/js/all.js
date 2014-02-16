$(function(){
  /* リスト非表示 */
  $("#name_list").css("display","none");
  /* Allボタンを押したとき */
  $(".all").click(function(){
    $(".cap_lists").hide();
    $("#name_list").show();
    $(".cap_lists").show();
    $(".cap_list").css("color","black");
    $(".all").css("color","red");
  });
  /* 各インデックスボタンを押したとき */
  $(".cap_list").click(function(){
    var address_cap = $(this).html();
    var open_cap    = '#cap_' + address_cap;
    $(".cap_lists").hide();
    $("#name_list").show();
    $(open_cap).show();
    $(".all").css("color","black");
    $(".cap_list").css("color","black");
    $(this).css("color","red");
  });
  $(".address_detail").css("display","none");
  /* 各インデックス名前を押したとき */
  $(".caption_button").click(function(){
    var address_id = $(this).attr("name");
    var open_list  = '#ul_' + address_id;
    $(".address_detail").hide();
    $(open_list).show();
    $(".caption_button").css("color","black");
    $(this).css("color","red");
  });
})