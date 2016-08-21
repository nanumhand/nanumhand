<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.sql.*, javax.sql.*, javax.servlet.*" %>
<%
session.setAttribute("user_id", null);
session.setAttribute("seq_user", null);
session.invalidate();
response.sendRedirect("/lamda/index.jsp");

%>