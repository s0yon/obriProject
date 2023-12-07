<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<head>
<!-- WebSocket 설정 -->
<!-- WebJars를 통해 제공되는 jQuery 라이브러리를 사용 -->
<script src="/webjars/jquery/jquery.min.js"></script>

<!-- WebJars를 통해 제공되는 SockJS와 STOMP 라이브러리를 사용 -->
<script src="/webjars/sockjs-client/sockjs.min.js"></script>
<script src="/webjars/stomp-websocket/stomp.min.js"></script>

<!-- 웹 소켓과 관련된 사용자 정의코드 -->
<script src="${path}/js/webSocket.js"></script>
</head>