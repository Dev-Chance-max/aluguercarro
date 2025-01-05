<%-- 
    Document   : listarCarrosAlugados
    Created on : 02/10/2024, 04:11:07
    Author     : Administrator
--%>
<%@page import="java.math.BigDecimal"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carros Alugados</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Carros Alugados</h2>

        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Modelo</th>
                    <th>Marca</th>
                    <th>Preço (?)</th>
                    <th>Data de Aluguel</th>
                    <th>Data de Entrega</th>
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

                        // Executar consulta SQL para listar todos os carros alugados
                        String sql = "SELECT * FROM carros WHERE estado = 'alugado'";
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery(sql);

                        // Exibir os resultados na tabela
                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String modelo = rs.getString("modelo");
                            String marca = rs.getString("marca");
                            BigDecimal preco = rs.getBigDecimal("preco");
                            Date dataAluguel = rs.getDate("data_aluguel");
                            Date dataEntrega = rs.getDate("data_entrega");

                            %>
                            <tr>
                                <td><%= id %></td>
                                <td><%= modelo %></td>
                                <td><%= marca %></td>
                                <td><%= preco %></td>
                                <td><%= (dataAluguel != null ? dataAluguel : "N/A") %></td>
                                <td><%= (dataEntrega != null ? dataEntrega : "N/A") %></td>
                            </tr>
                            <%
                        }
                    } catch (Exception e) {
                        out.println("<div class='alert alert-danger'>Erro ao listar os carros alugados: " + e.getMessage() + "</div>");
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
