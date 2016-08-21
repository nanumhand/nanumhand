<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.*"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<%

  request.setCharacterEncoding("utf-8");
  String return1="";
  String return2="";
  String return3="";
  String name = "";
  if (ServletFileUpload.isMultipartContent(request)){
    ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());

    //UTF-8 ���ڵ� ����

    uploadHandler.setHeaderEncoding("UTF-8");
    List<FileItem> items = uploadHandler.parseRequest(request);

    //�� �ʵ��±׵��� FOR���� �̿��Ͽ� �񱳸� �մϴ�.

    for (FileItem item : items) {
      if(item.getFieldName().equals("callback")) {
        return1 = item.getString("UTF-8");
      } else if(item.getFieldName().equals("callback_func")) {
        return2 = "?callback_func="+item.getString("UTF-8");
      } else if(item.getFieldName().equals("Filedata")) {

        //FILE �±װ� 1���̻��� ���

        if(item.getSize() > 0) {
          name = item.getName();
          String ext = item.getName().substring(item.getName().lastIndexOf(".")+1);

          //���� �⺻���

          String defaultPath = request.getServletContext().getRealPath("/");

          //���� �⺻��� _ �󼼰��

          String path = defaultPath + "img" + File.separator;
		  File file = new File(path);
                 

          //���丮 �������� ������� ���丮 ����

          if(!file.exists()) {
            file.mkdirs();
          }

          //������ ���ε� �� ���ϸ�(�ѱ۹����� ���� ���������� �ø��� �ʴ°��� ����)

          String realname = UUID.randomUUID().toString() + "." + ext;

          ///////////////// ������ ���Ͼ��� ///////////////// 

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

          ///////////////// ������ ���Ͼ��� /////////////////

          String root = request.getContextPath();
          return3 += "&bNewLine=true&sFileName="+name+"&sFileURL=" + defaultPath + "img/"+realname;
        }else {
          return3 += "&errstr=error";
        }
      }
    }
  }
  response.sendRedirect(return1+return2+return3);

%>


