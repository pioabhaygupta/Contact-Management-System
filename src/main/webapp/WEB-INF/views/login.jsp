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
        <h3 class="text-center text-white pt-5">Login form</h3>
          <div class="container ">
            <div id="login-row" class="row justify-content-center align-items-center">
              <div id="login-column" class="col-md-6">
                <div id="login-box" class="col-md-12 ">
                  <form id="login-form" class="form" action="/login" method="post">
                    <h3 class="text-center text-info text-dark">Login</h3>

                    <c:if test="${param.error != null}">
                      <div class="text-center alert alert-danger "> Invalid username or password.. </div>
                    </c:if>
                    <c:if test="${param.logout != null}">
                      <div class="text-center alert alert-success"> You have been logged out.. </div>
                    </c:if>

                    <div class="form-group">
                      <label for="username" class="text-info text-dark">Email:</label><br>
                      <input type="text" name="username" id="username" class="form-control">
                    </div>

                    <div class="form-group">
                      <label for="password" class="text-info text-dark">Password:</label><br>
                      <input type="password" name="password" id="password" class="form-control">
                    </div>
                    <div class="container text-dark" style="display:flex; justify-content: space-between">
                      <a href="/forgot" class="text-dark">Forgot Password?</a>
                      <a href="/signup" class="text-info text-dark">Register here</a>
                    </div>

                    <div class="form-group text-center">
                      <input type="submit" name="submit" class="btn btn-info btn-md" value="Submit">
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