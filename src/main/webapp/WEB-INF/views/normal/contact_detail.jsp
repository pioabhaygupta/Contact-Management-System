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
    <section class="content mt-5">
      <i onclick="toggleSidebar()" id="menu" class="material-symbols-outlined mt-2">menu </i>
      <c:if test="${not empty contact}">
        <div class="card mr-3 ml-3">
          <div class="card-body">
            <div class="container text-center">
              <img style="height: 180px; width: 180px;" class="contact-profile-picture" src="data:image/jpg;base64,${contact.image}" />
              <h3 class="mt-3"><span>${contact.name}</span> (<span>${contact.nickName}</span>)</h3>
              <table class="table">
                <thead>
                  <tr>
                    <th scope="col">#ID</th>
                    <th scope="col">SCM${contact.id}</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <th scope="row">Email</th>
                    <td>${contact.email}</td>
                  </tr>

                  <tr>
                    <th scope="row">Phone</th>
                    <td>${contact.phone}</td>
                  </tr>

                  <tr>
                    <th scope="row">Work</th>
                    <td>${contact.work}</td>
                  </tr>

                  <tr>
                    <th scope="row">Description</th>
                    <td>${contact.description}</td>
                  </tr>
                </tbody>
              </table>

              <div class="container mt-3 ">
                <button class="btn btn-info btn-sm mr-3">Update</button>

                <a href="#" onclick="deleteContact(${contact.id})">
                  <button class="btn btn-danger btn-sm mr-3">Delete</button>
                </a>
                <a href="/user/show-contacts/${sessionScope.currentPage}">
                  <button class="btn btn-warning btn-sm">Back</button>
                </a>
              </div>

            </div>
          </div>
        </div>
      </c:if>
      <c:if test="${not empty message}">
        <h3 class="text-center bg-warning text-white">${message}</h3>
      </c:if>
    </section >
  </body>
</html>
