<%-- 
    Document   : adicionarCarro
    Created on : 02/10/2024, 04:00:07
    Author     : Administrator
--%>

<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Adicionar Carro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Adicionar Novo Carro</h2>

        <!-- Formulário para Adicionar Carro -->
        <form action="adicionarCarro.jsp" method="post">
            <div class="mb-3">
                <label for="modelo" class="form-label">Modelo</label>
                <input type="text" class="form-control" id="modelo" name="modelo" required>
            </div>
            <div class="mb-3">
                <label for="marca" class="form-label">Marca</label>
                <input type="text" class="form-control" id="marca" name="marca" required>
            </div>
            <div class="mb-3">
                <label for="preco" class="form-label">Preço (?)</label>
                <input type="number" step="0.01" class="form-control" id="preco" name="preco" required>
            </div>
            <div class="mb-3">
                <label for="estado" class="form-label">Estado</label>
                <select class="form-control" id="estado" name="estado" required>
                    <option value="disponível">Disponível</option>
                    <option value="alugado">Alugado</option>
                    <option value="manutenção">Manutenção</option>
                </select>
            </div>

            <button type="submit" class="btn btn-success">Adicionar Carro</button>
        </form>

        <!-- Código JSP para inserir os dados no banco de dados -->
        <%
            if (request.getMethod().equalsIgnoreCase("POST")) {
                String modelo = request.getParameter("modelo");
                String marca = request.getParameter("marca");
                String preco = request.getParameter("preco");
                String estado = request.getParameter("estado");

                Connection conn = null;
                PreparedStatement stmt = null;

                try {
                    // Conectar ao banco de dados (ajuste os parâmetros conforme o seu ambiente)
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost/aluguer", "root", "chance");

                    // Inserir dados na tabela 'carros'
                    String sql = "INSERT INTO carros (modelo, marca, preco, estado) VALUES (?, ?, ?, ?)";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, modelo);
                    stmt.setString(2, marca);
                    stmt.setBigDecimal(3, new java.math.BigDecimal(preco));
                    stmt.setString(4, estado);

                    int result = stmt.executeUpdate();

                    if (result > 0) {
                        out.println("<div class='alert alert-success mt-4'>Carro adicionado com sucesso!</div>");
                    } else {
                        out.println("<div class='alert alert-danger mt-4'>Erro ao adicionar carro.</div>");
                    }
                } catch (Exception e) {
                    out.println("<div class='alert alert-danger mt-4'>Erro: " + e.getMessage() + "</div>");
                } finally {
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            }
        %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
