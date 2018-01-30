var IssueHistory = IssueHistory || {};
IssueHistory.all = function(){
  this.initialize();
}
IssueHistory.all.prototype = {
  initialize:function(){
    this.getAllIssueHistories();
    this.createIssueHistoryFormAction();
    this.editIssueHistoryFormAction();
    this.issueHistoryModalActions();
    this.del();
    this.edit();
  },
  getAllIssueHistories:function(){
    $.ajax({
      type: "GET",
      dataType: 'json',
      async: false,
      url: "http://localhost:3000/issue_histories"
    })
    .done(function(data) 
    {
      for (var i = 0; i < data.issue_histories.length ; i++) 
      {
        var temp = $("#issue_histories #template").first().clone();
        temp.removeAttr('hidden');
        temp.find("#member").append(data.issue_histories[i].member_id);
        temp.find("#book").append(data.issue_histories[i].book_id);
        temp.find("#type").append(data.issue_histories[i].issue_type);
        temp.find("#issue_date").append(data.issue_histories[i].issue_date);
        temp.find("#return_date").append(data.issue_histories[i].return_date);
        temp.find("#delete").html("<button id = '" + data.issue_histories[i].id + "' class = 'button delete'>Delete</button>");
        temp.find("#edit").html("<button id = '" + data.issue_histories[i].id + "' class = 'button edit'>Edit</button>");
        $("#issue_histories .content").append(temp);
      }
    })
    .fail(function(textStatus) 
    {
      console.log(textStatus);
    });
  },
  createIssueHistoryFormAction:function(){
    $('#issue_histories .add_form #add_data').submit(function(e){
      e.preventDefault();
      $.ajax({
        type : 'POST',
        url : 'http://localhost:3000/issue_histories',
        dataType : 'json',
        data : $('#issue_histories .add_form #add_data').serialize(),
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
  editIssueHistoryFormAction:function(){
    $('#issue_histories .edit_form #edit_data').submit(function(d){
      var id = $('#issue_histories .edit_form #edit_data').find('#id').val();
      d.preventDefault();
      $.ajax({
        type : 'PATCH',
        url : 'http://localhost:3000/issue_histories/' + id,
        dataType : 'json',
        data : $('#issue_histories .edit_form #edit_data').serialize(),
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
  issueHistoryModalActions:function(){
    $('#issue_histories #create_issue_history').click(function(){
      $('#issue_histories .add_form').css('display', 'inline-block');
    });
    $(window).click(function(event)
    {
      if($(event.target).hasClass('modal')) 
      {
        $('#issue_histories .add_form').css('display', 'none');
        $('#issue_histories .edit_form').css('display', 'none');
      }
    });
    $("#issue_histories .add_form #cross").click(function(event)
    {
      $('#issue_histories .add_form').css('display', 'none');
    });
    $("#issue_histories .edit_form #cross").click(function(event)
    {
      $('#issue_histories .edit_form').css('display', 'none');
    });
  },
  del:function(){
    $('#issue_histories .delete').on("click", function(){
      $.ajax({
        type: "DELETE",
        dataType: 'json',
        url: "http://localhost:3000/issue_histories/" + $(this).attr('id'),
      })
      .done(function(data) 
      {
        alert("Deleted");
        window.location.reload();
      })
    });
  },
  edit:function(){
    $('#issue_histories .edit').on("click", function(){
      $('.edit_form').css('display', 'inline-block');
      $.ajax({
        type: "GET",
        dataType: 'json',
        url: "http://localhost:3000/issue_histories/" + $(this).attr('id'),
        async: true
      })
      .done(function(data) 
      {
        $('#issue_histories #edit_data input[id=id]').val(data.issue_history.id);
        $('#issue_histories #edit_data input[id=member_id]').val(data.issue_history.member_id);
        $('#issue_histories #edit_data input[id=book_id]').val(data.issue_history.book_id);
        $('#issue_histories #edit_data input[id=issue_type]').val(data.issue_history.issue_type);
        $('#issue_histories #edit_data input[id=issue_date]').val(data.issue_history.issue_date);
        $('#issue_histories #edit_data input[id=return_date]').val(data.issue_history.return_date);
      })
    });
  }
}
