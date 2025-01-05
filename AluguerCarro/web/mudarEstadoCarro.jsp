<%-- 
    Document   : mudarEstadoCarro
    Created on : 02/10/2024, 04:18:48
    Author     : Administrator
--%>

<%@page import="java.math.BigDecimal"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mudar Estado do Carro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Mudar Estado dos Carros</h2>

        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Modelo</th>
                    <th>Marca</th>
                    <th>Preço (?)</th>
                    <th>Estado Atual</th>
                    <th>Mudar Estado</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;

                    try {
                        // Conectar ao banco de dados
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost/aluguer", "root", "chance");

                        // Executar consulta SQL para listar todos os carros
                        String sql = "SELECT * FROM carros";
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery(sql);

                        // Exibir os resultados na tabela
                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String modelo = rs.getString("modelo");
                            String marca = rs.getString("marca");
                            BigDecimal preco = rs.getBigDecimal("preco");
                            String estado = rs.getString("estado");

                            %>
                            <tr>
                                <td><%= id %></td>
                                <td><%= modelo %></td>
                                <td><%= marca %></td>
                                <td><%= preco %></td>
                                <td><%= estado %></td>
                                <td>
                                    <form action="mudarEstadoCarro.jsp" method="post">
                                        <input type="hidden" name="carro_id" value="<%= id %>">
                                        <select name="novo_estado" class="form-select">
                                            <option value="disponível" <%= estado.equals("disponível") ? "selected" : "" %>>Disponível</option>
                                            <option value="alugado" <%= estado.equals("alugado") ? "selected" : "" %>>Alugado</option>
                                            <option value="manutenção" <%= estado.equals("manutenção") ? "selected" : "" %>>Manutenção</option>
                                        </select>
                                        <button type="submit" class="btn btn-primary mt-2">Atualizar</button>
                                    </form>
                                </td>
                            </tr>
                            <%
                        }
                    } catch (Exception e) {
                        out.println("<div class='alert alert-danger'>Erro ao listar os carros: " + e.getMessage() + "</div>");
                    } finally {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    }
                %>
            </tbody>
        </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
