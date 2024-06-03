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
              <img  class="contact-profile-picture mt-1" src="data:image/jpg;base64,${user.imageUrl}" />
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
      <div>
        <span onclick="toggleSidebar()" class="crossBtn">&times;</span>
      </div>
      <a href="/user/dashboard" class="item active" id="home-link">Home</a>
      <a href="/user/show-contacts/0" id="view-link" class="item">View Contacts</a>
      <a href="/user/add-contact" id="add-link" class="item">Add Contact</a>
      <a href="/user/profile" id="profile-link" class="item">Your Profile</a>
      <a href="#" id="setting-link" class="item" onclick="toggleSettingDropdown()">Setting</a>
      <ul id="setting-dropdown" style="display: none;">
        <li><a href="/user/edit-profile" class="item">Edit Profile</a></li>
        <li><a href="/user/change-password" class="item">Change Password</a></li>
      </ul>
      <a href="/logout" id="logout-link" class="item">Logout</a>
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
      const toggleSidebar = () => {
        if($(".sidebar").is(":visible")){
          $(".sidebar").css("display", "none");
          $(".content").css("margin-left", "0%");
        }else{
          $(".sidebar").css("display", "block");
          $(".content").css("margin-left", "18%");
        }
      }

      const toggleSidebarForDashboard = () => {
        if($(".sidebar").is(":visible")){
          $(".sidebar").css("display", "none");
          $(".content").css("margin-left", "0%");

        }else{
          $(".sidebar").css("display", "block");
          $(".content").css("margin-left", "18%");
        }
      }


      function toggleSettingDropdown() {
          const dropdown = document.getElementById("setting-dropdown");

          if (dropdown.style.display === "none") {
            dropdown.style.display = "block";
             $(".item").removeClass("active");
             $("#setting-link").addClass("active");
          }
        }

    </script>

    <script type="text/javascript">
          $(document).ready(function(){
            $("#search-input").on("keyup",function(){
              var query = $(this).val();
              if(query.length > 0) {
                $.ajax({
                  url: '/search',
                  method: 'GET',
                  data: { query: query},
                  dataType: 'json',
                  success: function(data) {
                    var resultHtml = "<div class='list-group'>";
                    $.each(data, function(index, contact){
                      var contactUrl = '/user/' + contact.id + '/contact';
                      resultHtml += "<a href='" + contactUrl + "' class='list-group-item list-group-item-action'>" + contact.name + "</a>";

                    });
                    resultHtml+="</div>";
                    $("#search-result").html(resultHtml);
                  }
                });
              }else {
                $("#search-result").empty();
              }
            });
          });
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