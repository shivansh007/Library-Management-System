var Book = Book || {};
Book.all = function(){
  this.initialize();
}
Book.all.prototype = {
  initialize:function(){
    this.getAllBooks();
    this.addCategoriesToForm();
    this.addLibrariesToForm();
    this.createBookFormAction();
    this.editBookFormAction();
    this.bookModalActions();
    this.del();
    this.edit();
  },
  getAllBooks:function(){
    $.ajax({
      type: "GET",
      dataType: 'json',
      async: false,
      url: "http://localhost:3000/books"
    })
    .done(function(data) 
    {
      for (var i = 0; i < data.books.length ; i++) 
      {
        var temp = $("#books #template").first().clone();
        temp.removeAttr('hidden');
        temp.find("#name").html(data.books[i].name);
        temp.find("#author").append(data.books[i].author);
        temp.find("#price").append(data.books[i].price);
        temp.find("#copies").append(data.books[i].no_of_copies);
        temp.find("#isbn").append(data.books[i].isbn);
        temp.find("#publication").append(data.books[i].publication);
        temp.find("#version").append(data.books[i].version);
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
        $.ajax({
          type: "GET",
          dataType: 'json',
          url: "http://localhost:3000/libraries/" + data.books[i].library_id,
          async: false,
          success: function(data)
          {
            temp.find("#library").append(data.library.name);
          }
        });
        temp.find("#delete").html("<button id = '" + data.books[i].id + "' class = 'button delete'>Delete</button>");
        temp.find("#edit").html("<button id = '" + data.books[i].id + "' class = 'button edit'>Edit</button>");
        $("#books .content").append(temp);
      }
    })
    .fail(function(textStatus) 
    {
      console.log(textStatus);
    });
  },
  addCategoriesToForm:function(){
    $.ajax({
      type: "GET",
      dataType: 'json',
      url: "http://localhost:3000/categories/",
      async: false,
      success: function(data)
      {
        for (var i = data.categories.length - 1; i >= 0; i--) 
        {
          $('#books .add_form #category_id').append("<option value = '"+data.categories[i].id+"'>"+data.categories[i].name+"</option>");
          $('#books .edit_form #category_id').append("<option value = '"+data.categories[i].id+"'>"+data.categories[i].name+"</option>");
        }
      }
    });
  },
  addLibrariesToForm:function(){
    $.ajax({
      type: "GET",
      dataType: 'json',
      url: "http://localhost:3000/libraries/",
      async: false,
      success: function(data)
      {
        for (var i = data.libraries.length - 1; i >= 0; i--) 
        {
          $('#books .add_form #library_id').append("<option value = '"+data.libraries[i].id+"'>"+data.libraries[i].name+"</option>");
          $('#books .edit_form #library_id').append("<option value = '"+data.libraries[i].id+"'>"+data.libraries[i].name+"</option>");
        }
      }
    });
  },
  createBookFormAction:function(){
    $('#books .add_form #add_data').submit(function(e){
      e.preventDefault();
      $.ajax({
        type : 'POST',
        url : 'http://localhost:3000/books',
        dataType : 'json',
        data : $('#books .add_form #add_data').serialize(),
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
  },
  editBookFormAction:function(){
    $('#books .edit_form #edit_data').submit(function(d){
      var id = $('.edit_form #edit_data').find('#id').val();
      d.preventDefault();
      $.ajax({
        type : 'PATCH',
        url : 'http://localhost:3000/books/' + id,
        dataType : 'json',
        data : $('#books .edit_form #edit_data').serialize(),
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
  },
  bookModalActions:function(){
    $('#books #create_book').click(function(){
      $('#books .add_form').css('display', 'inline-block');
    });
    $(window).click(function(event)
    {
      if($(event.target).hasClass('modal')) 
      {
        $('#books .add_form').css('display', 'none');
        $('#books .edit_form').css('display', 'none');
      }
    });
    $("#books .add_form #cross").click(function(event)
    {
      $('#books .add_form').css('display', 'none');
    });
    $("#books .edit_form #cross").click(function(event)
    {
      $('#books .edit_form').css('display', 'none');
    });
  },
  del:function(){
    $('#books .delete').on("click", function(){
      $.ajax({
        type: "DELETE",
        dataType: 'json',
        url: "http://localhost:3000/books/" + $(this).attr('id'),
      })
      .done(function(data) 
      {
        alert("Deleted");
        window.location.reload();
      })
    });
  },
  edit:function(){
    $('#books .edit').on("click", function(){
      $('.edit_form').css('display', 'inline-block');
      $.ajax({
        type: "GET",
        dataType: 'json',
        url: "http://localhost:3000/books/" + $(this).attr('id'),
        async: true
      })
      .done(function(data) 
      {
        $('#books #edit_data input[id=id]').val(data.book.id);
        $('#books #edit_data input[id=name]').val(data.book.name);
        $('#books #edit_data input[id=author]').val(data.book.author);
        $('#books #edit_data input[id=price]').val(data.book.price);
        $('#books #edit_data input[id=publication]').val(data.book.publication);
        $('#books #edit_data input[id=version]').val(data.book.version);
        $('#books #edit_data input[id=no_of_copies]').val(data.book.no_of_copies);
        $('#books #edit_data input[id=isbn]').val(data.book.isbn);
        $('#books #edit_data select option[value="'+data.book.category_id+'"]').attr("selected",true);
        $('#books #edit_data select option[value="'+data.book.library_id+'"]').attr("selected",true);
      })
    });
  }
}
