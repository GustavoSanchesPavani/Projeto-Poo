<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Painel do Usu�rio</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />


        <style>.edit-icon {
                color: blue;
            }

            .delete-icon {
                color: red;
            }
            .icon-button {
                cursor: pointer;
                transition: color 0.2s;
            }
            .move-left {
                margin-right: 80px; /* Ajuste conforme necess�rio */
            }
            .bg-successs{
                background-color:  #0b1c18;
            }

            body {
                background-image: url('imagens/fundo.jpg');
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                background-attachment: fixed; /* Isso impede que a imagem de fundo role com a p�gina */
            }
            .active>.page-link, .page-link.active {
                background-color:  #198754;
            }
            .form-text {
                color: lightgrey;
            }


            /* Seus estilos existentes aqui */
        </style>

    </head>

    <body>
        <%
     String nomeUsuario = (String) session.getAttribute("nomeUsuario");
     if (nomeUsuario != null) {
     String nomePatente = (String) session.getAttribute("nm_patente");
     int usuarioID = (int) session.getAttribute("idUsuario");
         
 

     // Adicionando as demais informa��es
     int idadeUsuario = (int) session.getAttribute("cd_idade");
         
     String dataNas = (String) session.getAttribute("dt_dataNascimento");
         
     String nomeGuerra = (String) session.getAttribute("nm_guerra");
         
     String usLogin = (String) session.getAttribute("nm_usuarioLogin");
         
     String usSenha = (String) session.getAttribute("cd_senha");
         
     String nm_patente = (String) session.getAttribute("nm_patente");


        %>

        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <button
                    class="navbar-toggler"
                    type="button"
                    data-mdb-toggle="collapse"
                    data-mdb-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent"
                    aria-expanded="false"
                    aria-label="Toggle navigation"
                    >
                    <i class="fas fa-bars"></i>
                </button>

                <!-- Collapsible wrapper da barra de navega��o -->
<div class="collapse navbar-collapse" id="navbarSupportedContent">
    <!-- Navbar brand -->
    <a href="#" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none">
        <img
            src="imagens/iconEx.png"
            height="50"
        />
        <span class="fs-4 text-light">CGM</span>
    </a>

</div>
<!-- Fim do wrapper colaps�vel -->

<!-- Elementos � direita da barra de navega��o -->
<div class="d-flex align-items-center">
    <!-- �cone -->

    <!-- Dropdown (menu suspenso) -->
    <div class="dropdown">
        <!-- Bot�o de ativa��o do dropdown -->
        <button class="btn btn-success dropdown-toggle move-left" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <img
                src="imagens/userIcon.png"
                height="40"
            />
            <%= nomeUsuario %>
        </button>

        <!-- Lista de op��es do dropdown -->
        <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="dropdownMenuButton">
            <!-- Op��o "Perfil" -->
            <li>
                <button type="button" class="dropdown-item btn btn-primary" data-toggle="modal" data-target="#perfilSoldadoModal">
                    Perfil
                </button>
            </li>
            <!-- Separador -->
            <li>
                <hr class="dropdown-divider">
            </li>
            <!-- Op��o "Solicita��es" -->
            <li>
                <button type="button" class="dropdown-item btn btn-primary" data-toggle="modal" data-target="#solicitacoesTrocaModal">
                    Solicita��es
                </button>
            </li>
            <!-- Separador -->
            <li>
                <hr class="dropdown-divider">
            </li>
            <!-- Formul�rio para registrar entrada -->
            <li>
                <form action="registrarEntrada.jsp" method="post">
                    <input type="hidden" name="idEscala" value="<%= usuarioID %>">
                    <button class="dropdown-item btn btn-success rounded" type="submit">Registrar Entrada</button>
                </form>
            </li>
            <!-- Formul�rio para registrar sa�da -->
            <li>
                <form action="registrarSaida.jsp" method="post">
                    <input type="hidden" name="idEscala" value="<%= usuarioID %>">
                    <button class="dropdown-item btn btn-danger rounded" type="submit">Registrar Sa�da</button>
                </form>
            </li>
            <!-- Separador -->
            <li>
                <hr class="dropdown-divider">
            </li>
            <!-- Op��o "Logout" -->
            <li><a class="dropdown-item" href="logout.jsp">Logout</a></li>
        </ul>
    </div>
</div>

                </div>
<!-- Elementos � direita -->

</div>
<!-- Container wrapper -->
</nav>
<!-- Navbar -->

<!-- O Modal -->
<div class="modal" id="perfilSoldadoModal">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- Cabe�alho do Modal -->
            <div class="modal-header">
                <h5 class="modal-title">Meu Perfil</h5>
                <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Formul�rio para atualizar o perfil -->
            <form action="atualizarPerfil.jsp" method="post">
                <!-- Corpo do Modal -->
                <div class="modal-body">
                    <!-- Campo de entrada para o nome -->
                    <div class="form-group">
                        <label for="nomeInput"><strong>Nome</strong></label>
                        <input type="text" class="form-control" id="nomeInput" name="nomeInput" value="<%= nomeUsuario%>">
                    </div>
                    <!-- Campo de entrada para a idade -->
                    <div class="form-group">
                        <label for="idadeInput"><strong>Idade</strong></label>
                        <input type="text" class="form-control" id="idadeInput" name="idadeInput" value="<%= idadeUsuario%>">
                    </div>

                    <!-- Campo de entrada para a data de nascimento -->
                    <div class="form-group">
                        <label for="nascimentoInput"><strong>Data de Nascimento</strong></label>
                        <input type="text" class="form-control" id="nascimentoInput" name="nascimentoInput" value="<%= dataNas%>">
                    </div>
                    <!-- Campo de entrada para o nome de guerra -->
                    <div class="form-group">
                        <label for="nomeGuerraInput"><strong>Nome de Guerra</strong></label>
                        <input type="text" class="form-control" id="nomeGuerraInput" name="nomeGuerraInput" value="<%= nomeGuerra%>">
                    </div>

                    <!-- Campo de sele��o para a patente -->
                    <div class="form-group">
                        <label for="patenteInput"><strong>Patente</strong></label>
                        <select id="nm_patente" aria-label="Escolha a Patente" name="nm_patente" class="form-control form-control-lg form-select" required value="<%= nm_patente%>">
                            <option selected disabled>Escolha a patente</option>
                            <option value="Sentinela" <%= "Sentinela".equals(nomePatente) ? "selected" : "" %>>Sentinela</option>
                            <option value="Comandante" <%= "Comandante".equals(nomePatente) ? "selected" : "" %>>Comandante</option>
                            <option value="Cabo" <%= "Cabo".equals(nomePatente) ? "selected" : "" %>>Cabo</option>
                        </select>
                    </div>

                    <!-- Campo de entrada para o login -->
                    <div class="form-group">
                        <label for="loginInput"><strong>Login</strong></label>
                        <input type="text" class="form-control" id="loginInput" name="loginInput" value="<%= usLogin%>">
                        <input type="hidden" class="form-control" id="usuarioID" name="usuarioID" value="<%= usuarioID%>">
                    </div>
                    <!-- Campo de entrada para a senha -->
                    <div class="form-group">
                        <label for="senhaInput"><strong>Senha</strong></label>
                        <div class="input-group">
                            <input type="password" class="form-control" id="senhaInput" name="senhaInput" value="<%= usSenha%>" readonly>
                            <button class="btn btn-secondary" type="button" id="mostrarSenhaBtn">Mostrar</button>
                        </div>
                    </div>
                </div>

                <!-- Rodap� do Modal -->
                <div class="modal-footer">
                    <button type="submit" class="btn btn-secondary">Salvar</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                </div>
            </form>
        </div>
    </div>
</div>

        <!-- Novo Modal para Solicita��es de Troca -->
<div class="modal" id="solicitacoesTrocaModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <!-- Cabe�alho do Modal -->
            <div class="modal-header">
                <h5 class="modal-title">Solicita��es de Troca de Hor�rio</h5>
                <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Corpo do Modal -->
            <div class="modal-body">
                <!-- Tabela para exibir as solicita��es de troca -->
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID da Solicita��o</th>
                            <th>Soldado Solicitante</th>
                            <th>Data da Solicita��o</th>
                            <th>Status</th>
                            <th>A��es</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            try {
                                // Conex�o com o banco de dados
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/soldiers?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
                                Statement stmt = conn.createStatement();
                                
                                // Consulta SQL para obter as solicita��es de troca do usu�rio logado
                                String query = "SELECT troca_horario.*, solicitante.nm_usuario AS solicitante_nome, destinatario.nm_usuario AS destinatario_nome " +
                                "FROM troca_horario " +
                                "INNER JOIN usuario AS solicitante ON troca_horario.id_usuario_solicitante = solicitante.id_usuario " +
                                "INNER JOIN usuario AS destinatario ON troca_horario.id_usuario_destinatario = destinatario.id_usuario " +
                                "WHERE destinatario.id_usuario = " + usuarioID;
                                
                                ResultSet rs = stmt.executeQuery(query);
                                
                                // Itera��o sobre os resultados da consulta
                                while (rs.next()) { 
                                    String solicitante = rs.getString("solicitante_nome");
                                    String destinatario = rs.getString("destinatario_nome");
                                    String id_usuario_solicitante = rs.getString("id_usuario_solicitante");
                                    String id_usuario_destinatario = rs.getString("id_usuario_destinatario");
                                    String data_solicitacao = rs.getString("data_solicitacao");
                                    String status_solicitacao = rs.getString("status_solicitacao");
                        %>

                        <tr>
                            <!-- Exibindo informa��es de cada solicita��o na tabela -->
                            <td><%= id_usuario_solicitante %></td>
                            <td><%= solicitante %></td>
                            <td><%= data_solicitacao %></td>
                            <td><%= status_solicitacao %></td>
                            <td>
                                <!-- Formul�rio para processar a solicita��o -->
                                <form action="processar_solicitacao.jsp" method="post">
                                    <input type="hidden" name="id_solicitacao" value="<%= id_usuario_solicitante %>">
                                    <!-- Bot�es para aceitar ou recusar a solicita��o -->
                                    <button class="btn btn-success" type="submit" name="acao" value="aceitar">Aceitar</button>
                                    <button class="btn btn-danger" type="submit" name="acao" value="recusar">Recusar</button>
                                </form>
                            </td>
                        </tr>

                        <% 
                                }
                                // Fechando recursos
                                rs.close();
                                stmt.close();
                                conn.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>                      
                    </tbody>
                </table>
                      
                    </div>
<!-- Rodap� do Modal -->
<div class="modal-footer">
    <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
</div>
</div>
</div>
</div>

<!-- Container principal para as escalas de guarda -->
<div class="container card text-center mt-5">
    <div class="card-header">
        <h2 class="">Escalas de Guarda</h2>
    </div>
    <div class="card-body">

        <%       
         if ("Cabo".equals(nomePatente)) { 
        %>
        <!-- Mostra o bot�o apenas se a patente do par�metro for "Cabo" -->
        <button type="button" class="btn bg-success btn-lg btn-block text-light" data-bs-toggle="modal" data-bs-target="#addModal">
            Adicionar novo
        </button>
        <% } %>
        <br>
        <br>

        <!-- Add Modal -->

        <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addModalLabel">Adicionar Nova Escala</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Formul�rio para adicionar nova escala -->
                        <form method="post" action="addRecord.jsp" class="needs-validation" novalidate>
                            <% try {
                            // Conex�o com o banco de dados
                            Class.forName("com.mysql.cj.jdbc.Driver");
                                   Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/soldiers?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
                                   Statement stmt = conn.createStatement();
                                   String query = "SELECT * FROM usuario";
                                   ResultSet rs = stmt.executeQuery(query); %>
                            <div class="mb-3">
                                <label for="nome_soldado" class="form-label">Nome do Soldado</label>                                       
                                <select class="form-select" id="nome_soldado" name="id_usuario" required> 
                                    <option selected disabled value="">Escolha o soldado</option>  
                                    <% while (rs.next()) { 
                                        String nm_usuario = rs.getString("nm_usuario");
                                        String id_usuario = rs.getString("id_usuario");
                                        String patente_usuario = rs.getString("nm_patente");
                                        if (!"Cabo".equals(patente_usuario)) {%>
                                            <option value="<%= id_usuario %>"><%= nm_usuario %></option>
                                        <% }} %>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="tipo_escala" class="form-label">Tipo de Escala</label>
                                <select class="form-select" id="tipo_escala" name="tipo_escala" required>  
                                    <option selected disabled value="">Escolha a escala</option>
                                    <option value="Cinza">Cinza</option>
                                    <option value="Vermelha">Vermelha</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="corte_cabelo_conformidade" class="form-label">Corte de Cabelo</label>
                                <select class="form-select" id="corte_cabelo_conformidade" name="corte_cabelo_conformidade" required>  
                                    <option selected disabled value="">Escolha a conformidade</option>
                                    <option value="1">Conforme</option>
                                    <option value="0">N�o Conforme</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="identificacao_militar_conformidade" class="form-label">Identifica��o Militar</label>
                                <select class="form-select" id="identificacao_militar_conformidade" name="identificacao_militar_conformidade" required>  
                                    <option selected disabled value="">Escolha a conformidade</option>
                                    <option value="1">Conforme</option>
                                    <option value="0">N�o Conforme</option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-primary">Adicionar</button>
                            <%
                                        rs.close();
                                        stmt.close();
                                        conn.close();
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                            %>
                        </form>
                    </div>
                </div>
            </div>
        </div>
                <!-- Tabela para Escala de Guarda -->
<table id="soldadoTable" class="table table-striped text-center">
    <thead>
        <tr>
            <th class="text-center">ID</th>
            <th class="text-center">Nome do Soldado</th>
            <th class="text-center">Patente</th>
            <th class="text-center">Entrada</th> 
            <th class="text-center">Sa�da</th> 
            <th class="text-center">Tipo de Escala</th>
            <th class="text-center">Corte de Cabelo</th>
            <th class="text-center">Identifica��o Militar</th>
            <th class="text-center">A��es</th>
        </tr>
    </thead>
    <tbody>
        <%
        // Obt�m o ID do usu�rio logado
        int loggedInUserId = (int) session.getAttribute("idUsuario");
        try {
            // Conecta-se ao banco de dados
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/soldiers?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
            Statement stmt = conn.createStatement();
            // Consulta para obter dados da escala de guarda, usu�rios e registros de entrada/sa�da
            String query = "SELECT * FROM escala_guarda INNER JOIN usuario ON escala_guarda.id_usuario = usuario.id_usuario LEFT JOIN registro_entrada_saida ON escala_guarda.id_usuario = registro_entrada_saida.id_usuario";
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) { 
                // Extrai dados da consulta
                int idEscala = rs.getInt("id");
                String nomeSoldado = rs.getString("nm_usuario");
                String patente = rs.getString("nm_patente");     
                String diaHoraEntrada = rs.getString("data_hora_entrada");
                String diaHoraSaida = rs.getString("data_hora_saida");
                String tipoEscala = rs.getString("tipo_escala");
                boolean corteCabeloConforme = rs.getBoolean("corte_cabelo_conformidade");
                boolean identificacaoConforme = rs.getBoolean("identificacao_militar_conformidade");

                // Verifica se diaHoraEntrada e diaHoraSaida s�o nulos e exibe "N�o registrado" se for o caso
                diaHoraEntrada = (diaHoraEntrada != null) ? diaHoraEntrada : "N�o registrado";
                diaHoraSaida = (diaHoraSaida != null) ? diaHoraSaida : "N�o registrado";
        %>

       <tr>
    <td><%= idEscala %></td>
    <td><%= nomeSoldado %></td>
    <td><%= patente %></td>
    <td><%= diaHoraEntrada %></td>
    <td><%= diaHoraSaida %></td>
    <% if (tipoEscala.equals("Vermelha")) { %>
        <td class="text-danger"><%= tipoEscala %></td>
    <% } else  { %>
        <td class="text-body-secondary"><%= tipoEscala %></td>
    <% } %>
    <td><%= corteCabeloConforme ? "Conforme" : "N�o Conforme" %></td>
    <td><%= identificacaoConforme ? "Conforme" : "N�o Conforme" %></td>
    <td>
        <% if (loggedInUserId != rs.getInt("id_usuario")) { %>
            <!-- Formul�rio para solicitar troca -->
            <form action="solicitarTroca.jsp" method="post" class="mb-2">
                <input type="hidden" name="idEscala" value="<%= rs.getInt("id_usuario") %>">
                <button class="btn btn-primary" type="submit" value="<%= rs.getInt("id_usuario") %>">Solicitar Troca</button>
            </form>
            
            <%-- Verifica se a patente � igual a "Cabo" antes de exibir o bot�o "Remover" --%>
            <% if ("Cabo".equals(nomePatente)) { %>
                <!-- Formul�rio para remover registro -->
                <form action="deleteRecord.jsp" method="post">
                    <input type="hidden" name="idEscala" value="<%= rs.getInt("id_usuario") %>">
                    <button class="btn btn-danger" type="submit" value="<%= rs.getInt("id_usuario") %>">Remover</button>
                </form>
            <% } %>
        <% } %>
    </td>
</tr>

        <% } %>
        <%
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
    </tbody>
</table>

<%
} else {
%>
<p class="mt-3" style="color: white;">Voc� n�o est� autenticado. Por favor, fa�a login <a href='index.jsp'>aqui</a>.</p>
<%
}
%>

<div class="card-footer text-body-secondary">
</div>
</div>





            <script>
    // Fun��o para confirmar exclus�o de registro
    function deleteRecord(recordId) {
        if (confirm("Tem certeza de que deseja excluir este registro?")) {
            $.ajax({
                type: "POST",
                url: "deleteRecord.jsp",
                data: { recordId: recordId },
                success: function (data) {
                    // Trate a resposta (por exemplo, mostre uma mensagem de sucesso ou atualize a p�gina)
                    // Voc� tamb�m pode usar JavaScript para ocultar o modal ap�s uma exclus�o bem-sucedida.
                    location.reload(); // Atualiza a p�gina
                }
            });
        }
    }
</script>

<script>
    // Fun��o para alternar entre texto e senha
    function togglePasswordVisibility() {
        var passwordInput = document.getElementById("senhaInput");
        var showPasswordBtn = document.getElementById("mostrarSenhaBtn");

        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            showPasswordBtn.textContent = "Ocultar";
        } else {
            passwordInput.type = "password";
            showPasswordBtn.textContent = "Mostrar";
        }
    }

    // Adiciona um ouvinte de evento ao bot�o
    document.getElementById("mostrarSenhaBtn").addEventListener("click", togglePasswordVisibility);
</script>

<script>
    (() => {
        'use strict';

        const forms = document.querySelectorAll('.needs-validation');

        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }

                form.classList.add('was-validated');
            }, false);
        });
    })();
</script>

<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/plug-ins/1.10.25/i18n/Portuguese-Brasil.json"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

<script>
    // Inicializa o DataTable
    $(document).ready(function () {
        $('#soldadoTable').DataTable({
            "language": {
                "url": "//cdn.datatables.net/plug-ins/1.10.25/i18n/Portuguese-Brasil.json"
            },
            "responsive": true
        });
    });
</script>
</body>
</html>

