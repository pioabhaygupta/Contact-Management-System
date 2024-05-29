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
      <div class="card">
        <div class="card-body">
         <h1 class="text-center"> View Contacts </h1>

          <!--User Contacts Table-->
          <table class="table">
            <thead>
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
                  <td>SCM2024${contact.id}</td>
                  <td>${contact.name}</td>
                  <td>${contact.email}</td>
                  <td>${contact.phone}</td>
                  <td>
                    <button class="btn btn-info btn-sm">Update</button>
                    <button class="btn btn-danger btn-sm">Delete</button>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>

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
    </section>
  </body>
</html>
