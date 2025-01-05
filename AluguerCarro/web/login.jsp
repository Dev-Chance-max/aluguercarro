<%-- 
    Document   : login
    Created on : 02/10/2024, 01:53:48
    Author     : Administrator
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Aluguel de Carros</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .login-container {
            margin-top: 100px;
            max-width: 400px;
            margin-left: auto;
            margin-right: auto;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2 class="text-center">Login</h2>
    <form method="post">
        <div class="mb-3">
            <label for="username" class="form-label">Nome de Usuário</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Senha</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <button type="submit" class="btn btn-primary">Entrar</button>
    </form>

    <% 
        if (request.getMethod().equalsIgnoreCase("post")) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String url = "jdbc:mysql://localhost:3306/aluguer"; 
            String dbUsername = "root";
            String dbPassword = "chance";

            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                // Conectar ao banco de dados
                Class.forName("com.mysql.cj.jdbc.Driver"); // Driver do MySQL
                conn = DriverManager.getConnection(url, dbUsername, dbPassword);

                // Consulta SQL para verificar as credenciais
                String sql = "SELECT * FROM administradores WHERE nome = ? AND senha = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, username);
                stmt.setString(2, password);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    out.println("<div class='alert alert-success'>Login bem-sucedido!</div>");
                    // Redirecionar para outra página ou dashboard
                    response.sendRedirect("dashboard.jsp");                   
                } else {
                    out.println("<div class='alert alert-danger'>Nome de usuário ou senha inválidos!</div>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger'>Erro na conexão com o banco de dados.</div>");
            } finally {
                // Fechar recursos
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    %>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>

