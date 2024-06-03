<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/normal/base.jsp" %>
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>${title}</title>
  </head>
  <body>
    <div class="content mt-5">
      <i onclick="toggleSidebar()" id="menu" class="material-symbols-outlined mt-2">menu </i>

      <div class="container ">
        <div class="card">
          <div class="card-body text-center">
            <img style="height: 180px; width: 180px;" class="contact-profile-picture " src="data:image/jpg;base64,${user.imageUrl}" />
            <h2 class="mt-3 mb-3 "><span>${user.name}</span></h2>
            <table class="table text-center">
              <thead>
                <tr>
                  <th scope="col">#USERID</th>
                  <th scope="col">SCM${user.id}</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <th scope="row">Email</th>
                  <td>${user.email}</td>
                </tr>

                <tr>
                  <th scope="row">Role</th>
                  <td>${user.role}</td>
                </tr>

                <tr>
                  <th scope="row">Account Active</th>
                  <td>${user.enabled}</td>
                </tr>

                <tr>
                  <th scope="row">About</th>
                  <td>${user.about}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

      </div>
      <script>
        $(document).ready(() =>{
          $(".item").removeClass("active");
          $("#profile-link").addClass("active");
        });
      </script>
    </div>
  </body>
</html>
