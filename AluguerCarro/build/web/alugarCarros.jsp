<%-- 
    Document   : alugarCarros
    Created on : 02/10/2024, 02:49:10
    Author     : Administrator
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Alugar Carro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

</head>
<body>

<h2>Alugar Carro</h2>

<form action="" method="post">
    Nome: <input type="text" name="nome" required><br>
    Email: <input type="email" name="email" required><br>
    Telefone: <input type="text" name="telefone" required><br>
    Senha: <input type="password" name="senha" required><br>
    
    <label for="carro_id">Escolha um carro:</label>
    <select name="carro_id" required>
        <option value="">Selecione um carro</option>
        <%
            // Conexão com o banco de dados para listar carros disponíveis
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/aluguer", "root", "chance");
                stmt = conn.createStatement();
                String sql = "SELECT id, modelo, marca FROM carros WHERE estado = 'disponível'";
                rs = stmt.executeQuery(sql);
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String modelo = rs.getString("modelo");
                    String marca = rs.getString("marca");
                    out.println("<option value=\"" + id + "\">" + modelo + " - " + marca + "</option>");
                }
            } catch (Exception e) {
                out.println("Erro ao carregar carros: " + e.getMessage());
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </select><br>
    
    Data de Início: <input type="date" name="data_inicio" required><br>
    Data de Fim: <input type="date" name="data_fim" required><br>
    
    <input type="submit" value="Alugar Carro">
</form>

<%
    // Verifica se a requisição é POST
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String telefone = request.getParameter("telefone");
        String senha = request.getParameter("senha");
        int carro_id = Integer.parseInt(request.getParameter("carro_id"));
        Date data_inicio = Date.valueOf(request.getParameter("data_inicio"));
        Date data_fim = Date.valueOf(request.getParameter("data_fim"));

        // Declare a conexão e os PreparedStatements
        Connection connection = null; // Renomeado para evitar conflito
        PreparedStatement stmtCliente = null;
        PreparedStatement stmtAluguel = null;
        PreparedStatement stmtUpdateCarro = null;

        try {
            // Conexão com o banco de dados
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/aluguer", "root", "chance");
            connection.setAutoCommit(false); // Inicia uma transação

            // Inserir cliente na tabela clientes
            String sqlCliente = "INSERT INTO clientes (nome, email, telefone, senha) VALUES (?, ?, ?, ?)";
            stmtCliente = connection.prepareStatement(sqlCliente, Statement.RETURN_GENERATED_KEYS);
            stmtCliente.setString(1, nome);
            stmtCliente.setString(2, email);
            stmtCliente.setString(3, telefone);
            stmtCliente.setString(4, senha);
            stmtCliente.executeUpdate();

            // Recuperar o ID do cliente inserido
            ResultSet generatedKeys = stmtCliente.getGeneratedKeys();
            int cliente_id = 0;
            if (generatedKeys.next()) {
                cliente_id = generatedKeys.getInt(1);
            }

            // Inserir aluguel na tabela alugueis
            String sqlAluguel = "INSERT INTO alugueis (cliente_id, carro_id, data_inicio, data_fim) VALUES (?, ?, ?, ?)";
            stmtAluguel = connection.prepareStatement(sqlAluguel);
            stmtAluguel.setInt(1, cliente_id);
            stmtAluguel.setInt(2, carro_id);
            stmtAluguel.setDate(3, data_inicio);
            stmtAluguel.setDate(4, data_fim);
            stmtAluguel.executeUpdate();

            // Atualizar o estado do carro para 'alugado'
            String sqlUpdateCarro = "UPDATE carros SET estado = 'alugado', data_aluguel = ? WHERE id = ?";
            stmtUpdateCarro = connection.prepareStatement(sqlUpdateCarro);
            stmtUpdateCarro.setDate(1, new Date(System.currentTimeMillis())); // Data do aluguel
            stmtUpdateCarro.setInt(2, carro_id);
            stmtUpdateCarro.executeUpdate();

            connection.commit(); // Confirma a transação
            out.println("Carro alugado com sucesso!");

        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback(); // Desfaz a transação em caso de erro
                } catch (SQLException ex) {
                    out.println("Erro ao reverter transação: " + ex.getMessage());
                }
            }
            out.println("Erro ao alugar carro: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            out.println("Driver não encontrado: " + e.getMessage());
        } finally {
            if (stmtCliente != null) try { stmtCliente.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmtAluguel != null) try { stmtAluguel.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmtUpdateCarro != null) try { stmtUpdateCarro.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
%>

</body>
</html>
