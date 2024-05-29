<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/normal/base.jsp" %>
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title></title>
  </head>
  <body>
    <div class="content mt-5">
      <i onclick="toggleSidebar()" id="menu" class="material-symbols-outlined mt-2">menu </i>
      <h1>Welcome!</h1>
      <h2>User Name: <span>${user.name} </span> </h2>
      <h2>User Email: <span>${user.email} </span> </h2>
      <h2>User Password: <span>${user.password} </span> </h2>
      <h2>User Role: <span>${user.role} </span> </h2>
      <h2>User Contact List: <span>${user.contacts} </span> </h2>
      <h2>User About: <span>${user.about} </span> </h2>
    </div>
  </body>
</html>
