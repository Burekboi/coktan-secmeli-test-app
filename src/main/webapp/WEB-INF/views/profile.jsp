<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Kullanıcı Profili</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 900px;
            margin: 40px auto;
            background-color: white;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
            border-radius: 12px;
        }
        .profile-header {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 30px;
        }
        .avatar {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            background-color: #ccc;
            background-image: url('https://www.gravatar.com/avatar?d=mp');
            background-size: cover;
        }
        .user-info h2 {
            margin: 0;
            color: #333;
        }
        .user-info p {
            margin: 5px 0;
            color: #666;
        }
        .stats {
            margin-top: 20px;
        }
        .stats h3 {
            color: #444;
            border-bottom: 1px solid #ddd;
            padding-bottom: 5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        th {
            background-color: #fafafa;
        }
        .score {
            font-weight: bold;
            color: #007bff;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="profile-header">
        <div class="avatar"></div>
        <div class="user-info">
            <h2>${user.firstName} ${user.lastName}</h2>
            <h3>${user.username}</h3>
        </div>
    </div>

    <div class="stats">
        <h3>Çözdüğü Testler</h3>
        <table>
            <thead>
            <tr>
                <th>Test Adı</th>
                <th>Tarih</th>
                <th>Puan</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>

