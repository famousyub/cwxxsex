var xmlhttp
function ConnectToNet(url)
{
    xmlhttp=null;
    try {
        netscape.security.PrivilegeManager.enablePrivilege("UniversalBrowserRead");
    } catch (e) {

    //For IE it comes here.
    //alert("Permission UniversalBrowserRead denied.");
   }
    // code for Mozilla, etc.
    if (window.XMLHttpRequest){
        xmlhttp=new XMLHttpRequest()
    }
    // code for IE
    else if (window.ActiveXObject){
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP")
    }
    if (xmlhttp!=null){
        xmlhttp.onreadystatechange=state_Change
        xmlhttp.open("GET",url,true)
        xmlhttp.send(null)
    }
    else{
        alert("Your browser does not support XMLHTTP.")
    }
}

function state_Change()
{
    // if xmlhttp shows "loaded"
    if (xmlhttp.readyState==4){
        try{
              // if "OK"
            if (xmlhttp.status==200){
            var objDiv = document.getElementById('div1');
            objDiv.innerHTML = "<font color=blue>Internet is connected.</font>";
            alert("Internet is Connected.");
            return;
        }
          else{
            alert("Problem retrieving XML data")
        }
    } catch(err){
        var objDiv = document.getElementById('div1');
        objDiv.innerHTML += "<font color=red>Internet is not connected.<br/></font>";
        setTimeout("ConnectToNet('http://www.google.com')",20000);
    }
  }
}


$(function() {
    let isMobile = window.matchMedia("only screen and (max-width: 760px)").matches;

    if (isMobile) {
        //Conditional script here
    }
 });

 if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
 // some code..
}
