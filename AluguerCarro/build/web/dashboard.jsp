<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Admin Dashboard</h1>
        <div class="row">
            <!-- Card para Adicionar Carro -->
            <div class="col-md-4 mb-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Adicionar Carro</h5>
                        <a href="adicionarCarro.jsp" class="btn btn-primary">Ir para Adicionar</a>
                    </div>
                </div>
            </div>
            <!-- Card para Listar Carros -->
            <div class="col-md-4 mb-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Listar Carros</h5>
                        <a href="listarCarros.jsp" class="btn btn-primary">Ver Lista</a>
                    </div>
                </div>
            </div>
            <!-- Card para Carros Alugados -->
            <div class="col-md-4 mb-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Carros Alugados</h5>
                        <a href="listarCarrosAlugados.jsp" class="btn btn-primary">Ver Alugados</a>
                    </div>
                </div>
            </div>
            <!-- Card para Carros Livres -->
            <div class="col-md-4 mb-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Carros Livres</h5>
                        <a href="listarCarrosDisponiveis.jsp" class="btn btn-primary">Ver Livres</a>
                    </div>
                </div>
            </div>
            <!-- Card para Mudar Estado -->
            <div class="col-md-4 mb-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Mudar Estado de Carro</h5>
                        <a href="mudarEstadoCarro.jsp" class="btn btn-primary">Mudar Estado</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
