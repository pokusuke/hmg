$(document).on('turbolinks:load',function(){
  // flashのフェードアウト
  $('.flash-msg').fadeOut(2000)

  //画像プレビュー
  $inputFile = $('.input-file');
  $inputFile.on('change',function(e){
    var file = this.files[0],
        $img = $(this).siblings('.prev-img'),
        fileReader = new FileReader();
    fileReader.onload = function(event){
      $img.addClass('show').attr('src',event.target.result);
    };
    fileReader.readAsDataURL(file);
  });  
  $imgClear = $('.img-clear');
  $imgClear.on('click',function(e){
    $(this).siblings('.remove-img').val(true);
    $(this).siblings('.input-file').val('');
    $(this).siblings('.prev-img').removeClass('show').attr('src','');
  });
})