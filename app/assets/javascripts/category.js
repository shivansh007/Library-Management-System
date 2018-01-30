var Category = Category || {};
Category.all = function(){
  this.initialize();
}
Category.all.prototype = {
  initialize:function(){
    this.getAllCategories();
    this.createCategoryFormAction();
    this.editCategoryFormAction();
    this.categoryModalActions();
    this.del();
    this.edit();
  },
  getAllCategories:function(){
    $.ajax({
      type: "GET",
      dataType: 'json',
      async: false,
      url: "http://localhost:3000/categories"
    })
    .done(function(data) 
    {
      for (var i = 0; i < data.categories.length ; i++) 
      {
        var temp = $("#categories #template").first().clone();
        temp.removeAttr('hidden');
        temp.find("#name").html(data.categories[i].name);
        temp.find("#delete").html("<button id = '" + data.categories[i].id + "' class = 'button delete'>Delete</button>");
        temp.find("#edit").html("<button id = '" + data.categories[i].id + "' class = 'button edit'>Edit</button>");
        $("#categories .content").append(temp);
      }
    })
    .fail(function(textStatus) 
    {
      console.log(textStatus);
    });
  },
  createCategoryFormAction:function(){
    $('#categories .add_form #add_data').submit(function(e){
      e.preventDefault();
      $.ajax({
        type : 'POST',
        url : 'http://localhost:3000/categories',
        dataType : 'json',
        data : $('#categories .add_form #add_data').serialize(),
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
  editCategoryFormAction:function(){
    $('#categories .edit_form #edit_data').submit(function(d){
      var id = $('#categories .edit_form #edit_data').find('#id').val();
      d.preventDefault();
      $.ajax({
        type : 'PATCH',
        url : 'http://localhost:3000/categories/' + id,
        dataType : 'json',
        data : $('#categories .edit_form #edit_data').serialize(),
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
  categoryModalActions:function(){
    $('#categories #create_category').click(function(){
      $('#categories .add_form').css('display', 'inline-block');
    });
    $(window).click(function(event)
    {
      if($(event.target).hasClass('modal')) 
      {
        $('#categories .add_form').css('display', 'none');
        $('#categories .edit_form').css('display', 'none');
      }
    });
    $("#categories .add_form #cross").click(function(event)
    {
      $('#categories .add_form').css('display', 'none');
    });
    $("#categories .edit_form #cross").click(function(event)
    {
      $('#categories .edit_form').css('display', 'none');
    });
  },
  del:function(){
    $('#categories .delete').on("click", function(){
      $.ajax({
        type: "DELETE",
        dataType: 'json',
        url: "http://localhost:3000/categories/" + $(this).attr('id'),
      })
      .done(function(data) 
      {
        alert("Deleted");
        window.location.reload();
      })
    });
  },
  edit:function(){
    $('#categories .edit').on("click", function(){
      $('.edit_form').css('display', 'inline-block');
      $.ajax({
        type: "GET",
        dataType: 'json',
        url: "http://localhost:3000/categories/" + $(this).attr('id'),
        async: true
      })
      .done(function(data) 
      {
        $('#categories #edit_data input[id=id]').val(data.category.id);
        $('#categories #edit_data input[id=name]').val(data.category.name);
      })
    });
  }
}
