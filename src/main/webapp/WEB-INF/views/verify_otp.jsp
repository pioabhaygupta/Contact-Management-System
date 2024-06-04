<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ include file="base.jsp" %>
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Contact Manager</title>
    <style> <%@include file="/WEB-INF/static/css/style.css"%> </style>
  </head>
  <body>
    <section>
      <div id="login">
        <h3 class="text-center text-white pt-5"></h3>
          <div class="container">
            <!--Alert Message -->
              <div class="container col-md-6 mt-4">
                <c:if test="${not empty sessionScope.message}">
                  <div id="myAlert" class="alert ${sessionScope.message.type} text-center" role="alert">
                    <p>${sessionScope.message.content}</p>
                    <c:remove var="message" scope="session" />
                  </div>
                </c:if>
              </div>
            <div id="login-row" class="row justify-content-center align-items-center">
              <div id="login-column" class="col-md-6">
                <div id="login-box" style="height: 200px;" class="col-md-12">
                  <h3 class="text-center m-3">One Time Password</h3>
                  <form id="forgot-form" class="form" action="/verify-otp" method="post">

                    <div class="form-group">
                      <input type="text" name="otp" id="otp" class="form-control" placeholder="Enter OTP here" required>
                    </div>

                    <div class="container text-center">
                      <button class="btn btn-warning">Verify OTP</button>
                    </div>

                  </form>
                </div>
              </div>
            </div>
          </div>
      </div>
    </section>
  </body>
</html>