var Library = Library || {};
Library.all = function(){
  this.initialize();
}
Library.all.prototype = {
  initialize:function(){
    this.getAllLibraries();
    this.createLibraryFormAction();
    this.editLibraryFormAction();
    this.libraryModalActions();
    this.del();
    this.edit();
  },
  getAllLibraries:function(){
    $.ajax({
      type: "GET",
      dataType: 'json',
      async: false,
      url: "http://localhost:3000/libraries"
    })
    .done(function(data) 
    {
      for (var i = 0; i < data.libraries.length ; i++) 
      {
        var temp = $("#libraries #template").first().clone();
        temp.removeAttr('hidden');
        temp.find("#name").html(data.libraries[i].name);
        temp.find("#address").append(data.libraries[i].address);
        temp.find("#phone").append(data.libraries[i].phone);
        temp.find("#delete").html("<button id = '" + data.libraries[i].id + "' class = 'button delete'>Delete</button>");
        temp.find("#edit").html("<button id = '" + data.libraries[i].id + "' class = 'button edit'>Edit</button>");
        $("#libraries .content").append(temp);
      }
    })
    .fail(function(textStatus) 
    {
      console.log(textStatus);
    });
  },
  createLibraryFormAction:function(){
    $('#libraries .add_form #add_data').submit(function(e){
      e.preventDefault();
      $.ajax({
        type : 'POST',
        url : 'http://localhost:3000/libraries',
        dataType : 'json',
        data : $('#libraries .add_form #add_data').serialize(),
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
  editLibraryFormAction:function(){
    $('#libraries .edit_form #edit_data').submit(function(d){
      var id = $('#libraries .edit_form #edit_data').find('#id').val();
      d.preventDefault();
      $.ajax({
        type : 'PATCH',
        url : 'http://localhost:3000/libraries/' + id,
        dataType : 'json',
        data : $('#libraries .edit_form #edit_data').serialize(),
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
  libraryModalActions:function(){
    $('#libraries #create_library').click(function(){
      $('#libraries .add_form').css('display', 'inline-block');
    });
    $(window).click(function(event)
    {
      if($(event.target).hasClass('modal')) 
      {
        $('#libraries .add_form').css('display', 'none');
        $('#libraries .edit_form').css('display', 'none');
      }
    });
    $("#libraries .add_form #cross").click(function(event)
    {
      $('#libraries .add_form').css('display', 'none');
    });
    $("#libraries .edit_form #cross").click(function(event)
    {
      $('#libraries .edit_form').css('display', 'none');
    });
  },
  del:function(){
    $('#libraries .delete').on("click", function(){
      $.ajax({
        type: "DELETE",
        dataType: 'json',
        url: "http://localhost:3000/libraries/" + $(this).attr('id'),
      })
      .done(function(data) 
      {
        alert("Deleted");
        window.location.reload();
      })
    });
  },
  edit:function(){
    $('#libraries .edit').on("click", function(){
      $('.edit_form').css('display', 'inline-block');
      $.ajax({
        type: "GET",
        dataType: 'json',
        url: "http://localhost:3000/libraries/" + $(this).attr('id'),
        async: true
      })
      .done(function(data) 
      {
        $('#libraries #edit_data input[id=id]').val(data.library.id);
        $('#libraries #edit_data input[id=name]').val(data.library.name);
        $('#libraries #edit_data input[id=address]').val(data.library.address);
        $('#libraries #edit_data input[id=phone]').val(data.library.phone);
      })
    });
  }
}
