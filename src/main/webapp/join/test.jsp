<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Dynamic JSP Include Example</title>
    <style>
        #content {
            width: 800px;
            height: 500px;
            border: 1px solid #000;
            overflow: auto;
        }
        a {
            margin: 10px;
            cursor: pointer;
        }
    </style>
    <script>
        function loadContent(page) {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById('content').innerHTML = xhr.responseText;
                }
            };
            xhr.open('GET', page, true);
            xhr.send();
        }
    </script>
</head>
<body>
    <div>
        <a onclick="loadContent('join.jsp')">헤더 보기</a>
        <a onclick="loadContent('log_in.jsp')">푸터 보기</a>
        
    </div>
    <div id="content">
        <!-- 여기에 포함된 JSP 파일의 내용이 로드됩니다. -->
    </div>
</body>
</html>