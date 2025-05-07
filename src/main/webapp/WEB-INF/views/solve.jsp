<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>

<layout:layout pageTitle="Test Çöz">
    <div class="container my-5">
        <div class="row">
            <!-- Soru Bölümü -->
            <div class="col-md-8">
                <div class="card shadow rounded-4">
                    <div class="card-body">
                        <h4 class="card-title mb-4">Soru ${questionIndex + 1}</h4>

                        <form method="post" action="${pageContext.request.contextPath}/tests/solve/${testId}/answer">
                            <input type="hidden" name="questionIndex" value="${questionIndex}" />

                            <p class="fs-5 fw-semibold">${question.text}</p>

                            <c:forEach var="choice" items="${question.choices}" varStatus="optStatus">
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="radio"
                                           name="answer"
                                           id="opt${optStatus.index}"
                                           value="${choice.text}"
                                           required
                                           <c:if test="${answers[questionIndex] == choice.text}">checked</c:if>>
                                    <label class="form-check-label" for="opt${optStatus.index}">
                                            ${choice.text}
                                    </label>
                                </div>
                            </c:forEach>

                            <button type="submit" class="btn btn-primary mt-4 px-4 py-2">İleri</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Optik Bölümü -->
            <div class="col-md-4">
                <div class="card shadow-sm rounded-4">
                    <div class="card-header bg-info text-white rounded-top-4">
                        <h5 class="mb-0">Optik</h5>
                    </div>
                    <ul class="list-group list-group-flush">
                        <c:forEach var="ans" items="${answers}" varStatus="status">
                            <li class="list-group-item d-flex justify-content-between
                                <c:if test='${status.index == questionIndex}'>active</c:if>">
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
        </div>
    </div>
</layout:layout>
