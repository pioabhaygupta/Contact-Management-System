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
      <div class="container">
        <div class="row">
         <div class="col-md-12">
           <div class="card">
             <div class="card-body text-center ml-5 mr-5">
               <h3 class="mb-3">Change Password <h3>
               <!--Alert Message -->
                 <div>
                   <c:if test="${not empty sessionScope.message}">
                     <div class="alert ${sessionScope.message.type} text-center" role="alert">
                       <p>${sessionScope.message.content}</p>
                       <c:remove var="message" scope="session" />
                     </div>
                   </c:if>
                 </div>
               <form action="/user/process-password" method="POST">

                 <!-- old password-->
                 <div class="mb-3 form-group">
                   <input type="password" name="oldPassword" class="form-control"
                   id="password_field"  placeholder="Enter old password" />
                 </div>

                 <!-- new password-->
                 <div class="mb-3 form-group">
                   <input type="password" name="newPassword" class="form-control"
                   id="password_field"  placeholder="Enter new password" />
                 </div>

                 <div class="container text-center">
                   <button type="submit" class="btn btn-success btn-sm">Change</button>
                   <button type="reset" class="btn btn-info btn-sm">Reset</button>
                 </div>

               </form>

             <div>
           </div>
         </div>
        </div>
      </div>
    </div>

    <script>
      $(document).ready(() =>{
        $(".item").removeClass("active");
        $("#pass-link").addClass("active");
      });
    </script>

  </body>
</html>
