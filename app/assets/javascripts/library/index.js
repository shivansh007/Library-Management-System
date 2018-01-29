$("document").ready(function()
{
  $(window).click(function(event)
  {
    console.log($(event.target).attr('class'));
    if($(event.target).hasClass('modal')) 
    {
      $('.addForm').css('display', 'none');
      $('.editForm').css('display', 'none');
    }
  });
  $("#cross").click(function(event)
  {
    $('.modal').css('display', 'none');
  });

  $.ajax({
    type: "GET",
    dataType: 'json',
    url: "http://localhost:3000/libraries"
  })
  .done(function(data) 
  {
    for (var i = data.libraries.length - 1; i >= 0; i--) 
    {
      var table = $("#template").clone();
      table.removeAttr('hidden');
      table.find("#name").html(data.libraries[i].name);
      table.find("#address").append(data.libraries[i].address);
      table.find("#phone").append(data.libraries[i].phone);
      table.find("#link").html("<a href = 'http://localhost:3000/libraries/" + data.libraries[i].id + "'>Enter Here</a>");
      table.find("#delete").html("<button onclick = 'del(" + data.libraries[i].id + ");' class = 'button delete'>Delete</button>");
      table.find("#edit").html("<button onclick = 'edit(" + data.libraries[i].id + ");' class = 'button edit'>Edit</button>");
      $(".content").append(table);
    }
  })
  .fail(function(textStatus) 
  {
    console.log(textStatus);
  });

  $('.addForm #add_data').submit(function(e){
    e.preventDefault();
    $.ajax({
      type : 'POST',
      url : 'http://localhost:3000/libraries',
      dataType : 'json',
      data : $('.addForm #add_data').serialize(),
      success: function(response) 
      {
        window.location.reload();
      },
      error: function(textStatus) 
      {
        alert(textStatus.responseText['message']);
      }
    });
  });
  $('.editForm #edit_data').submit(function(d){
    var id = $('.editForm #edit_data').find('#id').val();
    d.preventDefault();
    $.ajax({
      type : 'PATCH',
      url : 'http://localhost:3000/libraries/' + id,
      dataType : 'json',
      data : $('.editForm #edit_data').serialize(),
      success: function(response) 
      {
        window.location.reload();
      },
      error: function(textStatus) 
      {
        alert(textStatus.responseText);
      }
    });
  });
  $('#addData').click(function(){
    $('.addForm').css('display', 'inline-block');
  });
});


function del(id)
{
  $(this).on("click", function(){
    $.ajax({
      type: "DELETE",
      dataType: 'json',
      url: "http://localhost:3000/libraries/" + id,
    })
    .done(function(data) 
    {
      alert("Deleted");
      window.location.reload();
    })
  });
}

function edit(id)
{
  $(this).on("click", function(){
    $('.editForm').css('display', 'inline-block');
    $.ajax({
      type: "GET",
      dataType: 'json',
      url: "http://localhost:3000/libraries/" + id,
    })
    .done(function(data) 
    {
      $('#edit_data input[id=id]').val(data.library.id);
      $('#edit_data input[id=name]').val(data.library.name);
      $('#edit_data input[id=address]').val(data.library.address);
      $('#edit_data input[id=phone]').val(data.library.phone);
    })
  });
}