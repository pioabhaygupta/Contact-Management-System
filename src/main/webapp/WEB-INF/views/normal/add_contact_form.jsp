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

      <div class="card mr-5 ml-5">
        <div class="card-body">
          <h1 class="text-center">Add Contact</h1>

          <!-- Alert message -->
          <c:if test="${not empty sessionScope.message}" >
            <div class="alert ${sessionScope.message.type} text-center ml-4 mr-4" role="alert">
              <p>${sessionScope.message.content}</p>
              <c:remove var="message" scope="session"/>
            </div>
          </c:if>
          <div class="container-fluid mt-1 mr-3">
            <div class="row">
              <div class="col-md-8 offset-md-2">
                <form action="/user/process-contact"  enctype="multipart/form-data" method="post">

                  <!-- Contact Name -->
                  <div class="input-group mb-3">
                    <div class="input-group-prepend">
                      <span class="input-group-text material-symbols-outlined" id="basic-addon1">person</span>
                    </div>
                    <input type="text" name="name" required value="${contact.name}" class="form-control" placeholder="Enter Name " aria-label="Username" aria-describedby="basic-addon1">
                  </div>

                  <!--Nickname -->
                  <div class="input-group mb-3">
                    <div class="input-group-prepend">
                     <span class="input-group-text material-symbols-outlined" id="basic-addon1">person</span>
                    </div>
                    <input type="text" name="nickName"  value="${contact.nickName}" class="form-control" placeholder="Enter Nickname"  aria-describedby="basic-addon1">
                  </div>

                  <!--Email -->
                  <div class="input-group mb-3">
                    <div class="input-group-prepend">
                     <span class="input-group-text material-symbols-outlined" id="basic-addon1">mail</span>
                    </div>
                    <input type="email" name="email" required value="${contact.email}" class="form-control" placeholder="Enter Email"  aria-describedby="basic-addon1">
                  </div>

                  <!--Phone -->
                  <div class="input-group mb-3">
                    <div class="input-group-prepend">
                     <span class="input-group-text material-symbols-outlined" id="basic-addon1">contacts</span>
                    </div>
                    <input type="text" name="phone" min="10" max="13" value="${contact.phone}" class="form-control" placeholder="Enter Mobile Number"  aria-describedby="basic-addon1">
                  </div>

                  <!--Work-->
                  <div class="input-group mb-3">
                    <div class="input-group-prepend">
                     <span class="input-group-text material-symbols-outlined" id="basic-addon1">work_alert</span>
                    </div>
                    <input type="text" name="work"  value="${contact.work}" class="form-control" placeholder="Enter Work "  aria-describedby="basic-addon1">
                  </div>

                  <!--Description Field -->
                  <div class="form-floating mb-3">
                    <textarea name="description"  value="${contact.description}" class="form-control"
                    placeholder="Enter Contact Description " id="floatingTextarea"></textarea>
                  </div>

                  <!--Image field -->
                  <div class="custom-file mb-3">
                    <input class="form-control" name="imageFile" type="file" id="formFile">
                  </div>

                  <div class="container text-center">
                    <button class="btn btn-outline-primary">Save Contact</button>
                  </div>

                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

  </body>
</html>
