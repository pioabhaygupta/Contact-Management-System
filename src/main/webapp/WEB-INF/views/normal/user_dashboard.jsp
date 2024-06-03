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
    <div class="content mt-5" id="content">
      <i onclick="toggleSidebar()" id="menu" class="material-symbols-outlined mt-2 text-white">menu </i>

      <div class="container dashboard">
        <div class="card cr">
          <div class="card-body  text-center my-5">
            <img style="height: 180px; width: 180px;" class="contact-profile-picture "
            src="https://images.squarespace-cdn.com/content/v1/65146d89d360e20acd1e4b0e/cff26aef-9c4e-4386-bef6-70e0be376cdf/User.png" />
            <h1 class="mt-3 mb-3 text-center font-italic font-weight-light"><span>Start Adding your Contact....</span></h1>
            <a href="/user/add-contact">
              <button class="btn btn-primary btn-block text-uppercase mt-4">Add New Contact</button>
            </a>
          </div>
        </div>
      </div>
       <script>
         $(document).ready(() =>{
           $(".item").removeClass("active");
           $("#home-link").addClass("active");
         });
      </script>
    </div>
  </body>
</html>
