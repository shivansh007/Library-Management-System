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
    url: window.location.href,
  })
  .done(function(data) 
  {
    var table = $("#info");
    $(".header #heading").html(data.library.name);
    table.find("#address").append(data.library.address);
    table.find("#phone").append(data.library.phone);
    $.ajax({
      type: "GET",
      dataType: 'json',
      url: "http://localhost:3000/books",
      success: function(data)
      {
        for (var i = data.books.length - 1; i >= 0; i--) 
        {
          var temp = $("#template").clone();
          temp.removeAttr('hidden');
          var arr = window.location.href.split("/");
          if(data.books[i].library_id == arr[arr.length - 1])
          {
            temp.find("#name").html(data.books[i].name);
            temp.find("#author").append(data.books[i].author);
            temp.find("#price").append(data.books[i].price);
            temp.find("#copies").append(data.books[i].no_of_copies);
            temp.find("#isbn").append(data.books[i].isbn);
            temp.find("#version").append(data.books[i].version);
            temp.find("#publication").append(data.books[i].publication);
            temp.find("#delete").html("<button onclick = 'del(" + data.books[i].id + ");' class = 'button delete'>Delete</button>");
            temp.find("#edit").html("<button onclick = 'edit(" + data.books[i].id + ");' class = 'button edit'>Edit</button>");
            $.ajax({
              type: "GET",
              dataType: 'json',
              url: "http://localhost:3000/categories/" + data.books[i].category_id,
              async: false,
              success: function(data)
              {
                temp.find("#category").append(data.category.name);
              }
            });
            $(".content").append(temp);
          }
        }
      },
      error: function()
      {
        alert("Bad");
      }
    })
  })
  .fail(function(textStatus) 
  {
    console.log(textStatus);
  });

  $('.addBook #add_data').submit(function(e){
    e.preventDefault();
    $.ajax({
      type : 'POST',
      url : 'http://localhost:3000/books',
      dataType : 'json',
      data : $('.addBook #add_data').serialize(),
      success: function(response) 
      {
        window.location.reload();
      },
      error: function(textStatus) 
      {
        console.log(textStatus.responseText);
      }
    });
  });
  $('.editBook #edit_data').submit(function(d){
    var id = $('.editBook #edit_data').find('#id').val();
    d.preventDefault();
    $.ajax({
      type : 'PATCH',
      url : 'http://localhost:3000/books/' + id,
      dataType : 'json',
      data : $('.editBook #edit_data').serialize(),
      success: function(response) 
      {
        window.location.reload();
      },
      error: function(textStatus) 
      {
        console.log(textStatus.responseText);
      }
    });
  });
  $('#addBook').click(function(){
    $('.addBook').css('display', 'inline-block');
  });
});


function del(id)
{
  $(this).on("click", function(){
    $.ajax({
      type: "DELETE",
      dataType: 'json',
      url: "http://localhost:3000/books/" + id,
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
    $('.editBook').css('display', 'inline-block');
    $.ajax({
      type: "GET",
      dataType: 'json',
      url: "http://localhost:3000/books/" + id,
    })
    .done(function(data) 
    {
      $('#edit_data input[id=id]').val(data.book.id);
      $('#edit_data input[id=name]').val(data.book.name);
      $('#edit_data input[id=author]').val(data.book.author);
      $('#edit_data input[id=price]').val(data.book.price);
      $('#edit_data input[id=publication]').val(data.book.publication);
      $('#edit_data input[id=isbn]').val(data.book.isbn);
      $('#edit_data input[id=version]').val(data.book.version);
      $('#edit_data input[id=no_of_copies]').val(data.book.no_of_copies);
      $('#edit_data input[id=library_id]').val(data.book.library_id);
      $('#edit_data input[id=category_id]').val(data.book.category_id);
    })
  });
}