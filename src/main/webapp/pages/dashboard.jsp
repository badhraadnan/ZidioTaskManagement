<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<style>
df-messenger {
	--df-messenger-bot-message: #e1f5fe;
	--df-messenger-button-titlebar-color: #007bff;
	--df-messenger-chat-background-color: white;
	--df-messenger-font-color: black;
}
</style>

<body>

	<script
		src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
	<df-messenger intent="WELCOME" chat-title="Zidio-Assitant"
		agent-id="9b06bc85-f88b-4510-8032-8f9b2ae4b40b" language-code="en"></df-messenger>
</body>
</html>