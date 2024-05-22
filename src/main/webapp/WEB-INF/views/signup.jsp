<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="base.jsp" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Contact Manager</title>
  </head>
  <body>
    <section>
      <div class="container">
        <div class="row">
          <div class="col-md-8 offset-md-2">
            <div class="my-card">

              <!--Alert Message -->
              <div>
                <c:if test="${not empty sessionScope.message}">
                  <div class="alert ${sessionScope.message.type} text-center" role="alert">
                    <p>${sessionScope.message.content}</p>
                    <c:remove var="message" scope="session" />
                  </div>
                </c:if>
              </div>

              <h1 class="text-center">Register Here !!</h1>
              <form:form action="do-register" method="post" modelAttribute="user" value="${user}">

                <!--Name Field -->
                <div class="mb-3 form-group">
                  <label for="name_field" >Name</label>
                  <form:input type="text" path="name" value="${user.name}" class="form-control" id="name_field"
                  aria-describedby="emailHelp" placeholder="Enter here" />
                  <form:errors path="name" cssClass="text-danger"/>
                </div>

                <!--Email Field -->
                <div class="mb-3 form-group">
                  <label for="email_field" >Email</label>
                  <form:input type="text" path="email" value="${user.email}" class="form-control" id="email_field"
                   aria-describedby="emailHelp" placeholder="Enter here" />
                   <form:errors path="email" cssClass="text-danger"/>
                </div>

                <!--Password Field -->
                <div class="mb-3 form-group">
                  <label for="password_field" >Password</label>
                  <form:input type="password" path="password" class="form-control"
                  id="password_field" aria-describedby="emailHelp" placeholder="Enter here" />
                  <form:errors path="password" cssClass="text-danger"/>
                </div>

                <!--About Field -->
                <div class="form-floating">
                  <label for="floatingTextarea">About</label>
                  <form:textarea path="about" class="form-control"
                  placeholder="Enter something about yourself" id="floatingTextarea"></form:textarea>
                  <form:errors path="about" cssClass="text-danger"/>
                </div>

                <!--Terms and condition agreement -->
                 <div class="form-group form-check text-center">
                   <input class="form-check-input" path="agreement" type="checkbox" name="agreement" id="agreement" />
                   <label for="agreement">
                     Accept terms and conditions
                   </label>
                 </div>

                <!--Button-->
                <div class="container text-center mt-3">
                  <form:button type="submit" class="btn text-white bg-dark mr-2"> Submit </form:button>
                  <form:button type="reset" class="btn  bg-warning"> Reset </form:button>
                </div>

              </form:form>
            </div>
          </div>
        </div>
      </div>
    </section>
  </body>
</html>