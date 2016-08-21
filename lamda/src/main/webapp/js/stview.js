var $stview=
{
  iframeAddr : function (addr,width,height,dir)
  {
    var iframe="<iframe scrolling=no width="+width+" height="+height+" src='http://togosoft.com/web/streetview/getview.php?addr="+encodeURIComponent(addr)+"&width="+width+"&height="+height+"&dir="+dir+"'></iframe>";
    return iframe;
  }, 

  iframeLatLon : function (lat,lon,width,height,dir)
  {
    var iframe="<iframe scrolling=no width="+width+" height="+height+" src='http://togosoft.com/web/streetview/getview.php?lat="+lat+"&lon="+lon+"&width="+width+"&height="+height+"&dir="+dir+"'></iframe>";
    return iframe;
  },
  
  parse : function()
  {
    var objs=document.getElementsByTagName("*");
    for (i=0;i<objs.length;i++)
    {
      if ((objs[i].className == "$stview") || (objs[i].className == "$stviewLatLon"))
      {
        var width=objs[i].getAttribute("width");
        if (width == null || width == "")
        {
          width=320;
        }
        var height=objs[i].getAttribute("height");
        if (height == null || height == "")
        {
          height=240;
        }
        var dir=objs[i].getAttribute("dir");
        if (dir == null || dir == "")
        {
          dir=0;
        }
        var iframe="";
        if (objs[i].className == "$stview")
        {
          iframe=this.iframeAddr(objs[i].innerHTML,width,height,dir);
        }
        else
        {
          var latlon=objs[i].innerHTML.split(",");
          iframe=this.iframeLatLon(latlon[0],latlon[1],width,height,dir);
        }
        objs[i].innerHTML=iframe;      
      }
    }    
  } 
}   

