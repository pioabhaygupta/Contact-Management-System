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
    <section class="content mt-5 ">
      <i onclick="toggleSidebar()" id="menu" class="material-symbols-outlined mt-2">menu </i>
      <div>
        <c:if test="${not empty sessionScope.message}">
          <div class="alert ${sessionScope.message.type} text-center" role="alert">
            <p>${sessionScope.message.content}</p>
            <c:remove var="message" scope="session" />
          <div>
         </c:if>
       <div>
      <div class="card mr-3 ml-3">
        <div class="card-body ">
          <h1 class="text-center"> View Contacts </h1>

          <!--Search Contact-->
          <div class="search-container my-3">
            <input type="text" id="search-input" class="form-control" placeholder="Search your contacts"  />
              <div id="search-result">

              </div>
          </div>

          <!--User Contacts Table-->
          <div class="table-responsive">
            <table class="table table-hover">
              <thead class="thead-dark">
                <tr>
                  <th scope="col">#ID</th>
                  <th scope="col">Name</th>
                  <th scope="col">Email</th>
                  <th scope="col">phone</th>
                  <th scope="col">Action</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach items="${contacts}" var="contact">
                  <tr>
                    <td>SCM${contact.id}</td>

                    <td>
                      <a href="/user/${contact.id}/contact">
                        <img class="contact-profile-picture" src="data:image/jpg;base64,${contact.image}"  />
                      </a>
                      <span>${contact.name}</span>
                    </td>

                    <td>${contact.email}</td>

                    <td>${contact.phone}</td>

                    <td>
                      <div id="button-container">
                        <form action="/user/update-contact/${contact.id}" method="post" class="mb-2">
                          <button type="submit" class="btn btn-info btn-sm mr-3">Update</button>
                        </form>
                        <a href="#" onclick="deleteContact(${contact.id})">
                          <button class="btn btn-danger btn-sm">Delete</button>
                        </a>
                      </div>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>

          <!--Pagination-->

          <nav aria-label="Page navigation example">

            <ul class="pagination">
              <c:if test="${currentPage > 0}">
                <li class="page-item"><a class="page-link" href="/user/show-contacts/${currentPage-1}">Previous</a></li>
              </c:if>

              <c:forEach var="i" begin="0" end="${totalPages}">
                <c:choose>
                  <c:when test="${currentPage eq i}">
                    <li class="page-item"><a class="page-link active" href="/user/show-contacts/${i}"><b>${i+1}<b></a></li>
                  </c:when>
                </c:choose>
              </c:forEach>

              <c:if test="${currentPage+1 != totalPages }">
                <li class="page-item"><a class="page-link" href="/user/show-contacts/${currentPage+1}">Next</a></li>
              </c:if>
            </ul>

          </nav>

        </div>
      </div>
      <script>
        $(document).ready(() =>{
          $(".item").removeClass("active");
          $("#view-link").addClass("active");
        });
      </script>
    </section>

  </body>
</html>
