<%@page import="java.io.FileOutputStream"%>
<%@page import="java.util.UUID"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%

  request.setCharacterEncoding("utf-8");
  String return1="";
  String return2="";
  String return3="";
  String name = "";
  if (ServletFileUpload.isMultipartContent(request)){
    ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());

    //UTF-8 인코딩 설정

    uploadHandler.setHeaderEncoding("UTF-8");
    List<FileItem> items = uploadHandler.parseRequest(request);

    //각 필드태그들을 FOR문을 이용하여 비교를 합니다.

    for (FileItem item : items) {
      if(item.getFieldName().equals("callback")) {
        return1 = item.getString("UTF-8");
      } else if(item.getFieldName().equals("callback_func")) {
        return2 = "?callback_func="+item.getString("UTF-8");
      } else if(item.getFieldName().equals("Filedata")) {

        //FILE 태그가 1개이상일 경우

        if(item.getSize() > 0) {
          name = item.getName();
          String ext = item.getName().substring(item.getName().lastIndexOf(".")+1);

          //파일 기본경로

          String defaultPath = request.getServletContext().getRealPath("/");

          //파일 기본경로 _ 상세경로

          String path = defaultPath + "upload" + File.separator;
		  File file = new File(path);
                 

          //디렉토리 존재하지 않을경우 디렉토리 생성

          if(!file.exists()) {
            file.mkdirs();
          }

          //서버에 업로드 할 파일명(한글문제로 인해 원본파일은 올리지 않는것이 좋음)

          String realname = UUID.randomUUID().toString() + "." + ext;

          ///////////////// 서버에 파일쓰기 ///////////////// 

          InputStream is = item.getInputStream();
          OutputStream os=new FileOutputStream(path + realname);
          int numRead;
          byte b[] = new byte[(int)item.getSize()];
          while((numRead = is.read(b,0,b.length)) != -1){
            os.write(b,0,numRead);
          }

          if(is != null)  is.close();
          os.flush();
          os.close();

          ///////////////// 서버에 파일쓰기 /////////////////

          String root = request.getContextPath();
          return3 += "&bNewLine=true&sFileName="+name+"&sFileURL=" + root + "/upload/"+realname;
        }else {
          return3 += "&errstr=error";
        }
      }
    }
  }
  response.sendRedirect(return1+return2+return3);

%>

