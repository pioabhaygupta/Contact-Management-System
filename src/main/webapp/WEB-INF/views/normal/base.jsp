<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <title>${title}</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20,300,0,0" />    <style> <%@include file="/WEB-INF/static/css/user_dashboard.css"%> </style>
  </head>
  <body>

    <!--navbar -->
    <nav class="fixed-top navbar navbar-expand-lg navbar-dark bg-dark">
      <div class="container-fluid">
        <button class="navbar-toggler" type="button"
        data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo03"
         aria-controls="navbarTogglerDemo03" aria-expanded="false"
         aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <a class="navbar-brand" href="#">Smart Contact Manager</a>
        <div class="collapse navbar-collapse" id="navbarTogglerDemo03">
          <ul class="navbar-nav ml-auto mb-2 mb-lg-0 text-uppercase">
            <li class="nav-item">
              <a class="nav-link active" aria-current="page" href="/">Home</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active" href="#">${user.name}</a>
            </li>
             <li class="nav-item">
              <a class="nav-link active" href="/logout">Logout</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>
    <!--End of navbar -->

    <!--Start of the sidebar -->
    <div class="sidebar mt-2">

      <span onclick="toggleSidebar()" class="crossBtn">&times;</span>
      <a href="/user/dashboard" class="item" id='item1'>
        <span id="icon" class="material-symbols-outlined">home</span>
        Home</a>
      <a href="/user/show-contacts/0" class="item">View Contacts</a>
      <a href="/user/add-contact" class="item">Add Contact</a>
      <a href="#" class="item">Your Profile</a>
      <a href="#" class="item">Setting</a>
      <a href="#" class="item">Logout</a>
      <div class="divider"></div>
    </div>
    <!--End of the sidebar -->


    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
    integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js"
    integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js"
    integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <script>
      const toggleSidebar = () => {
        if($(".sidebar").is(":visible")){
          $(".sidebar").css("display", "none");
          $(".content").css("margin-left", "0%");
        }else{
          $(".sidebar").css("display", "block");
          $(".content").css("margin-left", "20%");
        }
      }
    </script>

    <script>
      function deleteContact(id){
        swal({
          title: "Are you sure?",
          text: "You want to delete this contact!",
          icon: "warning",
          buttons: true,
          dangerMode: true,
        })
        .then((willDelete) => {
          if (willDelete) {
            window.location="/user/delete/"+id;
          } else {
            swal("Your contact is safe!");
          }
        });
      }
    </script>
  </body>
</html>