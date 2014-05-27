// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function constrain(unsplit_str, front_half, back_half, ideal_width, className, element_width)
{
	var text = unsplit_str;
  var temp_item = ('<span class="'+className+'_hide" style="display:none;">'+ text +'</span>');
  $(temp_item).appendTo('body');
  var item_width = $('span.'+className+'_hide').width();
  var ideal = parseInt(ideal_width);
  var smaller_text = text;
  var front_half1 = front_half;
  var back_half1 = back_half;

  if (item_width>ideal_width)
  {
    while (item_width > ideal)
    {
    	front_half1 = front_half1.substr(0, (front_half1.length-1));
    	back_half1 = back_half1.substr(1);
      smaller_text = front_half1 + ".." + back_half1;
      $('.'+className+'_hide').html(smaller_text);
      item_width = $('span.'+className+'_hide').width();
    }
    smaller_text = smaller_text;
    return_text = smaller_text;
  }
	$('span.'+className+'_hide').remove();
	return(smaller_text);
}


function trim_string(str_in, id)
{
	var truncate_length = (window.innerWidth/12.5);
	var str = String(str_in);

	var element_width = document.getElementById("filename"+id).offsetWidth + 30;
	$("#filename"+id).html(constrain(str_in,
		str_in.substr(0, str_in.length / 2), str_in.substr(str_in.length / 2), element_width, "spec1"));
	return;

	if (truncate_length > 10)
	{
		truncate_length = 130;
	}

	if (str.length > truncate_length)
	{
		str_front = str.substr(0, ((truncate_length/2) - 2));
		str_back = str.substr(str.length - ((truncate_length/2) - 1));
		$("#filename"+id).html(str_front + "..." + str_back);
	}
	else
	{
		$("#filename"+id).html(str);
	}
}

function set_detail(filename, id)
{
	$("#filename_detail").html(filename);
}

function handleVisibilityChange()
{
	reload_with_rows_set();
}

function detect_visibility_capability()
{
	var visibilityChangeEventName = "visibilitychange";

	if (document.webkitHidden!=undefined) {
		visibilityChangeEventName = "webkitvisibilitychange";
	} else if (document.mozHidden!=undefined) {
		visibilityChangeEventName = "mozvisibilitychange";
	} else if (document.msHidden!=undefined) {
		visibilityChangeEventName = "msvisibilitychange";
	} else if (document.hidden!=undefined) {
		visibilityChangeEventName = "visibilitychange";
	} else {
		visibilityChangeEventName = "notAvailable";
		return;
	}
	document.addEventListener(visibilityChangeEventName, handleVisibilityChange, false);
}

function getQuerystringNameValue(name)
{
    var winURL = document.location.search;
    var queryStringParamArray = winURL.split("&");
    var nameValue = null;

    for ( var i=0; i<queryStringParamArray.length; i++ )
    {           
        queryStringNameValueArray = queryStringParamArray[i].split("=");

        if ( name == queryStringNameValueArray[0] )
        {
            nameValue = queryStringNameValueArray[1];
        }                       
    }

    return nameValue;
}

function detect_mobile() { 
 if( navigator.userAgent.match(/Android/i)
 || navigator.userAgent.match(/webOS/i)
 || navigator.userAgent.match(/iPhone/i)
 || navigator.userAgent.match(/iPad/i)
 || navigator.userAgent.match(/iPod/i)
 || navigator.userAgent.match(/BlackBerry/i)
 || navigator.userAgent.match(/Windows Phone/i)
 ){
    return true;
  }
 else {
    return false;
  }
}

detect_visibility_capability();

function reload_with_rows_set()
{
	url = "";

	if ((disk = getQuerystringNameValue("disk")) == null)
	{
		url = url + "?disk=All";
	}
	else
	{
		url = url + "?disk=" + disk;
	}
	if ((filename = getQuerystringNameValue("filename")) == null)
	{
		url = url + "&filename=";
	}
	else
	{
		url = url + "&filename=" + filename;
	}
	if ((page_number = getQuerystringNameValue("page_number")) == null)
	{
		url = url + "&page_number=0";
	}
	else
	{
		url = url + "&page_number=" + page_number;
	}
	url = url + "&records_per_page=" + Math.round(window.innerHeight/37);
	window.location = url;
}

window.onresize = function()
{
	if (!detect_mobile())
	{
		reload_with_rows_set();
	}
}

$( window ).on( "orientationchange", function( event ) {
  reload_with_rows_set();
});

if (document.location.search == "")
{
	reload_with_rows_set();
}





