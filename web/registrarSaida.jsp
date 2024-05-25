<%@ page import="java.sql.*, java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Saída</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10/dist/sweetalert2.min.css">
</head>
<body>
<%
// Recupere o ID da escala para a qual deseja registrar a saída
int idEscala = Integer.parseInt(request.getParameter("idEscala"));
Integer idUsuarioLogado = (Integer) session.getAttribute("idUsuario");

try {
    if (idUsuarioLogado != null) {
        int idUsuario = idUsuarioLogado.intValue();

        // Carregar o driver JDBC e estabelecer a conexão com o banco de dados
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/soldiers?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");

        // Verificar se já existe um registro de entrada para esta escala
        String verificaQuery = "SELECT * FROM registro_entrada_saida WHERE id_usuario = ? AND id_registro = ? AND data_hora_entrada IS NOT NULL";
        try (PreparedStatement verificaStmt = conn.prepareStatement(verificaQuery)) {
            verificaStmt.setInt(1, idUsuario);
            verificaStmt.setInt(2, idEscala);
            ResultSet verificaRs = verificaStmt.executeQuery();

            if (verificaRs.next()) {
                // Verificar se a saída já foi registrada
                Timestamp dataHoraSaida = verificaRs.getTimestamp("data_hora_saida");
                if (dataHoraSaida == null) {
                    // Saída ainda não registrada, prossiga com o registro
                    String updateQuery = "UPDATE registro_entrada_saida SET data_hora_saida = NOW() WHERE id_usuario = ? AND id_registro = ?";
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                        updateStmt.setInt(1, idUsuario);
                        updateStmt.setInt(2, idEscala);
                        updateStmt.executeUpdate();
%>
                        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                        <script>
                            Swal.fire({
                                icon: 'success',
                                title: 'Sucesso!',
                                text:'Saída registrada com sucesso.',
                                confirmButtonText: 'OK'
                            }).then(function() {
                                window.location.href = document.referrer; // Volta para a página anterior
                            });
                        </script>
<%
                    }
                } else {
                    // Saída já registrada, mostre um alerta informando
%>
                    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                    <script>
                        Swal.fire({
                            icon: 'error',
                            title: 'Erro',
                            text: 'Já há uma saída registrada para esta escala.',
                            confirmButtonText: 'OK'
                        }).then(function() {
                            window.location.href = document.referrer; // Volta para a página anterior
                        });
                    </script>
<%
                }
            } else {
                // Nenhum registro de entrada encontrado para esta escala
%>
                <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                <script>
                    Swal.fire({
                        icon: 'error',
                        title: 'Erro',
                        text: 'Nenhum registro de entrada encontrado para esta escala.',
                        confirmButtonText: 'OK'
                    }).then(function() {
                        window.location.href = document.referrer; // Volta para a página anterior
                    });
                </script>
<%
            }

            verificaRs.close();
        }

        // Fechar a conexão com o banco de dados
        conn.close();
    } else {
        // O atributo idUsuario não está definido na sessão
%>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
        <script>
            Swal.fire({
                icon: 'error',
                title: 'Erro',
                text: 'Usuário não autenticado.',
                confirmButtonText: 'OK'
            }).then(function() {
                window.location.href = document.referrer; // Volta para a página anterior
            });
        </script>
<%
    }
} catch (Exception e) {
    // Imprimir rastreamento de pilha em caso de exceção
    e.printStackTrace();
%>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <script>
        Swal.fire({
            icon: 'error',
            title: 'Erro',
            text: 'Ocorreu um erro inesperado. Por favor, tente novamente.',
            confirmButtonText: 'OK'
        }).then(function() {
            window.location.href = document.referrer; // Volta para a página anterior
        });
    </script>
<%
}
%>
</body>
</html>
