var Member = Member || {};
Member.all = function(){
  this.initialize();
}
Member.all.prototype = {
  initialize:function(){
    this.getAllMembers();
    this.addLibrariesToForm();
    this.createMemberFormAction();
    this.editMemberFormAction();
    this.memberModalActions();
    this.del();
    this.edit();
  },
  getAllMembers:function(){
    $.ajax({
      type: "GET",
      dataType: 'json',
      async: false,
      url: "http://localhost:3000/members"
    })
    .done(function(data) 
    {
      for (var i = 0; i < data.members.length ; i++) 
      {
        var temp = $("#members #template").first().clone();
        temp.removeAttr('hidden');
        temp.find("#name").html(data.members[i].name);
        temp.find("#address").append(data.members[i].address);
        temp.find("#phone").append(data.members[i].phone);
        temp.find("#gender").append(data.members[i].is_male);
        temp.find("#code").append(data.members[i].code);
        temp.find("#validity_date").append(data.members[i].validity_date);
        temp.find("#is_author").append(data.members[i].is_author);
        $.ajax({
          type: "GET",
          dataType: 'json',
          url: "http://localhost:3000/libraries/" + data.members[i].library_id,
          async: false,
          success: function(data)
          {
            temp.find("#library").append(data.library.name);
          }
        });
        temp.find("#delete").html("<button id = '" + data.members[i].id + "' class = 'button delete'>Delete</button>");
        temp.find("#edit").html("<button id = '" + data.members[i].id + "' class = 'button edit'>Edit</button>");
        $("#members .content").append(temp);
      }
    })
    .fail(function(textStatus) 
    {
      console.log(textStatus);
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
          $('#members .add_form #library_id').append("<option value = '"+data.libraries[i].id+"'>"+data.libraries[i].name+"</option>");
          $('#members .edit_form #library_id').append("<option value = '"+data.libraries[i].id+"'>"+data.libraries[i].name+"</option>");
        }
      }
    });
  },
  createMemberFormAction:function(){
    $('#members .add_form #add_data').submit(function(e){
      e.preventDefault();
      $.ajax({
        type : 'POST',
        url : 'http://localhost:3000/members',
        dataType : 'json',
        data : $('#members .add_form #add_data').serialize(),
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
  editMemberFormAction:function(){
    $('#members .edit_form #edit_data').submit(function(d){
      var id = $('#members .edit_form #edit_data').find('#id').val();
      d.preventDefault();
      $.ajax({
        type : 'PATCH',
        url : 'http://localhost:3000/members/' + id,
        dataType : 'json',
        data : $('#members .edit_form #edit_data').serialize(),
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
  memberModalActions:function(){
    $('#members #create_member').click(function(){
      $('#members .add_form').css('display', 'inline-block');
    });
    $(window).click(function(event)
    {
      if($(event.target).hasClass('modal')) 
      {
        $('#members .add_form').css('display', 'none');
        $('#members .edit_form').css('display', 'none');
      }
    });
    $("#members .add_form #cross").click(function(event)
    {
      $('#members .add_form').css('display', 'none');
    });
    $("#members .edit_form #cross").click(function(event)
    {
      $('#members .edit_form').css('display', 'none');
    });
  },
  del:function(){
    $('#members .delete').on("click", function(){
      $.ajax({
        type: "DELETE",
        dataType: 'json',
        url: "http://localhost:3000/members/" + $(this).attr('id'),
      })
      .done(function(data) 
      {
        alert("Deleted");
        window.location.reload();
      })
    });
  },
  edit:function(){
    $('#members .edit').on("click", function(){
      $('.edit_form').css('display', 'inline-block');
      $.ajax({
        type: "GET",
        dataType: 'json',
        url: "http://localhost:3000/members/" + $(this).attr('id'),
        async: true
      })
      .done(function(data) 
      {
        $('#members #edit_data input[id=id]').val(data.member.id);
        $('#members #edit_data input[id=name]').val(data.member.name);
        $('#members #edit_data input[id=address]').val(data.member.address);
        $('#members #edit_data input[id=phone]').val(data.member.phone);
        $('#members #edit_data input[id=is_male]').val(data.member.is_male);
        $('#members #edit_data input[id=code]').val(data.member.code);
        $('#members #edit_data input[id=validity_date]').val(data.member.validity_date);
        $('#members #edit_data input[id=is_author]').val(data.member.is_author);
        $('#members #edit_data select option[value="'+data.member.library_id+'"]').attr("selected",true);
      })
    });
  }
}
