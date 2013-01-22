function toggle_sidebar() {
	if($('#sidebar-links').css('display') == "none")
	{
		$('#sidebar').css('width','250px');
		$('#sidebar-links').toggle();
		$('#sidebar-arrows').html("&raquo;");
	}
	else
	{
		$('#sidebar').css('width','20px');
		$('#sidebar-links').toggle();
		$('#sidebar-arrows').html("&laquo;");
	}
}

function make_toc() {
	$("body").append('<div id="sidebar"><a onClick="toggle_sidebar();" id="sidebar-arrows">&laquo;</a><div id="sidebar-links"><ul id="sidebar-links-ul"></ul></div></div>');
	
	$("h2,h3").each(function(i) {
		var current = $(this);
		current.attr("id", "title" + i);
		var dispstr = "";
		if(current.prop("tagName") == "H2")
			dipstr = "<strong>" + current.html() +"</strong>";
		else
			dipstr = current.html();
			
		$("#sidebar-links-ul").append("<li><a id='link" + i + "' href='#title" + i + "' title='" + current.html() + "'>" + dipstr + "</a></li>");
	});
}

if(typeof auto_load_toc == "undefined" || auto_load_toc)
	$(document).ready(function() {make_toc();});
