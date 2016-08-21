<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.sql.*, javax.sql.*, java.util.*" %>
<%

String b4=request.getParameter("title");
String b5=request.getParameter("category");
String b6=request.getParameter("textAreaContent");
b4= new String(b4.getBytes("8859_1"), "utf-8");
b5= new String(b5.getBytes("8859_1"), "utf-8");
b6= new String(b6.getBytes("8859_1"), "utf-8");
out.println(b4);
out.println(b5);
out.println(b6);

%>