<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="Header.jsp"%>

   
                <div class="row">
		<div class="col-2"></div>
	
                <div class="col-8">
                  <!-- 헤드 영역 시작-->
                  <div class="row-cols-1">
                  <br><br>
                    <table class="table table-borderless">
                        <thead>
                          <tr>
                            <th colspan="4" style="text-align: left;">제목</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <th scope="row" style="text-align: left;width: 20%;">작성자</th>
                            <td style="width: 35%;"></td>
                            <td style="width: 25%;">작성일</td>
                            <td style="width: 20%;">조회수</td>
                          </tr>
                        </tbody>
                      </table>
                  </div>
                  <!-- 헤드 영역 끝 -->
                  <!-- 본문 영역 시작 -->
                  <div class="row-cols-1">
                            <form>
                                <textarea class="form-control" id="QNAcontent" rows="13" style="resize: none;" placeholder="내용 영역"></textarea>
                            </form>
                  </div>
                  <!-- 본문 영역 끝 -->
                  <!-- 댓글 영역 시작 -->
                  <div class="row-cols-1">
                    <table style="width:100%; ">
                          <tr>
                            <th scope="row" style="text-align: left;width: 15%;">작성자</th>
                            <td style="width: 55%;">내용</td>
                            <td style="width: 20%;">작성일</td>
                            <td style="width: 10%;">수정/삭제</td>
                          </tr>
                          <tr>
                            <th scope="row" style="text-align: left;width: 15%;">작성자</th>
                            <td style="width: 55%;">내용</td>
                            <td style="width: 20%;">작성일</td>
                            <td style="width: 10%;">수정/삭제</td>
                          </tr>
                          <tr>
                            <td colspan="3">
                              <input class="form-control" type="text" placeholder="댓글 입력"> 
                            </td>
                            <td>
                              <button type="button" class="btn btn-primary "> &nbsp;&nbsp; 등록 &nbsp;&nbsp;</button>
                            </td>
                          </tr>
                      </table>
                  </div>
                  <br>
                  <!-- 댓글 영역 끝 -->
                  <!-- 버튼 영역 시작 -->
                  <div class="row-cols-2">
                    <div class="float-left">
                        <button type="button" class="btn btn-secondary mb-2" onclick="location.href='list.jsp'">목록</button>

                    </div>
                  </div>
                  <div class="row-cols-2">
                    <div class="float-right">
                        <button type="button" class="btn btn-secondary mb-2" onclick="location.href='QNAwrite.jsp'">수정</button>
                        <button type="button" class="btn btn-secondary mb-2" onclick="location.href='QNAwrite.jsp'">삭제</button>
                        <button type="button" class="btn btn-primary mb-2" onclick="location.href='insert.jsp'">글쓰기</button>

                    </div>
                  </div>
                  <!-- 버튼 영역 끝 -->
                </div>
               <div class="col-2"></div>
              </div>
         
   
<%@ include file="Footer.jsp"%>