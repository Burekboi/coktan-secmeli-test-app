<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>

<layout:layout pageTitle="Test Çöz">
    <div class="container mt-4 d-flex">
        <!-- Soru Bölümü -->
        <div class="col-md-8">
            <h4>Soru ${questionIndex + 1}</h4>
            <form method="post" action="${pageContext.request.contextPath}/tests/solve/${testId}/answer">
                <input type="hidden" name="questionIndex" value="${questionIndex}" />
                <p><strong>${question.text}</strong></p>
                <c:forEach var="option" items="${question.options}" varStatus="optStatus">
                    <div class="form-check">
                        <input class="form-check-input" type="radio"
                               name="answer"
                               id="opt${optStatus.index}"
                               value="${option}"
                               required
                               <c:if test="${answers[questionIndex] == option}">checked</c:if>>
                        <label class="form-check-label" for="opt${optStatus.index}">
                            ${option}
                        </label>
                    </div>
                </c:forEach>
                <button type="submit" class="btn btn-primary mt-3">İleri</button>
            </form>
        </div>

        <!-- Optik Bölümü -->
        <div class="col-md-4 ms-4">
            <h5>Optik</h5>
            <ul class="list-group">
                <c:forEach var="ans" items="${answers}" varStatus="status">
                    <li class="list-group-item d-flex justify-content-between
                        <c:if test='${status.index == questionIndex}'>list-group-item-info</c:if>'>
                        <span>S${status.index + 1}</span>
                        <span>
                            <c:choose>
                                <c:when test="${ans != null}">
                                    ${ans}
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </span>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</layout:layout>
