$("document").ready(function()
{
	$.ajax({
		type: "GET",
		dataType: 'json',
		url: "http://localhost:3000/libraries"
	})
	.done(function(data) 
	{
		for (var i = data.libraries.length - 1; i >= 0; i--) 
		{
			var temp = $("#template").clone();
			temp.removeAttr('hidden');
			temp.find("#name").html(data.libraries[i].name);
			temp.find("#address").append(data.libraries[i].address);
			temp.find("#phone").append(data.libraries[i].phone);
			temp.find("#delete").html("<button onclick = 'del(" + data.libraries[i].id + ");' class = 'button delete'>Delete</button>");
			temp.find("#edit").html("<button onclick = 'edit(" + data.libraries[i].id + ");' class = 'button edit'>Edit</button>");
			$(".content").append(temp);
		}
	})
	.fail(function(textStatus) 
	{
		console.log(textStatus);
	});

	$('.add_form #add_data').submit(function(e){
		e.preventDefault();
		$.ajax({
			type : 'POST',
			url : 'http://localhost:3000/libraries',
			dataType : 'json',
			data : $('.add_form #add_data').serialize(),
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
	$('.edit_form #edit_data').submit(function(d){
		var id = $('.edit_form #edit_data').find('#id').val();
		d.preventDefault();
		$.ajax({
			type : 'PATCH',
			url : 'http://localhost:3000/libraries/' + id,
			dataType : 'json',
			data : $('.edit_form #edit_data').serialize(),
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
	$('#create_library').click(function(){
		$('.add_form').css('display', 'inline-block');
	});
	$(window).click(function(event)
	{
		if($(event.target).hasClass('modal')) 
		{
			$('.add_form').css('display', 'none');
			$('.edit_form').css('display', 'none');
		}
	});
	$(".add_form #cross").click(function(event)
	{
		$('.add_form').css('display', 'none');
	});
	$(".edit_form #cross").click(function(event)
	{
		$('.edit_form').css('display', 'none');
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
	$('.edit_form').css('display', 'inline-block');
	$(this).on("click", function(){
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